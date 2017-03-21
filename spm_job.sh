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

if [ -z $1 -o -z $2 -o -z $3 ]; then
	if [ -z $REPLACESID -o -z $SCRIPT -o -z $SUB ]; then
		echo "Aguments not supplied on command line or in environment"
	fi
else
	# define subject id to replace in script from input 1
	REPLACESID=$1

	# define matlab script to run from input 2
	SCRIPT=$2

	# define subject ID from input 3
	SUB=$3
fi

# MATLAB version
MATLABVER=R2015b

# create and execute job
echo -------------------------------------------------------------------------------
echo "${SUB}"
echo "Running ${SCRIPT}"
echo -------------------------------------------------------------------------------

/Applications/MATLAB_"${MATLABVER}".app/bin/matlab -nosplash -nodisplay -nodesktop -singleCompThread -r "clear; addpath('/Users/ralph/Documents/MATLAB/spm12'); spm_jobman('initcfg'); sub='$SUB'; script_file='$SCRIPT'; replacesid='$REPLACESID'; display([sub,script_file,replacesid]); run('make_sid_matlabbatch.m'); %spm_jobman('run',matlabbatch); exit"