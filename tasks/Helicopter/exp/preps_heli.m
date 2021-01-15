%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Setup %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aborted=0; % if this parameter is set to one, things will abort. 

% make sure we use different random numbers
rand('twister',sum(1000*clock));

%....................... Saving 
namestring_long  = ['Heli_' '_' type '_' subjn '_' 'run' num2str(run) '_' datestr(now,'yymmdd_HHMM')]; % detailed name string
namestring_short = ['Heli_' '_' type '_' subjn '_' 'run' num2str(run)];                                % simplified name string 

if doinstr; namestring_short = [namestring_short '_training'];namestring_long = [namestring_long '_training'];end

% if exist('data_rev')~=7; eval(['!mkdir data_rev']); end % make 'data' folder if dosn't exist
% if exist('data_incomplete')~=7; eval(['!mkdir data_incomplete']); end % make 'data' folder if dosn't exist

if dosave 
	fprintf('............ Data will be saved as                              \n');
	fprintf('............ %s and %s \n',namestring_long,namestring_short);
	fprintf('............ in the folder ''data_heli''\n');
end

% setup variables
% S   = Z.state;
% p_u = Z.prob_events;

% A=zeros(1,Z.Ntrials); 
% C=zeros(1,Z.Ntrials);
% R=NaN(1,Z.Ntrials);

% define random numbers
% random_lr               = (rand(1,Z.Ntrials)>0.5)+1;	% left or right 
