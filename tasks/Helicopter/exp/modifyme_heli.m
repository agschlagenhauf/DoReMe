%----------------------------------------------------------------------------
%        MAIN FILE TO EDIT For Heli Task
%
%        This is the only file that should demand any changes!!!
%      
%
%        Task-structure gets loaded in subscript "expparams" and if changed 
%        needs to be located in exp-folder and must 
%        contain the variables task_struc, p_u and state!!!
%----------------------------------------------------------------------------
fprintf('............ Setting basic parameters according to \n')
fprintf('............            MODIFYME.M\n'); fprintf('............ \n')

doinstr     = 0; % 0: no instructions, just the experiment inside or outside the scanner
                 % 1: instructions and training in German
                 % 2: instructions and training in English
                 % 3: instructions and training inside scanner
                 
debug_mode  = 0;

%----------------------------------------------------------------------------
%        If set doscanner=1 exp will wait for the first trigger 
%        of the MR scanner and keys are different
%        If set doscanner=0, then do training + instructions 
%----------------------------------------------------------------------------
doscanner   = 1; % 0: outside the scanner 
                 % 1: inside the scanner 
                 
MirrorDisplay = 1; % display needs to be mirror-inverted  
               
run         = 4;   % 0: practice session;
                   % 1: fMRI Run 1;
                   % 2: fMRI Run 2;
                   % 3: fMRI Run 3;
                   % 4: fMRI Run 4;
     
%----------------------------------------------------------------------------
%        To save or not to save
%        This should ALWAYS be set to 1 when doing experiments obviously
%----------------------------------------------------------------------------
dosave = 1;      % save output? 

%----------------------------------------------------------------------------
%        Patient Information 
%--------------------------------------------------------------------------

type = 'test';      % 'DRM' always, afterwards 'H' for controls, and 'S' for patients

subjn = '02a';       % Subject Number, two positions, starts with 01

payment = 0;      % is this subject being paid / should payment info be displayed
                  % at the end? Set this to zero for training!


