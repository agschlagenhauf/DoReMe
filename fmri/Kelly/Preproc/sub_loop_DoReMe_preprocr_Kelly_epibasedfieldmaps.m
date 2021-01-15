spm_jobman('initcfg');
clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_path                    = 'F:\';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
master_job           = spm_select(1, 'batch', 'Choose masterjob for Kelly preprocessing ', '', pwd);

list_sub_data_paths = spm_select(inf, 'dir', 'Choose subject folder for Kelly PreProc','',  data_path);
n_failed = 0; 

filename = 'logfile_Kelly.txt';
id = fopen(fullfile(data_path,filename), 'a');

for sub = 1:length(list_sub_data_paths(:,1)) 
    try
    t = datetime('now');
    DateString = datestr(t);
    s                   = strread(list_sub_data_paths(sub,:), '%s','delimiter', '\\');
    subjects{sub}       = s{end};
   
   sub_data_path          = cellstr(fullfile(list_sub_data_paths(sub,:))); 
   sub_paradigm_path      = cellstr(fullfile(list_sub_data_paths(sub,:), 'Kelly')); 
   sub_epi_path_run1      = cellstr(fullfile(sub_paradigm_path, 'func', 'run1'));
   sub_epi_path_run2      = cellstr(fullfile(sub_paradigm_path, 'func', 'run2'));
   
   file_name_mpr          = spm_select('list',  fullfile(sub_paradigm_path, 'anat'), '^s.*\.nii');
   file_fieldmap_AP_1       = spm_select('list',  fullfile(sub_paradigm_path', 'fmap','run1','SpinEchoFieldMap_AP'), '^f.*\.nii');
   file_fieldmap_PA_1       = spm_select('list',  fullfile(sub_paradigm_path', 'fmap','run1', 'SpinEchoFieldMap_PA'), '^f.*\.nii');
   file_fieldmap_AP_2       = spm_select('list',  fullfile(sub_paradigm_path', 'fmap','run2','SpinEchoFieldMap_AP'), '^f.*\.nii');
   file_fieldmap_PA_2       = spm_select('list',  fullfile(sub_paradigm_path', 'fmap','run2', 'SpinEchoFieldMap_PA'), '^f.*\.nii');
   file_first_epi         = spm_select('list',  fullfile(sub_epi_path_run1), '^f.*\.nii');
   file_first_epi_run1    = file_first_epi(1,:);  
   file_first_epi         = spm_select('list',  fullfile(sub_epi_path_run2), '^f.*\.nii');
   file_first_epi_run2    = file_first_epi(1,:);  
   
   sub_mpr_file          = cellstr(fullfile(sub_paradigm_path, 'anat', file_name_mpr));
   fieldmap_AP_1           = cellstr(fullfile(sub_paradigm_path', 'fmap','run1', 'SpinEchoFieldMap_AP', file_fieldmap_AP_1));
   fieldmap_PA_1           = cellstr(fullfile(sub_paradigm_path', 'fmap','run1', 'SpinEchoFieldMap_PA', file_fieldmap_PA_1));
   fieldmap_AP_2           = cellstr(fullfile(sub_paradigm_path', 'fmap','run2', 'SpinEchoFieldMap_AP', file_fieldmap_AP_2));
   fieldmap_PA_2           = cellstr(fullfile(sub_paradigm_path', 'fmap','run2', 'SpinEchoFieldMap_PA', file_fieldmap_PA_2));
   first_epi_run1        = cellstr(fullfile(sub_epi_path_run1, file_first_epi_run1));
   first_epi_run2        = cellstr(fullfile(sub_epi_path_run2, file_first_epi_run2));

   cd(sub_epi_path_run2{1});
   [output_list, hjob]  = spm_jobman('serial', master_job, '', sub_epi_path_run1, sub_epi_path_run2,sub_mpr_file, first_epi_run1, first_epi_run2, fieldmap_AP_1, fieldmap_PA_1,fieldmap_AP_2,fieldmap_PA_2);
   save output_list
   save hjob
   
    fprintf(id, '\n %s PrePorc of %s ran successfully %s\n', subjects{sub}, DateString);
    
    catch
            % log file
    fprintf(id, '\n %s PrePorc of %s FAILURE %s\n', subjects{sub}, DateString);    
    end   
   
end
fclose('all');
cd(data_path); 



    
      