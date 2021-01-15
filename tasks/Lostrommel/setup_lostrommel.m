%PsychDebugWindowConfiguration % debug mode
fprintf('............ Setting up the screen   \n');

%% Set colors
        background_color = [127 127 127];
        black_color = [0 0 0];
        grey_color = [105 105 105];
        blue_color = [0 0 102];
        green_color = [0 255 0]; 
        red_color = [153 0 0];
        txtcolor 	= black_color;
        rect_ScreenSize = get(0,'ScreenSize');
        
        max_txtsize = 40;
        txt_fix     = 40;       % text size fixation cross 

%% Screen settings

% open a screen
AssertOpenGL;
Screen('Preference','Verbosity',0);
scrAll = Screen('Screens');
scrNum = max(scrAll);
% [wd, rect] = Screen('OpenWindow',scrNum);


if debug_mode; 
    Screen('Preference','SkipSyncTests',2); % ONLY do this for quick debugging;
    PsychDebugWindowConfiguration % debug mode 	
    [window, rect] = Screen('OpenWindow',scrNum);
    HideCursor(scrNum);
else
    Screen('Preference','SkipSyncTests',2); % ONLY do this for quick debugging;
    [window, rect] = Screen('OpenWindow',scrNum);
    HideCursor(scrNum);
end

Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

KbName('UnifyKeyNames');    
%     Screen('Preference', 'SkipSyncTests', 0); 
%     
%     screen = 1;
%     if screen == 0
%         [window, rect] = Screen('OpenWindow', 0, background_color);%, rect);
%     else
%         [window, rect] = Screen('OpenWindow', 1, background_color, [],[],2, []);
%     end
[wdw, wdh]=Screen('WindowSize', window);	% Get screen size  
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
%   Screen('TextSize',window,txtsize); 
%      txtsize     = round(screenYpixels/12);            % relative text size: adjust text size to screen size
%      if txtsize>max_txtsize; txtsize=max_txtsize; end;
   
     txtsize     = round(wdh/12);            % relative text size: adjust text size to screen size
if txtsize>max_txtsize; txtsize=max_txtsize; end; % enforce maximal text size here
Screen('TextSize',window,txtsize);			% Set size of text

   
      if MirrorDisplay  % from DrawMirroredTextDemo.m
        % Make a backup copy of the current transformation matrix for later
        % use/restoration of default state:
        % Screen('glPushMatrix', wd); % not needed 

        % Translate origin into the geometric center of text:
        Screen('glTranslate', window, screenXpixels/2, screenYpixels/2, 0);
        
        % Apply a scaling transform which flips the diretion of x-Axis,
        % thereby mirroring the drawn text horizontally:
        upsideDown = 0;
        if upsideDown
            Screen('glScale', window, 1, -1, 1);
        else
            Screen('glScale', window, -1, 1, 1);
        end
        
        % We need to undo the translations...
        Screen('glTranslate', window, -screenXpixels/2, -screenYpixels/2, 0);
   end % MirrowDisplay

   [monitorFlipInterval nrValidSamples stddev] = Screen('GetFlipInterval', window);
%% prepare screen
      
    % find screen coordinates
        rect = struct('x0', rect(1), 'x1', rect(3),'y0', rect(2), 'y1', rect(4));

        xmiddle = (rect.x1 - rect.x0)/2 + rect.x0;
        ymiddle = (rect.y1 - rect.y0)/2 + rect.y0;

        width = 30;

        cursor_siz = screenXpixels/150;
        cursor_width = screenXpixels/150;

        scr_height = rect.y1 - rect.y0;

%% Scale preparations

    %function line = create_vertical_line(xmiddle, y, width)        

        ybottom = rect.y0 + .2 * scr_height;
        ytop = rect.y1 - .2 * scr_height;
        x = (rect.x1 - rect.x0)/2 + rect.x0;
        vert_line = struct('x0', x, 'y0', ybottom, 'x1', x, 'y1', ytop);
        
    % limit where cursor can go
        lower_limit = vert_line.y1;
        upper_limit = vert_line.y0;

    % function line = create_horizonal_line(xmiddle, y, width)
        hor_line = struct();
        hor_line.x0 = xmiddle - width/2;
        hor_line.y0 = ymiddle;
        hor_line.x1 = xmiddle + width/2;
        hor_line.y1 = ymiddle;
    
    % create limiting lines at top and bottom, only for design reasons
        hor_bottom_line = struct();
        hor_bottom_line.x0 = xmiddle - width/2;
        hor_bottom_line.y0 = ybottom;
        hor_bottom_line.x1 = xmiddle + width/2;
        hor_bottom_line.y1 = ybottom;

        hor_top_line = struct();
        hor_top_line.x0 = xmiddle - width/2;
        hor_top_line.y0 = ytop;
        hor_top_line.x1 = xmiddle + width/2;
        hor_top_line.y1 = ytop;   

    % create middle horizontal line, only for design reasons
        hor_middle_line = struct();
        hor_middle_line.x0 = xmiddle - width/2;
        hor_middle_line.y0 = ymiddle;
        hor_middle_line.x1 = xmiddle + width/2;
        hor_middle_line.y1 = ymiddle;     
    
    % create cursor
        siz = screenXpixels/150;
        width = screenXpixels/150;

%% load cue images and make textures
        imageS = imread(fullfile(imgsdir,'low_SD_fMRI_G.png'));
        imageL = imread(fullfile(imgsdir,'high_SD_fMRI_G.png'));

        textS=Screen('MakeTexture', window,imageS);
        textL=Screen('MakeTexture', window,imageL);
        
yposm = 'center'; 
yposb = .8*wdh; 
ypost = .1*wdh; 
ypostt=.05*wdh;
     