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
#	* Executes spm_job.sh for $SUB and $SCRIPT
#
# D.Cos 2017.3.7
#--------------------------------------------------------------


# Set your study
STUDY=tds/tds_repo

# Set subject list
SUBJLIST=`cat subject_list.txt`
#Which SID should be replaced?
REPLACESID='101'

# Set MATLAB script path
COMPNAME=ralph
SCRIPT=/Users/${COMPNAME}/Documents/${STUDY}/fMRI/scripts/ppc/spm/coreg_realign_unwarp_coreg_segment.m

# Tag the results files
RESULTS_INFIX=fx_allconds

# Set output dir
OUTPUTDIR=/Users/${COMPNAME}/Documents/${STUDY}/fMRI/scripts/ppc/shell/schedule_spm_jobs/output/

# Set processor
# use "qsub" for HPC
# use "serlocal" for local, serial processing
# use "parlocal" for local, parallel processing

PROCESS=parlocal
MAXJOBS=8

# Create and execute batch job
if [ "${PROCESS}" == "qsub" ]; then 
	for SUBJ in $SUBJLIST
	do
	 echo "submitting via qsub"
	 qsub -v REPLACESID=${REPLACESID},SCRIPT=${SCRIPT},SUB=${SUB} -N ${RESULTS_INFIX} -o "${OUTPUTDIR}"/"${SUB}"_${RESULTS_INFIX}_output.txt -e "${OUTPUTDIR}"/"${SUB}"_${RESULTS_INFIX}_error.txt spm_job.sh
	done

elif [ "${PROCESS}" == "serlocal" ]; then 
	for SUB in $SUBJLIST
	do
	 echo "submitting locally"
	 bash spm_job.sh ${REPLACESID} ${SCRIPT} ${SUB} > "${OUTPUTDIR}"/"${SUBJ}"_${RESULTS_INFIX}_output.txt 2> /"${OUTPUTDIR}"/"${SUBJ}"_${RESULTS_INFIX}_error.txt
	done
elif [ "${PROCESS}" == "parlocal" ]; then 
	parallel --verbose --results "${OUTPUTDIR}"/{}_${RESULTS_INFIX}_output -j${MAXJOBS} bash spm_job.sh ${REPLACESID} ${SCRIPT} :::: subject_list.txt
fi
