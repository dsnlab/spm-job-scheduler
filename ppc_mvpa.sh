#!/bin/bash
#--------------------------------------------------------------
# Inputs:
#	* SUB = defined in subject_list.txt
#	* SCRIPT = MATLAB script to create and execute batch job
#	* Edit SPM path
#
# Outputs:
#	* Creates a batch job for $SUB
#	* Batch jobs are saved to the path defined in MATLAB script
#	* Executes batch job
#
# D.Cos 2017.3.7
#--------------------------------------------------------------

# define matlab script to run from input 2
SCRIPT=$1

# define subject ID from input 1
SUB=$2

# create and execute job
echo -------------------------------------------------------------------------------
echo "${SUB}"
echo "Running ${SCRIPT}"
echo -------------------------------------------------------------------------------

/Applications/MATLAB_R2016a.app/bin/matlab -nosplash -nodisplay -nodesktop -r "clear; addpath('/Users/bart/Documents/MATLAB/spm12'); spm_jobman('initcfg'); sub='$SUB'; run('$SCRIPT'); spm_jobman('run',matlabbatch); exit"