%----------------------------------------------------------------------------
%           Experimental Parameters
%           DO NOT MODIFY between subjects within one experiment
%----------------------------------------------------------------------------

%% timing 
Z.cue_display_time = 0.5;
Z.fixation_cross_time_post_cue = 0.5; 
Z.maxpredtime = 3.5;
Z.feedback_display_time = 1;
Z.tooslow = 1.5;
Z.Ntrials = 42;
Z.dur_end_baseline = 10;

timing = load('ITI_mean3-5_n42.mat', 'ISI');
ITI = timing.ISI(randperm(length(timing.ISI)));
timing = load('ISI_mean2-7_n42.mat', 'ISI');
ISI = timing.ISI(randperm(length(timing.ISI))); % time between prediction and feedback

%% ntrials

if doinstr == 1 Z.Ntrials = 10; %for practice outside scanner
elseif doinstr == 1 && doscanner == 1 Z.Ntrials = 10; %practice inside scanner
elseif doscanner == 1 Z.Ntrials == 42; %for each run ntrials = 42
end   

%% reward settings
% load full task distribution from Kelly
file = fullfile(taskdir, 'AdaptivePE_task_distributions.mat'); 
load(file) 
% implement our distribution, previously for fmri = 1, always 4-6 trials
counterbalance_conditions;


if run == 1 
        reward = run1(:,1); 
elseif run == 2
        reward = run2(:,1);
elseif doinstr == 1 
        reward = blocks(:,7);
elseif doinstr == 0 
        reward = blocks(:,7);
end

   
%% keys and display settings (multiple screens and mirror-inverted) %%
KbName('UnifyKeyNames');
trigger = '5';
spaceKey = KbName('space');

% if dojoystick == 0
    leftKey = KbName('LeftArrow');
    rightKey = KbName('RightArrow');


% if exist('data_rev')~=7; eval(['!mkdir data_rev']); end % make 'data' folder if dosn't exist
% if exist('data_incomplete')~=7; eval(['!mkdir data_incomplete']); end % make 'data' folder if dosn't exist

%% prepare file names

if doinstr == 1 && run == 0
    outputname = [subid,'_behavior_block',num2str(7), '_', datestr(now, 'mm-dd-yyyy-HH-MM')];
elseif doinstr == 0 && doscanner == 0
    outputname = fullfile([subid,'_prac_fmri_session_',num2str(run), '_', datestr(now, 'mm-dd-yyyy-HH-MM'),'.txt']);
elseif doscanner == 0 && run == 1
    outputname = fullfile([subid,'_fmri_session_',num2str(run), '_', datestr(now, 'mm-dd-yyyy-HH-MM'),'.txt']);
elseif doscanner == 1 && run == 1
    outputname = fullfile([subid,'_fmri_session_',num2str(run), '_', datestr(now, 'mm-dd-yyyy-HH-MM'),'.txt']);
elseif doscanner == 1 && run == 2
    outputname = fullfile([subid,'_fmri_session_',num2str(run), '_', datestr(now, 'mm-dd-yyyy-HH-MM'),'.txt']);
end

fprintf('............ Data will be saved as                              \n');
fprintf('............ %s \n',outputname);
fprintf('............ in the folder ''data_lostrommel''\n');
