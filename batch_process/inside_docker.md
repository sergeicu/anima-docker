# Placing your script inside docker

We have provided a working example script that executes a specific Anima function on ALL .nii.gz files inside a given directory.  

The script is located inside `src/run_anima.py`.  

Remember that if you need to modify this script to tailor to your own functionality - you will need to rebuild the Docker image, as instructed on the main page.   

By default - the Dockerfile container will run `src/run_anima.py` when it is instantiated UNLESS you overwrite it with default arguments during Docker instantiation.  

In other words -   
`sudo docker run --it --rm sergeicu/anima:latest` will invoke `src/run_anima.py` inside the Docker container.   

However -   
`sudo docker run --it --rm sergeicu/anima:latest /bin/bash` will place you directly inside the Docker container and will NOT invoke the python script. This is because the Dockerfile specifies `CMD ["python", "/run_anima.py"]`, instead of `ENTRYPOINT ["python", "/run_anima.py"]`

# Running Docker from CLI 

We also provide you with a simple wrapper script `runs_python_inside_docker.sh`. This script helps you to avoid typing the long command to invoke Docker container to process your files. Instead, you can just call this script and provide a folder name with your files to do your processing. 
