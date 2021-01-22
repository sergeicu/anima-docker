# Purpose 

Use this option only if you neeed to write a script with advanced functionalities that uses external libraries. E.g. Python script with external python libraries, Perl script, Ruby script, etc. 

# Summary 

1. Write your own script -    

Either   
A. Modify an example script in `src/run_anima.py`.   
B. Or add extra scripts to `src/` folder. If you do the latter, make sure you copy these scripts into the Docker image during build - e.g. add `COPY src/<your_new_script.py> /` in the Dockerfile 

2. Modify Dockerfile to include external python libraries, if you are using any   
e.g. install extra libriaries in Dockerfile via `RUN pip install -y <external_library1> <external_library2>` line. Make sure you put this below `pip install` command in the Dockerfile. 

3. Rebuild the Docker image. 


# Example script 

We have provided a working example script that executes a specific Anima function on ALL .nii.gz files inside a given directory.  

The script is located inside `src/run_anima.py`.  

Remember that if you need to modify this script to tailor to your own functionality - you will need to rebuild the Docker image, as instructed on the main page.   

Also note - by default - the Dockerfile container will run `src/run_anima.py` when it is instantiated UNLESS you overwrite it with default arguments during Docker instantiation.  

In other words -   
`sudo docker run --it --rm sergeicu/anima:latest` will invoke `src/run_anima.py` inside the Docker container.   

However -   
`sudo docker run --it --rm sergeicu/anima:latest /bin/bash` will place you directly inside the Docker container and will NOT invoke the python script. This is because the Dockerfile specifies `CMD ["python", "/run_anima.py"]`, instead of `ENTRYPOINT ["python", "/run_anima.py"]`

# Running Docker from CLI 

We also provided you with a simple wrapper script `runs_python_inside_docker.sh`. This script helps you to avoid typing the long command to invoke Docker container to process your files. Instead, you can just call this script. 
