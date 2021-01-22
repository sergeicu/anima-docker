# About 

A Docker image for [Anima software](https://github.com/Inria-Visages/Anima-Public) - a medical image processing tool from Empenn, Inria. 

A Docker container will provide a hardware and software agnostic access to all Anima functionalities, without the need to install dependencies or to compile from source. 

This Docker image is built on top of [Ubuntu 18.04 Docker base image](https://hub.docker.com/_/ubuntu), with a copy of [matching Anima binaries](https://github.com/Inria-Visages/Anima-Public/releases). 

Anima software functionalities [include tools for](https://anima.readthedocs.io/en/latest/):
- Diffusion imaging
- Registration
- Segmentation
- Patient to group comparison
- MR relaxometry
- MR denoising
- Basic image processing tools
 
# Install 

[Install Docker](https://github.com/sergeicu/anima-docker/blob/main/install-docker.md) 

# Pull 

You can pull a ready-made Anima image from dockerhub registry directly. 

```
name=sergeicu/anima:latest
sudo docker pull $name
```

# Build 

[optional]

You can also build your own Docker image. 
This is only necessary if you are planning to add more functionality to Anima containerized application. 

```
name=sergeicu/anima-docker:latest   
sudo docker build --no-cache -t $name .
```

Use `$name` that follows dockerhub convention = <dockerhub_username>/<docker_name>:<build_release>. 


# Run 

## Interactively:   
`sudo docker run -it --rm $name`   

## Interactively, with access to your local filesystem. 

Your local filesystem be mounted on `/data` in the container:   

```
localfolder=/full_path_to_folder_on_your_machine/
chmod ugo+rwx $localfolder 
sudo docker run -it --rm -v $localfolder:/data $name
```

IMPORTANT: you must give full read-write permissions to `$localfolder` for _all_ users.  

## Run an Anima command on an individual file, without entering the container: 

An example of a [Gaussian T2 mixture estimation](https://anima.readthedocs.io/en/latest/relaxometry.html):

```
cmd=/anima/animaGMMT2RelaxometryEstimation
localfolder=/full_path_to_folder_on_your_machine/
input=example_image.nii.gz # make sure this file is inside $localfolder
chmod ugo+rwx $localfolder
sudo docker run -it --rm -v $localfolder:/data $name $cmd -i /data/$input -o /data/output.nii.gz -e 9 
```

Notes: 
- all anima binaries are stored in `/anima` folder inside the container. 
- example_image.nii.gz is provided with this repository 


-----









MODIFY THE BELOW 

6b. (run this only if you skipped the `optional` steps above)  Pull `anima` image from serge's dockerhub 

Instead of building an `anima` docker image from scratch, 
you can just pull my own (serge's) image from dockerhub. 
Dockerhub is just like github, but for docker images. 

Pull the image from dockerhub: 
sudo docker pull sergeicu/anima_t2_only


Web location for the docker image: 
https://hub.docker.com/repository/docker/sergeicu/anima_t2_only


You must make sure that you have the correct permissions to the directory with your data.  Specifically, the folder that you are mounting into docker must be `rwx` for all user groups. 

Your data lives in `/data` folder specified above. Check this: 


Run a script and process multiple files:   
1. Create script.sh    
2. Place it within Dockerfile directory   
3. Add the following lines to Dockerfile build instructions (above CMD)  
- `COPY script.sh /`   
- `RUN chmod ugo+rwx /script.sh`   
4. Build docker image as shown above   
5. Run docker `sudo docker run -it --rm -v $localfolder:/data $name /script.sh /data/$localsubfolder /data/$localsubfolder`   
, where `$localsubfolder` is a subfolder inside `$localfolder` (or a symbolic link), which must have `rwx` chmod for all users.   

