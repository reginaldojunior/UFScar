#!/bin/bash
#SBATCH -J pi                       # Job name
#SBATCH -p fast                     # Job partition
#SBATCH -n 1                        # Number of processes
#SBATCH -t 01:30:00                 # Run time (hh:mm:ss)
#SBATCH --cpus-per-task=40          # Number of CPUs per process
#SBATCH --output=%x.%j.out          # Name of stdout output file - %j expands to jobId and %x to jobName
#SBATCH --error=%x.%j.err           # Name of stderr output file

echo "*** SEQUENTIAL ***"
srun singularity run container.sif pi_seq 1000000000

echo "*** PTHREAD ***"
srun singularity run container.sif pi_pth 1000000000 ${SLURM_CPUS_PER_TASK}

echo "*** OPENMP ***"
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
srun singularity run container.sif pi_omp 1000000000
 
