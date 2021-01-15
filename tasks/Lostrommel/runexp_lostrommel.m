%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Main shell script 'heli' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% C:\Users\katthagt\Desktop\DoReMe\BCAN\Lostrommel

clc; 
clear all;  
close all;

taskdir = pwd;                       % store current working directory in 'taskdir'
datadir = fullfile(taskdir,'data_lostrommel');  % directory where data is written
imgsdir = fullfile(taskdir,'imgs');  % directory where cue images are

%% load subscripts

modifyme_lostrommel;	% set the subject-specific experimental parameters
expparams_lostrommel  ; % set parameters that are not specific to subjects 


% warn and abort if files already exist
cd (fullfile(cd, 'data_lostrommel'))
varname = strcat(outputname, '.txt');
assert(exist(varname) ~= 2,'File already exists! Please make sure to have the correct file name in modifyme.m') 
cd ..

% cd (fullfile(cd,'data'))
% varname = strcat(namestring_long, '.mat');
% assert(exist(varname) ~= 2,'File already exists! Please make sure to have the correct file name in modifyme.m') 
% cd ..
aborted = 2;

try 	% this is important: if there's an error, psychtoolbox will crash graciously
		% and move on to the 'catch' block at the end, where all screens etc are
		% closed. 

	if ~debug_mode; HideCursor; end;
       setup_lostrommel;	% set up the psychtoolbox screen and layout parameters 
				% this includes things like positioning of stimuli and loading the
				% stimuli into psychtoolbox; use of split screen; mirror-invert display etc. 
    
    % do instruction 
    if doinstr == 1; HideCursor; end %nt_start = 11; else nt_start = 1; end
    if doscanner; initialwait; end %wait for fMRI trigger
    % main experimental loop
    for i      = 1:Z.Ntrials 
     	lostrommel_trial
    end
    
    if doinstr ==1 && doscanner == 1; pracwait; Screen('CloseAll'); end
    T.exp_end = GetSecs;
	% saves WS as well
    WS_savedate = clock;
    
    if doinstr == 1
    save(fullfile(datadir,['WS_', subid,'_fmri_prac_session_', datestr(now, 'mm-dd-yyyy-HH-MM')]))
    Screen('CloseAll');
    end   
    
    if doinstr == 0
    save(fullfile(datadir,['WS_', subid,'_fmri_session_',num2str(run),'_', datestr(now, 'mm-dd-yyyy-HH-MM')]))
    end
    if doscanner == 1 && doinstr == 0; finalwait; end    
    if payment == 1 && doinstr == 0 && run == 2; instr_payment; end
    if ~doinstr; WaitSecs(3-monitorFlipInterval); end

% ---------------------------------------------------------------------------    
    
    
catch % execute this if there's an error, or if we've pressed the escape key
      Screen('CloseAll'); % close psychtoolbox, return screen control to OSX
      ShowCursor;
      if     aborted==0;	 % if there was an error
		     fprintf(' ******************************\n')
		     fprintf(' **** Something went WRONG ****\n')
		     fprintf(' ******************************\n')
      elseif aborted==1; % if we've aborted by pressing the escape key
		     fprintf('                               \n')
		     fprintf(' ******************************\n')
		     fprintf(' **** Experiment aborted ******\n')
		     fprintf(' ******************************\n')
      end
         rethrow(lasterror)
end