#!/bin/bash

# USAGE: 
# chmod u+x anima_docker.sh 
# ./anima_docker.sh <path_to_folder>

# IMPORTANT: 
# path_to_folder must contain ONLY .nii.gz files. 
# output files will be created in the same directory 

# SUPER IMPORTANT 
# path_to_folder must have read-write permissions for ALL users: `chmod -R ugo+rwx <path_to_folder>`

# ERRORS: 
# If docker throws error 
# 1. Check that you can run `sudo` on this machine 
# 2. Check if you had started docker daemon on this machine: `sudo systemctl start docker`
# If python throws error 
# 1. If no .nii.gz files are found python script will indicate this via a specific error message 

data=$1
sudo docker run -it --rm -v $data:/data sergeicu/anima_t2_only_exec python run_anima.py /data

