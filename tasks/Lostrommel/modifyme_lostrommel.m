%----------------------------------------------------------------------------
%        MAIN FILE TO EDIT For Lostrommel Task
%
%        This is the only file that should demand any changes!!!
%      
%
%        Task-structure gets loaded in subscript "expparams" and if changed 
%        needs to be located in exp-folder
%----------------------------------------------------------------------------
fprintf('............ Setting basic parameters according to \n')
fprintf('............            MODIFYME.M\n'); fprintf('............ \n')

%----------------------------------------------------------------------------
%        Subject Information 
%--------------------------------------------------------------------------

type = 'DRMH';      % 'DRM' always, afterwards 'H' for controls, and 'S' for patients
subid = '07';      % Subject Number, here called ID, two positions, starts with 01

doinstr     = 0; % 0: no instructions, just the experiment inside or outside the scanner
                 % 1: instructions and training
                 
debug_mode  = 0;

%----------------------------------------------------------------------------
%        If set doscanner=1 exp will wait for the first trigger 
%        of the MR scanner and keys are different
%        If set doscanner=0, then do training + instructions 
%----------------------------------------------------------------------------
doscanner   = 1; % 0: outside the scanner 
                 % 1: inside the scanner 
                 
MirrorDisplay = 1; % display needs to be mirror-inverted  
               
run         = 1;   % which run starts is pseudorandomized according to Random_Lostrommel_xls
                   % 0: practice session;
                   % 1: fMRI Run 1;
                   % 2: fMRI Run 2;

payment = 0;        % is this subject being paid / should payment info be displayed
                    % at the end? Set this to zero for training!


