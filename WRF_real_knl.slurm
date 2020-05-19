#!/bin/bash
#SBATCH -N 1
#SBATCH -q flex
#SBATCH -N 1
#SBATCH -t 10:00:00
#SBATCH --time-min 01:00:00
#SBATCH -C knl
#SBATCH -J yatir_knl_real
#SBATCH --mail-user=4153147478@vtext.com
#SBATCH --mail-type=ALL
#SBATCH -L SCRATCH   #Job requires $SCRATCH file system

#OpenMP settings:
export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread

echo "hi from ${SLURM_JOB_ID}"
echo "running in ${SLURM_JOB_QOS} queue"
echo "beginning `date`"

#run the application:
srun -n 3 -c 1 --cpu_bind=threads  ${SLURM_SUBMIT_DIR}/real.exe

sleep 15
echo "${SLURM_JOB_ID} done"
tar -czvf rsl_files_${SLURM_JOB_ID}.tar.gz rsl.error.* rsl.out.*
