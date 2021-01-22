Write a script :   
1. Create script.sh    
2. Place it within Dockerfile directory   
3. Add the following lines to Dockerfile build instructions (above CMD)  
- `COPY script.sh /`   
- `RUN chmod ugo+rwx /script.sh`   
4. Build docker image as shown above   
5. Run docker `sudo docker run -it --rm -v $localfolder:/data $name /script.sh /data/$localsubfolder /data/$localsubfolder`   
, where `$localsubfolder` is a subfolder inside `$localfolder` (or a symbolic link), which must have `rwx` chmod for all users.   
