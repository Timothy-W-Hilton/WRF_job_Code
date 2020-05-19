#!/bin/bash
#SBATCH -N 1
#SBATCH -C knl
#SBATCH -p debug
#SBATCH -J btran001
#SBATCH --mail-user=twhilton@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH -t 00:20:00
#SBATCH -L SCRATCH   #Job requires $SCRATCH file system

#OpenMP settings:
export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread

#run the application:
echo "running wrf.exe"
srun -n 15 -c 1 --cpu_bind=threads  ${SLURM_SUBMIT_DIR}/wrf.exe
