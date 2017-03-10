#!/bin/bash
#--------------------------------------------------------------
# Inputs:
#	* STUDY = study name
#	* SUBJLIST = subject_list.txt
#	* SCRIPT = MATLAB script to create and execute batch job
#	* PROCESS = running locally, via qsub, or on the Mac Pro
#	* Edit output and error paths
#
# Outputs:
#	* Executes ppc_mvpa.sh for $SUB and $SCRIPT
#
# D.Cos 2017.3.7
#--------------------------------------------------------------


# Set your study
STUDY=(FP)

# Set subject list
SUBJLIST=`cat subject_list.txt`

# Set MATLAB script path
SCRIPT=/Users/ralph/Documents/FP/fMRI/scripts/ppc/spm/mvpa/batch_realign_coreg_smooth.m

# Set output dir
OUTPUTDIR=/Users/ralph/Documents/"${STUDY}"/fMRI/scripts/output

# Set processor
# use "qsub" for HPC
# use "local" for local machine
# use "parlocal" for local parallel processing

PROCESS=parlocal
CORES=7

# Create and execute batch job
if [ "${PROCESS}" == "qsub" ]; then 
	for SUBJ in $SUBJLIST
	do
	 echo "submitting via qsub"
	 qsub -v SUBID=${SUBJ},STUDY=${STUDY} -N x4dmerge -o "${OUTPUTDIR}"/"${SUBJ}"_4dmerge_output.txt -e "${OUTPUTDIR}"/"${SUBJ}"_4dmerge_error.txt 4dmerge.sh
	done

elif [ "${PROCESS}" == "local" ]; then 
	for SUBJ in $SUBJLIST
	do
	 echo "submitting locally"
	 bash ppc_mvpa.sh ${SUBJ} ${SCRIPT} > "${OUTPUTDIR}"/"${SUBJ}"_ppc_mvpa_output.txt 2> /"${OUTPUTDIR}"/"${SUBJ}"_ppc_mvpa_error.txt
	done
elif [ "${PROCESS}" == "parlocal" ]; then 
	parallel --results "${OUTPUTDIR}"/{}_ppc_mvpa_output -j${CORES} bash ppc_mvpa.sh ${SCRIPT} :::: subject_list.txt
fi
