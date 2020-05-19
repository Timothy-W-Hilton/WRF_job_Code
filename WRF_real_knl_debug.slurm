#!/bin/bash
#SBATCH -N 1
#SBATCH -q debug
#SBATCH -N 1
#SBATCH -t 00:01:00
#SBATCH -C knl
#SBATCH -J btran000_real
#SBATCH --mail-user=twhilton@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH -L SCRATCH   #Job requires $SCRATCH file system

#OpenMP settings:
export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread

#run the application:
echo "running real.exe"
srun -n 25 -c 1 --cpu_bind=threads ${SLURM_SUBMIT_DIR}/real.exe
