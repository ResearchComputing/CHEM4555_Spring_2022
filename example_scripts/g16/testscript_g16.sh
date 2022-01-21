#!/bin/bash

#SBATCH --job-name=g16-test
#SBATCH --partition=shas
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --time=00:05:00
#SBATCH --output=g16-test.%j.out

module load gaussian/16_avx2

# Always specify a scratch directory on a fast storage space (not /home or /projects!)
export GAUSS_SCRDIR=/scratch/summit/$USER/$SLURM_JOBID
# or export GAUSS_SCRDIR=$SLURM_SCRATCH

# alternatively, to use the local SSD; max 159GB available

# the next line prevents OpenMP parallelism from conflicting with Gaussian's internal SMP parallelization
export OMP_NUM_THREADS=1

mkdir $GAUSS_SCRDIR  # only needed if using /scratch/summit
date  # put a date stamp in the output file for timing/scaling testing if desired
g16 -m=110gb -p=24 my_input.com
date
