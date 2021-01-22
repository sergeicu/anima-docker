# Placing your script outside docker

We have provided a working example script that executes a specific Anima function on ALL .nii.gz files inside a given directory.    

This script does NOT require you to rebuild the Docker image. Instead, you must place this script inside your `$localfolder` that you map inside the container. 

To execute it - run `bash runs_python_script_outside_docker.sh <input_folder>`
