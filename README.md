# Warning 

This is a separate branch of Anima docker github repository that is dedicated to enablinh a single Anima function ONLY - namely - estimation of Gaussian Mixture T2 components from CPMG sequence data.  

We use the following command to achieve this - `animaGMMT2RelaxometryEstimation` 

Please switch branches to `main` to get the Anima image with ALL functionalities. 

# About 

A Docker image for [Anima software](https://github.com/Inria-Visages/Anima-Public) - a medical image processing tool from Empenn, Inria. 

This Docker image provides a hardware and a software agnostic access to all Anima functionalities, without the need to install dependencies or to compile from source. 

This Docker image is built on top of [Ubuntu 18.04 Docker base image](https://hub.docker.com/_/ubuntu), with a copy of [matching Anima binaries](https://github.com/Inria-Visages/Anima-Public/releases). 

Anima software functionalities [include tools for](https://anima.readthedocs.io/en/latest/):
- Diffusion imaging
- Registration
- Segmentation
- Patient to group comparison
- MR relaxometry
- MR denoising
- Basic image processing tools
 
# Install Docker

[Install Docker](https://github.com/sergeicu/anima-docker/blob/main/install-docker.md) 

# Pull 

You can pull a ready-made Anima image from dockerhub registry directly. 

```
name=sergeicu/anima_t2_only:latest
sudo docker pull $name
```
Web location of the image: https://hub.docker.com/u/sergeicu

Notes: 
- use `sudo docker images` to view all your images 

# Build 

[optional]

You can also build your own Docker image.   
This is only necessary if you are planning to add more functionality to the Anima containerized application. 

```
name=sergeicu/anima_t2_only:latest   
sudo docker build --no-cache -t $name .
```

Use `$name` that follows dockerhub convention = <dockerhub_username>/<docker_name>:<build_release>. 


# Run 

## Calculate multi-component T2 distribution on ALL images in a given directory 

Run 
`bash run_anima_docker.sh <input_directory>` 

The script invokes the Docker container. A python script inside the Docker container fetches all nifti images inside `<input_directory>` and processes them with Anima. Output is written to the same directory. 

Note 
- you must make sure that `<input_directory>` has read-write permissions for _all_ users: `chmod ugo+rw <input_directory>` 
- specify `<input_directory>` as full path

## Interactively:   
`sudo docker run -it --rm $name`   

Notes: 
- type `exit` to kill the container 
- `--rm` removes the container upon exit 
- use `sudo docker ps` to view actively running containers and `sudo docker ps -a` to view all 

## Interactively, with access to your local filesystem. 

```
localfolder=/full_path_to_folder_on_your_machine/
chmod ugo+rw $localfolder 
sudo docker run -it --rm -v $localfolder:/data $name
```

Notes: 
- `$localfolder` is mounted to `/data` inside the container 
- you must give full read-write permissions to `$localfolder` for _all_ users to avoid Docker errors
- all anima binaries are stored in `/anima` folder inside the container. 


## Run an Anima command on an individual file, without entering the container: 

An example with [Gaussian T2 mixture estimation](https://anima.readthedocs.io/en/latest/relaxometry.html) command:

```
cmd=/anima/animaGMMT2RelaxometryEstimation
localfolder=${PWD}/example_data/
chmod ugo+rw $localfolder
input=example_image.nii.gz 
sudo docker run -it --rm -v $localfolder:/data $name $cmd -i /data/$input -o /data/output.nii.gz -e 9 
```

Notes: 
- `example_image.nii.gz` is included inside `example_data` folder in this repository 
- please make sure that you place `example_image.nii.gz` is inside `$localfolder` on your file system 


# Suggestions / Improvements

Please log these via https://github.com/sergeicu/anima-docker/issues

