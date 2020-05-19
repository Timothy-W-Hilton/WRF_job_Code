Collection of code I have found useful for running long
[WRF](https://www.mmm.ucar.edu/weather-research-and-forecasting-model)
simulations at [NERSC](https://www.nersc.gov).

There are three categories: WRF namelist files,
[SLURM](https://docs.nersc.gov/jobs/) scripts, and a Python module
with an associated
[conda](https://docs.conda.io/projects/conda/en/latest/index.html)
Python environment specification.

The WRF namelist files (namelist.*) specify WRF simulation domains,
time periods, and sub-model choices to simulate redwood forests on the
U.S. West Coast and [Yatir
Forest](https://www.weizmann.ac.il/EPS/Yakir/research-activities/field-research/yatir-forest-location-and-background).

The SLURM scripts submit WRF simulations to the compute nodes at
NERSC.  *debug.slurm submits to the [NERSC debug
queue](https://docs.nersc.gov/jobs/policy/#debug) (useful for setting
up simulations).  WRF_wrf_knl_flex.slurm submits real.exe, which does
the heavy lifting in a WRF simulation, to the [NERSC flex
queue](https://docs.nersc.gov/jobs/policy/#flex).  The flex queue
allows long WRF simulations to run in a series of short jobs.
WRF_wrf_knl_flex.slurm uses WRF_resubmit_tools.py to update
namelist.input in between each job.  conda_env_wrf_compute.yml
specifies a [conda
environment](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#creating-an-environment-from-an-environment-yml-file)
with the dependencies of WRF_resubmit_tools.py.

author: Timothy W. Hilton <twhilton@ucsc.edu>
maintainer: Timothy W. Hilton <twhilton@ucsc.edu>
license: [MIT license](https://opensource.org/licenses/MIT)
