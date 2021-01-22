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
name=sergeicu/anima:latest
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
name=sergeicu/anima-docker:latest   
sudo docker build --no-cache -t $name .
```

Use `$name` that follows dockerhub convention = <dockerhub_username>/<docker_name>:<build_release>. 


# Run 

## Interactively:   
`sudo docker run -it --rm $name`   

Notes: 
- type `exit` to kill the container 
- `--rm` removes the container upon exit 
- use `sudo docker ps` to view actively running containers and `sudo docker ps -a` to view all 

## Interactively, with access to your local filesystem. 

```
localfolder=/full_path_to_folder_on_your_machine/
chmod ugo+rwx $localfolder 
sudo docker run -it --rm -v $localfolder:/data $name
```

Notes: 
- `$localfolder` lives in `/data` inside the container 
- you must give full read-write permissions to `$localfolder` for _all_ users to avoid Docker errors
- all anima binaries are stored in `/anima` folder inside the container. 


## Run an Anima command on an individual file, without entering the container: 

An example with [Gaussian T2 mixture estimation](https://anima.readthedocs.io/en/latest/relaxometry.html) command:

```
cmd=/anima/animaGMMT2RelaxometryEstimation
localfolder=/full_path_to_folder_on_your_machine/
input=example_image.nii.gz 
chmod ugo+rwx $localfolder
sudo docker run -it --rm -v $localfolder:/data $name $cmd -i /data/$input -o /data/output.nii.gz -e 9 
```

Notes: 
- `example_image.nii.gz` is included in this repository 
- please make sure that you place `example_image.nii.gz` is inside `$localfolder` on your file system 

## Batch process multiple files with a custom Anima command, without entering the container: 

For this you need to write a script: 


Write a script :   
1. Create script.sh    
2. Place it within Dockerfile directory   
3. Add the following lines to Dockerfile build instructions (above CMD)  
- `COPY script.sh /`   
- `RUN chmod ugo+rwx /script.sh`   
4. Build docker image as shown above   
5. Run docker `sudo docker run -it --rm -v $localfolder:/data $name /script.sh /data/$localsubfolder /data/$localsubfolder`   
, where `$localsubfolder` is a subfolder inside `$localfolder` (or a symbolic link), which must have `rwx` chmod for all users.   

