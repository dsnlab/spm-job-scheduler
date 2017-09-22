#!/bin/bash
#
#Takes a single matlab script as argument
#and executes it within matlab.
#Usage:
#    sbatch batch_arbitrary_matlab_script.m <matlab_script.m> 
#
#SBATCH --job-name=SET_ME
#SBATCH --output=SET_ME.log
#
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=2G

ADDITIONALOPTIONS="-singleCompThread"

SCRIPT=`realpath $1`

echo Running $SCRIPT
module load matlab
srun matlab -nosplash -nodisplay -nodesktop ${ADDITIONALOPTIONS} -r "run('$SCRIPT')" 
