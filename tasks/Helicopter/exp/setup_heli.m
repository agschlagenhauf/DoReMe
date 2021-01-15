% PsychDebugWindowConfiguration % debug mode
fprintf('............ Setting up the screen   \n');

%% colours (in RBG)
    yellowish   = [255 153 51];
    white 		= [200 200 200];
    red 		= [255 20 20]; 
    blue 		= [120 0 255]; 
    green 		= [0 135 00]; 
    black       = [0 0 0];
    grey 		= [160 160 160]; 

    backcolor = grey; % set background color to black

    crosscolor = black; % set fixation and text color to white
    crosscolor_iti = black;

    txtcolor 	= black;
    blw         = .2;       % width of stimulus as fraction of **xfrac**
    blh         = .2;       % height of stimulus as fraction of **xfrac**
    max_txtsize = 40;       % text size is determined relative to screen resolution but maximum if defined here; 40  
    txt_fix     = 40;       % text size fixation cross 

%% PTB specifics (synch, keys, open screen,...)

% get version of Psychtoolbox and matlab to be saved as workspace variables
Version_Psychtoolbox = PsychtoolboxVersion;
Version_matlab = version;

% open a screen
AssertOpenGL;
Screen('Preference','Verbosity',0);
scrAll = Screen('Screens');
scrNum = max(scrAll);
% [wd, rect] = Screen('OpenWindow',scrNum);

if debug_mode; 
    Screen('Preference','SkipSyncTests',2); % ONLY do this for quick debugging;
    PsychDebugWindowConfiguration % debug mode 	
    [wd, rect] = Screen('OpenWindow',scrNum);
    HideCursor(scrNum);
else
    Screen('Preference','SkipSyncTests',2); % ONLY do this for quick debugging;
    [wd, rect] = Screen('OpenWindow',scrNum);
    HideCursor(scrNum);
