#!/bin/bash

# PURPOSE: 
# Invoke docker container automatically and process files inside a given directory with src/run_anima.py script. 
# Important - if you modify the contents of src/run_anima.py - you MUST rebuild the docker image. 


# USAGE: 
# chmod u+x runs_python_script_inside_docker.sh 
# ./runs_python_script_inside_docker.sh <path_to_folder>

# IMPORTANT 
# path_to_folder must have read-write permissions for ALL users: `chmod -R ugo+rwx <path_to_folder>`

# ERRORS: 
# If docker throws error 
# 1. Check that you can run `sudo` on this machine 
# 2. Check if you had started docker daemon on this machine: `sudo systemctl start docker`

data=$1
sudo docker run -it --rm -v $data:/data sergeicu/anima python /run_anima.py /data

