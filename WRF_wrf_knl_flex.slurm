#!/bin/bash -l

#SBATCH -q flex
#SBATCH -N 1
#SBATCH -t 10:00:00
#SBATCH --time-min 00:20:00
#SBATCH -C knl

#SBATCH -J BTRAN001
#SBATCH --mail-user=twhilton@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH -L project   #Job requires project file system
#SBATCH -L SCRATCH   #Job requires $SCRATCH file system

: ${job_number:="1"}           # set job_nubmer to 1 if it is undefined
job_number_max=20

echo "hi from ${SLURM_JOB_ID}"
echo "job ${job_number} of ${job_number_max}"
echo "PARENT_JOB_ID: ${PARENT_JOB_ID}"

# use direct path to python as suggested by Rollin
# ${PARENT_JOB_ID:=None} syntax puts "None" in PARENT_JOB_ID if it is unset
# variable expansion syntax: see e.g. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02
echo "starting WRF_resubmit_tools.py"
/global/homes/t/twhilton/.conda/envs/wrf_cori_compute/bin/python /global/homes/t/twhilton/Code/WRF_Job_Code/WRF_resubmit_tools.py --wrf_run_dir ${SLURM_SUBMIT_DIR} --parent_job_id ${PARENT_JOB_ID:=None} --default_wrf_timestep 200
echo "done WRF_resubmit_tools.py"

if [[ ${job_number} -lt ${job_number_max} ]]
then
    (( job_number++ ))
    next_jobid=$(sbatch --export=job_number=${job_number},PARENT_JOB_ID=${SLURM_JOB_ID} -d afterany:${SLURM_JOB_ID} ${SLURM_SUBMIT_DIR}/WRF_wrf_knl_flex.slurm | awk '{print $4}')
    echo "submitted ${next_jobid}"
    # TODO: check here if $next_job_id is empty; if so cancel further iterations and produce error message
fi

echo "running wrf.exe in ${SLURM_JOB_QOS} queue"
echo "beginning `date`"
srun -n 25 -c 1 --cpu_bind=threads ${SLURM_SUBMIT_DIR}/wrf.exe

sleep 15
tar -czvf rsl_files_${SLURM_JOB_ID}.tar.gz rsl.error.* rsl.out.* namelist.input
echo "${SLURM_JOB_ID} done"
echo "`date`"
