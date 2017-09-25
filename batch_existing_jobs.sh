#!/bin/bash
#
#Remember to figure out how many files in the dir first:
#    ls -1 directory/where/jobs/are/job_name_pattern*mat | wc -l
#
#Then use an array batch to run this file:
#    sbatch -a 0-[number of .mat files minus 1] batch_existing_jobs.sh directory/where/jobs/are/job_name_pattern*mat 
#
#SBATCH --job-name=SET_ME
#SBATCH --output=SET_ME-%A_%a.log
#
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G

SPM_PATH='/projects/dsnlab/SPM12'
ADDITIONALOPTIONS="-singleCompThread"

if [ "$#" -eq 0 ]; then
    echo "No arguments supplied. Must supply job .mat files as arguments"
    exit 1
else
    matFiles=( "$@" )
fi

jobfile=$(realpath ${matFiles[$SLURM_ARRAY_TASK_ID]})

echo "Running batch job"
echo "   $jobfile"

module load matlab
srun matlab -nosplash -nodisplay -nodesktop ${ADDITIONALOPTIONS} -r "clear; addpath('$SPM_PATH'); spm_jobman('initcfg'); load('$jobfile'); spm_jobman('run',matlabbatch); exit" 
