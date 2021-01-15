spm_jobman('initcfg');
clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_path                    = 'F:\';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
master_job           = spm_select(1, 'batch', 'Choose masterjob for Heli preprocessing ', '', pwd);

list_sub_data_paths = spm_select(inf, 'dir', 'Choose subject folder for Heli PreProc (eg. DRMHXXBCAN)','',  data_path);
n_failed = 0; 

filename = 'logfile_PreProc_Heli.txt';
id = fopen(fullfile(data_path,filename), 'a');


for sub = 1:length(list_sub_data_paths(:,1)) 
    try
    t = datetime('now');
    DateString = datestr(t);
    
    s                   = strread(list_sub_data_paths(sub,:), '%s','delimiter', '\\');
    subjects{sub}       = s{end};
   
   sub_data_path          = cellstr(fullfile(list_sub_data_paths(sub,:))); 
   sub_paradigm_path      = cellstr(fullfile(list_sub_data_paths(sub,:), 'Heli')); 
   sub_epi_path_run1      = cellstr(fullfile(sub_paradigm_path, 'func', 'run1'));
   sub_epi_path_run2      = cellstr(fullfile(sub_paradigm_path, 'func', 'run2'));
   sub_epi_path_run3      = cellstr(fullfile(sub_paradigm_path, 'func', 'run3'));
   sub_epi_path_run4      = cellstr(fullfile(sub_paradigm_path, 'func', 'run4'));
   
   file_name_mpr            = spm_select('list',  fullfile(sub_paradigm_path, 'anat'), '^s.*\.nii');
   file_fieldmap_AP_1       = spm_select('list',  fullfile(sub_paradigm_path', 'fmap','run1','SpinEchoFieldMap_AP'), '^f.*\.nii');
   file_fieldmap_PA_1       = spm_select('list',  fullfile(sub_paradigm_path', 'fmap','run1', 'SpinEchoFieldMap_PA'), '^f.*\.nii');
   file_fieldmap_AP_2       = spm_select('list',  fullfile(sub_paradigm_path', 'fmap','run2','SpinEchoFieldMap_AP'), '^f.*\.nii');
   file_fieldmap_PA_2       = spm_select('list',  fullfile(sub_paradigm_path', 'fmap','run2', 'SpinEchoFieldMap_PA'), '^f.*\.nii');
   file_fieldmap_AP_3       = spm_select('list',  fullfile(sub_paradigm_path', 'fmap','run3','SpinEchoFieldMap_AP'), '^f.*\.nii');
   file_fieldmap_PA_3       = spm_select('list',  fullfile(sub_paradigm_path', 'fmap','run3', 'SpinEchoFieldMap_PA'), '^f.*\.nii');
   file_fieldmap_AP_4       = spm_select('list',  fullfile(sub_paradigm_path', 'fmap','run4','SpinEchoFieldMap_AP'), '^f.*\.nii');
   file_fieldmap_PA_4       = spm_select('list',  fullfile(sub_paradigm_path', 'fmap','run4', 'SpinEchoFieldMap_PA'), '^f.*\.nii');

   file_first_epi         = spm_select('list',  fullfile(sub_epi_path_run1), '^f.*\.nii');
   file_first_epi_run1    = file_first_epi(1,:);  
   file_first_epi         = spm_select('list',  fullfile(sub_epi_path_run2), '^f.*\.nii');
   file_first_epi_run2    = file_first_epi(1,:); 
   file_first_epi         = spm_select('list',  fullfile(sub_epi_path_run3), '^f.*\.nii');
   file_first_epi_run3    = file_first_epi(1,:); 
   file_first_epi         = spm_select('list',  fullfile(sub_epi_path_run4), '^f.*\.nii');
   file_first_epi_run4    = file_first_epi(1,:); 
   
   sub_mpr_file          = cellstr(fullfile(sub_paradigm_path, 'anat', file_name_mpr));
   
   fieldmap_AP_1           = cellstr(fullfile(sub_paradigm_path', 'fmap','run1', 'SpinEchoFieldMap_AP', file_fieldmap_AP_1));
   fieldmap_PA_1           = cellstr(fullfile(sub_paradigm_path', 'fmap','run1', 'SpinEchoFieldMap_PA', file_fieldmap_PA_1));
   fieldmap_AP_2           = cellstr(fullfile(sub_paradigm_path', 'fmap','run2', 'SpinEchoFieldMap_AP', file_fieldmap_AP_2));
   fieldmap_PA_2           = cellstr(fullfile(sub_paradigm_path', 'fmap','run2', 'SpinEchoFieldMap_PA', file_fieldmap_PA_2));
   fieldmap_AP_3           = cellstr(fullfile(sub_paradigm_path', 'fmap','run3', 'SpinEchoFieldMap_AP', file_fieldmap_AP_3));
   fieldmap_PA_3           = cellstr(fullfile(sub_paradigm_path', 'fmap','run3', 'SpinEchoFieldMap_PA', file_fieldmap_PA_3));
   fieldmap_AP_4           = cellstr(fullfile(sub_paradigm_path', 'fmap','run4', 'SpinEchoFieldMap_AP', file_fieldmap_AP_4));
   fieldmap_PA_4           = cellstr(fullfile(sub_paradigm_path', 'fmap','run4', 'SpinEchoFieldMap_PA', file_fieldmap_PA_4));
   
   first_epi_run1        = cellstr(fullfile(sub_epi_path_run1, file_first_epi_run1));
   first_epi_run2        = cellstr(fullfile(sub_epi_path_run2, file_first_epi_run2));
   first_epi_run3        = cellstr(fullfile(sub_epi_path_run3, file_first_epi_run3));
   first_epi_run4        = cellstr(fullfile(sub_epi_path_run4, file_first_epi_run4));
   
   cd(sub_epi_path_run4{1})
    
   [output_list, hjob]  = spm_jobman('serial', master_job, '', sub_epi_path_run1, sub_epi_path_run2,sub_epi_path_run3, sub_epi_path_run4, first_epi_run1, first_epi_run2, first_epi_run3, first_epi_run4, fieldmap_AP_1, fieldmap_PA_1,fieldmap_AP_2,fieldmap_PA_2, fieldmap_AP_3, fieldmap_PA_3,fieldmap_AP_4,fieldmap_PA_4, sub_mpr_file);
   save output_list
   save hjob
   
            fprintf(id, '\n %s PrePorc of %s ran successfully %s\n', subjects{sub}, DateString);
    
    catch
            % log file
            fprintf(id, '\n %s PrePorc of %s FAILURE %s\n', subjects{sub}, DateString);    
    end   
end
%end
fclose('all');
cd(data_path); 



    
      