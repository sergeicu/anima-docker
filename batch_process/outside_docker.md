# Placing your script outside docker

We have provided a working example script that executes a specific Anima function on ALL .nii.gz files inside a given directory - `exampLe_data/run_anima.py`.  

This script does NOT require you to rebuild the Docker image. Instead, you must place this script inside your `$localfolder` that you map inside the container. In our example, we map the local directory `${PWD}/example_data` to `/data` inside the Docker container.   

We also wrote a wrapper bash script that allows you to avoid typing the lengthy docker commands - `bash runs_python_script_outside_docker.sh <input_folder>`. So you can invoke this `.sh` script to do all the processing for you. 
