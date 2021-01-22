#!/bin/bash

# PURPOSE: 
# Invoke docker container automatically and process files inside a given directory with example_data/run_anima.py script. 
# If you modify the contents of example_data/run_anima.py - you do NOT need to rebuild the docker image.  

# USAGE: 
# chmod u+x runs_python_script_outside_docker.sh 
# chmod -R ugo+rw ../example_data 
# ./runs_python_script_outside_docker.sh ../example_data/

# ERRORS: 
# If docker throws error 
# 1. Check that you can run `sudo` on this machine 
# 2. Check if you had started docker daemon on this machine: `sudo systemctl start docker`

data=../example_data/
sudo docker run -it --rm -v $data:/data sergeicu/anima python /data/run_anima.py /data

