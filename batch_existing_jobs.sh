#!/bin/bash
#
#Remember to figure out how many files in the dir first:
#    ls -1 <your/dir/name/*mat> | wc -l
#
#Then use an array batch to run this file:
#    sbatch -a 0-[number of .mat files] batch_dir_of_jobs.sh directory/where/jobs/are/
#
#SBATCH --job-name=SET_ME
#SBATCH --output=SET_ME-%A_%a.log
#
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G

SPM_PATH='/projects/dsnlab/SPM12'
ADDITIONALOPTIONS="-singleCompThread"

if [ -z "$1" ]
  then
    echo "No argument supplied. Must supply directory with spm job mat files."
    exit 1
fi

filelist=(`ls -1 $(realpath $1)/*mat`)
jobfile=${filelist[$SLURM_ARRAY_TASK_ID]}

echo "Running batch job"
echo "   $jobfile"

module load matlab
srun matlab -nosplash -nodisplay -nodesktop ${ADDITIONALOPTIONS} -r "clear; addpath('$SPM_PATH'); spm_jobman('initcfg'); load('$jobfile'); spm_jobman('run',matlabbatch); exit" 
