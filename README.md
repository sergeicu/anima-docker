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



## Run an anima command on an individual file, without entering the container: 



Run a script and process multiple files:   
1. Create script.sh    
2. Place it within Dockerfile directory   
3. Add the following lines to Dockerfile build instructions (above CMD)  
- `COPY script.sh /`   
- `RUN chmod ugo+rwx /script.sh`   
4. Build docker image as shown above   
5. Run docker `sudo docker run -it --rm -v $localfolder:/data $name /script.sh /data/$localsubfolder /data/$localsubfolder`   
, where `$localsubfolder` is a subfolder inside `$localfolder` (or a symbolic link), which must have `rwx` chmod for all users.   




4. (optional) Pull Ubuntu 18.04 

sudo docker pull ubuntu:18.04

You will need this Ubuntu image as a base for building the `anima` recipe. 

5. (optional) Verify that Ubuntu base image works: 

View your docker images
sudo docker images 
>> ubuntu                   18.04               2c047404e52d        8 weeks ago         63.3MB 

Run the ubuntu base image
sudo docker run -it --rm ubuntu:18.04 
>> [brings you inside an ubuntu container]


Check that you are running Ubuntu 
cat /etc/os-release
>> NAME="Ubuntu"                                                                                                                                                                                                      >> VERSION="18.04.5 LTS (Bionic Beaver)"                                                                                                                                                                              >> ID=ubuntu               
>> ... 

Exit ubuntu docker 
exit 

[this should bring you back to your normal Terminal]

6a. (optional) Build the image  

Create new directory and copy the correct recipe with the name "Dockerfile" into this directory. 

WARNING: it is imperative that you save the Dockerfile recipe as `Dockerfile`. It must be named precisely in this way. Otherwise you will get errors. 

You have two options - 
1. example recipe that contains only the T2 estimation code (123Mb) - 'Dockerfile_t2estimation_only` 
2. full recipe which contains everything (2Gb+) - `Dockerfile_all_binaries` 
I would suggest that you use the first recipe in the beginning. 

mkdir <newdirectory>
cp <Dockerfile attached to this email> <newdirectory>
cd <newdirectory>

Build the image 
sudo docker build -t anima_test . 


6b. (run this only if you skipped the `optional` steps above)  Pull `anima` image from serge's dockerhub 

Instead of building an `anima` docker image from scratch, 
you can just pull my own (serge's) image from dockerhub. 
Dockerhub is just like github, but for docker images. 

Pull the image from dockerhub: 
sudo docker pull sergeicu/anima_t2_only


Web location for the docker image: 
https://hub.docker.com/repository/docker/sergeicu/anima_t2_only


7. Run anima docker image as a test (simplified)

WARNING: if you skipped steps 4,5 and 6a, and pulled Serge's docker image, instead of building your own, then you must use
"sergeicu/anima_t2_only" instead of "anima_test" for all of the below commands. 



View your images 
sudo docker images 
>> anima_test  latest              875352ea27da        About an hour ago   123MB 


Run your docker 
sudo docker run -it --rm anima_test 
>> [brings you inside the new container]

run `ls` command to view the contents of the docker container
ls  
>> root@64bcd2a9d488:/# ls                                                                                 
>> animaGMMT2RelaxometryEstimation  boot  dev  home  lib64  mnt  proc  run   srv  tmp  var bin data  etc lib media  opt  root  sbin  sys  usr 

Run `anima` command inside the container
./animaGMMT2RelaxometryEstimation  
>> [the output should be a help string]

Exit the container
exit 



7. Run `anima` docker image with access to your CRL files 

As Clemente outlined in his instructions (link below) you must make sure that you have the correct permissions to the directory with your data.  Specifically, the folder that you are mounting into docker must be `rwx` for all user groups. 
https://drive.google.com/file/d/1mBaA06k87p28aT9PD674LHpcsdF69X2e/view?usp=sharing

Change permissions 
chmod -R ugo+rwx <the folder with your data>

Start docker container and link it to your input data folder: 
sudo docker run-it --rm -v <the folder with your data>​:/data anima_test  
>> [brings you inside the docker container]

Your data lives in `/data` folder specified above. Check this: 
ls /data 
>> [prints outputs of your <the folder with your data>]

You can now run `anima` T2 estimation command on ANY files inside your data folder: 
./animaGMMT2RelaxometryEstimation -i /data/<some_input_file_inside_the_folder_with_your_data.nii.gz> -o /data/output.nii.gz -e 9
>> [starts to process your input file] 

Full anima command instructions - in the PDF attached. 


END 










---------


# crkit-docker  


## Build:   
```
name=sergeicu/crkit:2021
sudo docker build --no-cache -t $name .
```

## OR Pull:   


## Run:   
Interactively:   
`sudo docker run -it --rm $name`   

Interactively, with access to local filesystem, mounted on `/data` in the container:   
```
localfolder=/home/ch215616/code/docker/crkit/
chmod ugo+rwx $localfolder #full chmod is required  
sudo docker run -it --rm -v $localfolder:/data $name
```

Run CRL command on an individual file, without entering container:   
```
cmd=crlConvertBetweenFileFormats
localfolder=/home/ch215616/code/docker/crkit/
input=example_image.nii.gz # make sure this file is inside $localfolder
chmod ugo+rwx $localfolder #full chmod is required 
sudo docker run -it --rm -v $localfolder:/data $name $cmd --in /data/$input --out /data/output.nrrd
```



Run a script and process multiple files:   
1. Create script.sh    
2. Place it within Dockerfile directory   
3. Add the following lines to Dockerfile build instructions (above CMD)  
- `COPY script.sh /`   
- `RUN chmod ugo+rwx /script.sh`   
4. Build docker image as shown above   
5. Run docker `sudo docker run -it --rm -v $localfolder:/data $name /script.sh /data/$localsubfolder /data/$localsubfolder`   
, where `$localsubfolder` is a subfolder inside `$localfolder` (or a symbolic link), which must have `rwx` chmod for all users.   

## Notes:   
crkit binaries are located in `/crkit` folder inside the container   

## Current errors (TODO):   
3 missing .so libraries cause 65 out of 213 binary executables to falter.    
- libITKNLOPTOptimizers  
- libvtkCommonDataModel  
- libcrlDWICommon  
Solution: need to add install instructions OR copy these shared libraries directly during Dockerfile build.    

To replicate:   
```
localfolder=/home/ch215616/code/docker/crkit/ 
sudo docker run -it --rm -v $localfolder:/data $name
find /crkit/bin/crl* -executable -type f -exec .{} \; > /data/stdout.log 2> /data/sterr.log
```
Then inspect `$localfolder/sterr.log` and search for "error while loading shared libraries"   
