# anima-docker

[Install instructions](https://github.com/sergeicu/anima-docker/install-docker.md) 


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
