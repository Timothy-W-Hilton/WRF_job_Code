#!/bin/bash
#SBATCH -J deurb_wrf
#SBATCH -q regular
#SBATCH -C haswell
#SBATCH -N 1
#SBATCH --comment=00:20:00
#SBATCH --time-min=00:05:00 #the minimum amount of time the job should run
#SBATCH --time=00:20:00
#SBATCH --mail-user=twhilton@ucsc.edu
#
#SBATCH --signal=B:USR1@20
#SBATCH --requeue
#SBATCH --open-mode=append
#SBATCH --account=m1517  #USE TRAVIS'S ALLOCATION

# use the following three variables to specify the time limit per job (max_timelimit),
# the amount of time (in seconds) needed for checkpointing,
# and the command to use to do the checkpointing if any (leave blank if none)
max_timelimit=00:20:00   # can match the #SBATCH --time option but don't have to
ckpt_overhead=20         # should match the time in the #SBATCH --signal option
ckpt_command=/global/homes/t/twhilton/.conda/envs/wrf_cori/bin/python /global/homes/t/twhilton/Code/WRF_prepost_process/WRF_resubmit_tools.py --wrf_run_dir ${SLURM_SUBMIT_DIR} --parent_job_id ${SLURM_JOB_ID}

# requeueing the job if reamining time >0 (do not change the following 3 lines )
. /usr/common/software/variable-time-job/setup.sh
requeue_job func_trap USR1
#

# user setting goes here

echo "hi from ${SLURM_JOB_ID}"

echo "running in ${SLURM_JOB_QOS} queue"
echo "beginning `date`"
srun -n 30 -c 1 --cpu_bind=threads ${SLURM_SUBMIT_DIR}/wrf.exe &

wait
echo "${SLURM_JOB_ID} done"
echo "`date`"


# attempt to adapt the example at
# <https://docs.nersc.gov/jobs/examples/#annotated-example-automated-variable-time-jobs>
# to run WRF simulations.  Never did get this to work quite right, and
# it is now superseded by WRF_wrf_knl_flex.slurm (which uses the flex
# queue to achieve the same results).
