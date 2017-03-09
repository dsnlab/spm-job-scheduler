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
#SCRIPT=/Users/raplph/Documents/FP/fMRI/scripts/ppc/spm/mvpa/batch_realign_coreg_smooth.m
SCRIPT=/Users/raplph/Documents/code/batch_realign_coreg_smooth.m

# Set processor
# use "qsub" for HPC
# use "local" for local machine
# use "X" for Mac Pro

PROCESS=parlocal
CORES=8

# Create and execute batch job
if [ "${PROCESS}" == "qsub" ]; then 
	for SUBJ in $SUBJLIST
	do
	 echo "submitting via qsub"
	 qsub -v SUBID=${SUBJ},STUDY=${STUDY} -N x4dmerge -o /vxfsvol/home/research/"${STUDY}"/rsfMRI/scripts/output/"${SUBJ}"_4dmerge_output.txt -e /vxfsvol/home/research/"${STUDY}"/rsfMRI/scripts/output/"${SUBJ}"_4dmerge_error.txt 4dmerge.sh
	done

elif [ "${PROCESS}" == "local" ]; then 
	for SUBJ in $SUBJLIST
	do
	 echo "submitting locally"
	 bash ppc_mvpa.sh ${SUBJ} ${SCRIPT} > /Users/bart/Documents/"${STUDY}"/fMRI/scripts/output/"${SUBJ}"_ppc_mvpa_output.txt 2> /Users/bart/Documents/"${STUDY}"/fMRI/scripts/output/"${SUBJ}"_ppc_mvpa_error.txt
	done
elif [ "${PROCESS}" == "parlocal" ]; then 
	parallel -j${CORES} sh test_par.sh ${SCRIPT} :::: subject_list.txt
fi
