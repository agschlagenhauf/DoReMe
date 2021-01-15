%----------------------------------------------------------------------------
%           Experimental Parameters
%           DO NOT MODIFY between subjects within one experiment
%----------------------------------------------------------------------------

%% timing 
Z.rating_duration   = 3; % max. time allowed to perform a rating
Z.TimeBagDrop       = .5;
Z.fb_duration       = 1; 
Z.beep              = 0.2; 
Z.TooSlow           = 2;
Z.dur_end_baseline  = 10;

if doinstr == 1 || doinstr == 2; Z.Ntrials = 20; 
    catch_trial = [1 1 1 1 1, 0 0 0 0 0, 0 0 0 0 0 0 0 0 0 0];

elseif doinstr == 3; Z.Ntrials = 10; 
    catch_trial = zeros(Z.Ntrials,1)';

else Z.Ntrials=70; 
    catch_trial = zeros(Z.Ntrials,1)'; % no catch trials during main experiment
%     catch_trial = repmat([0 1]', Z.Ntrials/2, 1)'; catch_trial = catch_trial(randperm(Z.Ntrials)); %prepare         
end   

%% task-specific variables %%

% generate bag locations from random means and predefined noise with hazard rate 

if run == 0
load ('bag_location_100_P.mat', 'bag_location_100');
elseif run == 1
load ('bag_location_100_A.mat', 'bag_location_100');
elseif run == 2
load ('bag_location_100_B.mat', 'bag_location_100');
elseif run == 3
load ('bag_location_100_C.mat', 'bag_location_100');
elseif run == 4
load ('bag_location_100_D.mat', 'bag_location_100');
end

% noise = ones(Z.Ntrials)*2;
% noise_level = [5 15];
% hazard_rate = 0.125;
% 
% criterion = 0;
% while ~criterion
%     m = round(rand(1)*100);
%     first_three = 0;
%     for nt=1:Z.Ntrials
% 
%         bag_location_100(nt) = m + rand * noise_level(noise(nt));
%         first_three = first_three + 1;
% 
%         if first_three > 3 && rand < hazard_rate 
%             m = round(rand(1)*100);
%             first_three = 0;
%         end
% 
%     end
%     criterion = ~sum(bag_location_100 > 100) && ~sum(bag_location_100 < 0)
% end
% bag_location_100 = rand(Z.Ntrials,1)*100; % only placeholder: randomly sampled bag locations from 0 to 100

%randomize bag type = reward (1: euro_bag; 2: neutral)
bag_type = [1, 2]; bag_type = repmat(bag_type, Z.Ntrials/2,1)'; bag_type = bag_type(randperm(Z.Ntrials));

x_bucket_start(1) = 50;
x_bucket_start_100(1) = 50; % positions of bucket on the rating scale at x=0
bucket_size_100 = 10; 
heli_rating = NaN(Z.Ntrials,1)'; %prepare empty vector to be filled trialwise with prediction error
bag_caught = NaN(Z.Ntrials,1)';    % prepare empty vectors for caught bags of both types


                        
% define threshold for Joystick movement to result in bucket movement
Z.joystick_threshold = 0.1;
   

%% keys and display settings (multiple screens and mirror-inverted) %%
    KbName('UnifyKeyNames');

    escapebutton  = 'esc';        % escape button to abort experiment
    instrbackward = 'LeftArrow';  % left key for changing instruction page 
    instrforward  = 'RightArrow'; % right key for changing instruction page
    escapeKey = KbName('escape'); % escape button to abort experiment
    spaceKey = KbName ('space');
    
% if doscanner == 0
    keyleft       = 'f';          % left key 
    keyright      = 'j';          % right key 

% elseif doscanner == 1
   keyleft     = 'b';       % left key, responsbox RED   = 4
   keyright    = 'c';       % right key, responsbox BLUE = 1 
   trigger     = '5';       % trigger send from the scanner, equals 5 on numpad

% end    
    
% if dojoystick == 0
    leftKey = KbName('LeftArrow');
    rightKey = KbName('RightArrow');
    spaceKey = KbName ('space');

% elseif dojoystick == 1
    
   leftKey = '4'; % left key, responsebox RED   = 4
   rightKey = '1'; % right key, responsebox BLUE = 1 
   trigger = '5'; % trigger send from the scanner, equals 5 on numpad
   
% end

% Z.ITI = ones(Z.Ntrials)*.001; % ITIs for scanning
% load('ITI_mean_3-5_n70.mat', 'ISI'); % ITI_mean_3-5_n70.mat: mean 3.43 sec, min 1.5 sec, max 8.6 sec
load('ITI_mean_2_n70.mat', 'ITI'); % ITI_mean_2_n70.mat: mean 2 sec, min 1 sec, max 4.8 sec
Z.ITI = ITI(randperm(length(ITI)));

%% payout settings
% 10% of reward trials in which the bag was catched are rewarded with .5 Euros
Z.euros_per_reward=0.5; 
Z.minpayout = 4; % minimal payout in euros
Z.maxpayout = 7; %maximal payout in euros