end
Screen('BlendFunction', wd, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

KbName('UnifyKeyNames');                    % need this for KbName to behave

% Do dummy calls to GetSecs, WaitSecs, KbCheck to make sure
% they are loaded and ready when we need them - without delays
% in the wrong moment:
KbCheck;
WaitSecs(0.01);
GetSecs;

% Set priority for script execution to realtime priority:
priorityLevel = MaxPriority(wd, ['GetSecs'],['WaitSecs'],['KbCheck'],['KbWait']);
Priority(priorityLevel);

%% screen layout

[wdw, wdh]=Screen('WindowSize', wd);	% Get screen size 
txtsize     = round(wdh/12);            % relative text size: adjust text size to screen size
if txtsize>max_txtsize; txtsize=max_txtsize; end; % enforce maximal text size here
Screen('TextSize',wd,txtsize);			% Set size of text

[screenXpixels, screenYpixels] = Screen('WindowSize', wd); % get size of on screen window
[xCenter, yCenter] = RectCenter(rect); % get centre of screen
Screen('BlendFunction', wd, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA'); % set up alpha-blending for smooth (anti-aliased) lines

ifi = Screen('GetFlipInterval', wd); % query the frame duration
waitframes = 1;
framesFactor = 20;

if MirrorDisplay  % from DrawMirroredTextDemo.m
        % Make a backup copy of the current transformation matrix for later
        % use/restoration of default state:
        % Screen('glPushMatrix', wd); % not needed 

        % Translate origin into the geometric center of text:
        Screen('glTranslate', wd, wdw/2, wdh/2, 0);
        
        % Apply a scaling transform which flips the diretion of x-Axis,
        % thereby mirroring the drawn text horizontally:
        upsideDown = 0;
        if upsideDown
            Screen('glScale', wd, 1, -1, 1);
        else
            Screen('glScale', wd, -1, 1, 1);
        end
        
        % We need to undo the translations...
        Screen('glTranslate', wd, -wdw/2, -wdh/2, 0);
end


%% audio variables

    InitializePsychSound    
    nrchannels = 1;
    freq = 48000;    
    repetitions = 1;    
    startCue = 0;
    waitForDeviceStart = 1;
    pahandle = PsychPortAudio('Open', [], 1, 0, freq, nrchannels,[],0.05);    
    PsychPortAudio('Volume', pahandle, 0.5);
% optional nicer sounds which where not audible in our scanner setup           
%     [cashsound_f, freq2] = audioread(fullfile('sounds','cashreg.wav'));
%     cashsound = cashsound_f(:)';
%     [fallsound_f, freq2] = audioread(fullfile('sounds','falling.wav'));
%     fallsound = fallsound_f(:)';
    beep1 	= MakeBeep(453*3/4, Z.beep, freq);
    beep2   = MakeBeep(800, Z.beep, freq);
    
%% load images and get their sizes
    background_f = imread(fullfile('imgs','background.jpg'));
    background = imresize(background_f, [screenXpixels NaN]);

    clouds = imread(fullfile('imgs','clouds.tiff'));
    [clouds_height, clouds_width] = size(clouds);

    helicopter_f = imread (fullfile('imgs','helicopter.tiff'));
    helicopter = imresize(helicopter_f, 0.3);
    [heli_height, heli_width,ff] = size(helicopter);

% bag_neutral and bag_euro images need to have the same size 
    bag_neutral_f = imread(fullfile('imgs','bag_neutral.tiff'));
    bag_neutral = imresize(bag_neutral_f, 0.3);
    [bag_neutral_height, bag_neutral_width,ff] = size(bag_neutral);

    bag_euro_f = imread(fullfile('imgs','bag_euro.tiff'));
    bag_euro = imresize(bag_euro_f, 0.3);
    [bag_euro_height, bag_euro_width,ff] = size(bag_euro);
    
    bag_euro_bright_f = imread(fullfile('imgs','bag_euro_bright.tiff'));
    bag_euro_bright = imresize(bag_euro_bright_f, 0.3);
    [bag_euro_bright_height, bag_euro_bright_width,ff] = size(bag_euro_bright);
    
    bag_neutral_bright_f = imread(fullfile('imgs','richtig.tiff'));
    bag_neutral_bright = imresize(bag_neutral_bright_f, 0.3);
    [bag_neutral_bright_height, bag_neutral_bright_width,ff] = size(bag_neutral_bright);
    
%% scales and positions
    scalepos = .75; % position of rating-axis 
    
% Compute coordinates of screen center
    xCenter = rect(3)/2;
    yCenter = rect(4)/2;

    edge_scale = heli_width/2; % not used screen for scale to display full stimuli
    scale_x1 = rect(1)+ edge_scale; 
    scale_x2 = rect(3)- edge_scale;
    scale_y1 = rect(4)*scalepos;
    scale_y2 = rect(4)*scalepos;
    
% Joystick speed 
    pixelsPerPress = (scale_x2 - scale_x1)/100; % movement of rating bar; at quadratic screen: 8, larger screen: 10 (to do full length)
    
% Mouse initialization
HideCursor(scrNum)

% Scale locations to screen and take care of nt using whole screen width
    bag_location   = (rect(3)-edge_scale*2)/100 * bag_location_100 + edge_scale; 
    bucket_size    = (rect(3)-edge_scale*2)/100 * bucket_size_100;
    x_bucket_start = (rect(3)-edge_scale*2)/100 * x_bucket_start_100 + edge_scale;

    highimagepos = .2;
    rightpos = .58;

%% make textures
    
    background_handle = Screen('MakeTexture',wd,background);

    clouds_handle = Screen('MakeTexture',wd,clouds);

    helicopter_handle = Screen('MakeTexture',wd,helicopter);
    heli_y1 = screenYpixels * 0.1; %sets how far helicopter is removed from upper screen edge
    heli_y2 = heli_y1 + size(helicopter,2);
    heli_x1 = NaN(Z.Ntrials);
    heli_x2 = NaN(Z.Ntrials); 

    bag_neutral_handle = Screen('MakeTexture',wd,bag_neutral);
    bag_neutral_y1 = heli_y2; %sets how far bags are removed from heli
    bag_neutral_y2 = bag_neutral_y1 + size(bag_neutral,2); 
    bag_neutral_x1 = NaN(Z.Ntrials);
    bag_neutral_x2 = NaN(Z.Ntrials); 

    bag_euro_handle = Screen('MakeTexture',wd,bag_euro);
    bag_euro_y1 = heli_y2;
    bag_euro_y2 = bag_euro_y1 + size(bag_euro,2);
    bag_euro_x1 = NaN(Z.Ntrials);
    bag_euro_x2 = NaN(Z.Ntrials); 

    bag_euro_bright_handle = Screen('MakeTexture',wd,bag_euro_bright);
    bag_euro_bright_y1 = heli_y2;
    bag_euro_bright_y2 = bag_euro_bright_y1 + size(bag_euro_bright,2);
    bag_euro_bright_x1 = NaN(Z.Ntrials);
    bag_euro_bright_x2 = NaN(Z.Ntrials); 
    
    bag_neutral_bright_handle = Screen('MakeTexture',wd,bag_neutral_bright);
    bag_neutral_bright_y1 = heli_y2;
    bag_neutral_bright_y2 = bag_neutral_bright_y1 + size(bag_neutral_bright,2);
    bag_neutral_bright_x1 = NaN(Z.Ntrials);
    bag_neutral_bright_x2 = NaN(Z.Ntrials); 
    
%% fixation cross coordinates

    lineWidthPix = 4; % line width for fixation cross
    fixCrossDimPix = 10; % size of fixation cross arms
    xCoords = [-fixCrossDimPix fixCrossDimPix 0 0]; 
    yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
    allCoords = [xCoords; yCoords]; % set coordinates for fixation cross

% Create a fixation cross by preparing a little Matlab matrix with the image 
% of a fixation cross

     eval(['tmp=imread(''imgs' filesep 'fix_cross.bmp'');'])
     fix_cross = Screen('MakeTexture',wd,tmp);


%% text in task and instructions 

    wrapatLong = 80; % set max. width for text
    Screen('Preference', 'DefaultFontSize', 35); % default font size

    hightextpos = .3; % position of question (on y axis) in rating
    lowtextpos = scalepos+.1; % position of text (on y axis) in rating-axis

    % monitor frame rate
    [monitorFlipInterval nrValidSamples stddev] = Screen('GetFlipInterval', wd);

    % arrows 
    if doinstr == 1
    eval(['tmp=imread(''imgs' filesep 'arrows.tif'');'])
    else
    eval(['tmp=imread(''imgs' filesep 'arrows_fr.tif'');'])
    end

    arrow=Screen('MakeTexture',wd,tmp);
    arrowsquare(1,:)=[wdw*.02 wdh*.92 wdw*.16 wdh*.98];

    % instructions positions
    addpath('instr_funcs');
    yposm = 'center'; 
    yposb = .8*wdh; 
    ypost = .1*wdh; 
    ypostt=.05*wdh;