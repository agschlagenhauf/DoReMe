%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Main shell script 'heli' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; 
clear all;  
close all;
  
modifyme_heli;	% set the subject-specific experimental parameters

expparams_heli  ; %  set parameters that are not specific to subjects 
 
preps_heli; %   prepares some other stuff (?) like file names, empty variables  

% warn and abort if files already exist
cd (fullfile(cd, 'data_heli'))
varname = strcat(namestring_short, '.mat');
assert(exist(varname) ~= 2,'File already exists! Please make sure to have the correct file name in modifyme.m') 
cd ..

cd (fullfile(cd,'data_heli'))
varname = strcat(namestring_long, '.mat');
assert(exist(varname) ~= 2,'File already exists! Please make sure to have the correct file name in modifyme.m') 
cd ..
aborted = 2;

try 	% this is important: if there's an error, psychtoolbox will crash graciously
		% and move on to the 'catch' block at the end, where all screens etc are
		% closed. 

	if ~debug_mode; HideCursor; end;  
       setup_heli;	% set up the psychtoolbox screen and layout parameters 
				% this includes things like positioning of stimuli and loading the
				% stimuli into psychtoolbox; use of split screen; mirror-invert display etc. 
    
    % do instruction 
    if doinstr == 1; HideCursor; instr_heli; nt_start = 11; else nt_start = 1; end
    if doinstr == 2; HideCursor; instr_heli_english; nt_start = 11; else nt_start = 1; end
    if doinstr == 3; HideCursor; instr_heli_inside_scanner; end 
    
     
    if doscanner == 1 && doinstr == 0; initialwait; end% wait for fMRI trigger
    % main experimental loop
    for nt      = nt_start:Z.Ntrials
     	heli_trial
    end
    T.exp_end = GetSecs;
	    
    if doscanner == 1 && doinstr == 0; finalwait; end    
    if payment == 1 && doinstr == 0 && run == 4; instr_payment; end
    if ~doinstr; WaitSecs(3-monitorFlipInterval); end

% ---------------------------------------------------------------------------    
	fprintf('saving heli task in three separate files\n');
    
	if dosave; eval(['save data_heli' filesep namestring_long '_WS.mat']);end
	savepath = ['data_heli' filesep namestring_long];
    if dosave; eval('save(savepath, ''bag_location'',''position_bucket'',''x_bucket_start'',''catch_trial'',''bag_type'',''bag_caught'',''T'',''Z'')');end 
    savepath = ['data_heli' filesep namestring_short];
    if dosave; eval('save(savepath, ''bag_location'',''position_bucket'',''x_bucket_start'',''catch_trial'',''bag_type'',''bag_caught'',''T'',''Z'')');end 
    
% bag_location(nt)
% x_bucket_start(nt): position form trial before
% catch_trial(nt): clouds or not
% bag_type(nt): reward or neutral


%     ShowCursor; % show the mouse cursor again 
	Screen('CloseAll');
    PsychPortAudio('Close', pahandle);
    fprintf('.........done\n')
    
catch % execute this if there's an error, or if we've pressed the escape key
      Screen('CloseAll'); % close psychtoolbox, return screen control to OSX
      ShowCursor;
      if     aborted==0;	 % if there was an error
		     fprintf(' ******************************\n')
		     fprintf(' **** Something went WRONG ****\n')
		     fprintf(' ******************************\n')
		     if dosave; eval(['save data_incomplete' filesep namestring_long '.crashed.mat;']);end
      elseif aborted==1; % if we've aborted by pressing the escape key
		     fprintf('                               \n')
		     fprintf(' ******************************\n')
		     fprintf(' **** Experiment aborted ******\n')
		     fprintf(' ******************************\n')
		     if dosave; eval(['save data_incomplete' filesep namestring_long  '.aborted.mat;']);end
      end
      if dosave;  eval(['save data_incomplete' filesep namestring_long '-' date '.mat;']); fclose('all');end
         rethrow(lasterror)
end