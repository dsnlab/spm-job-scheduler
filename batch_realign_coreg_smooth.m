%-----------------------------------------------------------------------
% Realign, coregister & smooth functionals for MVPA analyses
% Inputs:
% 	* sub = $SUB in ppc_mvpa.sh
%	* runName = task run names
%	* subDir = subject directory
%	* funcDir = functional directory
%	* structDir = structural directory
%	* jobDir = directory where the jobs will be saved
%
% Outputs:
%	* creates (sub)_ppc_mvpa.mat jobs
%
% D.Cos 2017.3.7
%-----------------------------------------------------------------------
disp(['Running ',sub]);
% define task runs
runName = {'run1', 'run2', 'run3'}; 

% define paths
subDir = '/Users/bart/Documents/FP/fMRI/subjects/';
funcDir = 'mvpa/';
structDir = 'structurals/';
jobDir = '/Users/bart/Documents/FP/fMRI/scripts/ppc/spm/mvpa/ppc_jobs';

matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[subDir,char(sub),'/',funcDir,char(runName(1))]};
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.filter = [char(runName(1)),'.nii'];
matlabbatch{1}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';
matlabbatch{2}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[subDir,char(sub),'/',funcDir,char(runName(2))]};
matlabbatch{2}.cfg_basicio.file_dir.file_ops.file_fplist.filter = [char(runName(2)),'.nii'];
matlabbatch{2}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';
matlabbatch{3}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {[subDir,char(sub),'/',funcDir,char(runName(3))]};
matlabbatch{3}.cfg_basicio.file_dir.file_ops.file_fplist.filter = [char(runName(3)),'.nii'];
matlabbatch{3}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';
matlabbatch{4}.spm.util.exp_frames.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (run1.nii)', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{4}.spm.util.exp_frames.frames = [1:999];
matlabbatch{5}.spm.util.exp_frames.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (run2.nii)', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{5}.spm.util.exp_frames.frames = [1:999];
matlabbatch{6}.spm.util.exp_frames.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (run3.nii)', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{6}.spm.util.exp_frames.frames = [1:999];
matlabbatch{7}.spm.spatial.realign.estimate.data{1}(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{7}.spm.spatial.realign.estimate.data{2}(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{7}.spm.spatial.realign.estimate.data{3}(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{7}.spm.spatial.realign.estimate.eoptions.quality = 0.9;
matlabbatch{7}.spm.spatial.realign.estimate.eoptions.sep = 2;
matlabbatch{7}.spm.spatial.realign.estimate.eoptions.fwhm = 4;
matlabbatch{7}.spm.spatial.realign.estimate.eoptions.rtm = 1;
matlabbatch{7}.spm.spatial.realign.estimate.eoptions.interp = 4;
matlabbatch{7}.spm.spatial.realign.estimate.eoptions.wrap = [0 0 0];
matlabbatch{7}.spm.spatial.realign.estimate.eoptions.weight = '';
matlabbatch{8}.spm.spatial.coreg.estwrite.ref = {[subDir,char(sub),'/',funcDir,structDir,'mprage.nii,1']};
matlabbatch{8}.spm.spatial.coreg.estwrite.source(1) = cfg_dep('Realign: Estimate: Realigned Images (Sess 1)', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{1}, '.','cfiles'));
matlabbatch{8}.spm.spatial.coreg.estwrite.other(1) = cfg_dep('Realign: Estimate: Realigned Images (Sess 1)', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{1}, '.','cfiles'));
matlabbatch{8}.spm.spatial.coreg.estwrite.other(2) = cfg_dep('Realign: Estimate: Realigned Images (Sess 2)', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{2}, '.','cfiles'));
matlabbatch{8}.spm.spatial.coreg.estwrite.other(3) = cfg_dep('Realign: Estimate: Realigned Images (Sess 3)', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{3}, '.','cfiles'));
matlabbatch{8}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
matlabbatch{8}.spm.spatial.coreg.estwrite.eoptions.sep = [64 32 16 8 4 2];
matlabbatch{8}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{8}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
matlabbatch{8}.spm.spatial.coreg.estwrite.roptions.interp = 4;
matlabbatch{8}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
matlabbatch{8}.spm.spatial.coreg.estwrite.roptions.mask = 0;
matlabbatch{8}.spm.spatial.coreg.estwrite.roptions.prefix = 'cr_';
matlabbatch{9}.spm.spatial.smooth.data(1) = cfg_dep('Coregister: Estimate & Reslice: Resliced Images', substruct('.','val', '{}',{8}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','rfiles'));
matlabbatch{9}.spm.spatial.smooth.fwhm = [2 2 2];
matlabbatch{9}.spm.spatial.smooth.dtype = 0;
matlabbatch{9}.spm.spatial.smooth.im = 0;
matlabbatch{9}.spm.spatial.smooth.prefix = 's';

save(strcat(jobDir,'/',sub,'_ppc_mvpa.mat'),'matlabbatch');