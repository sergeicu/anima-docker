# create test directory 
cd ~
cd ~/fastscratch/trash/TEMP_ABD_FULL
mkdir example_data2 && cd example_data2
ls ~/abd/code/docker/anima/example_data
cp ~/abd/code/docker/anima/example_data/input.nii.gz .

# run_anima.py test 
data=/home/ch215616/fastscratch/trash/example_data2
python ~/code/mwf/synth_unet/train_anima/run_anima.py $data

# build a new docker image with the file 
cd ~/code/mwf/synth_unet/train_anima/
sudo docker build -t sergeicu/anima_t2_only_exec:latest .

# run the docker image as test 
sudo docker run -it --rm -v $data:/data sergeicu/anima_t2_only_exec echo "hello world"

# run docker image to process anima 
data=/home/ch215616/fastscratch/trash/example_data2
sudo docker run -it --rm -v $data:/data sergeicu/anima_t2_only_exec python run_anima.py /data

# create a script that fetches the argv and runs the whole thing 
data=/home/ch215616/fastscratch/trash/example_data2/v2 
cd ~/code/mwf/synth_unet/train_anima 
./anima_docker.sh $data 

# create a copy of all the raw data files - clinical 
outdir=~/fastscratch/TEMP_anima/clinical/anima/
indir=/home/ch215616/abd/mwf_data/mwf_maps_all_patients/clinical/julia/
ls ${indir}*[0-9].nii.gz | wc -l 
cp ${indir}*[0-9].nii.gz $outdir


# create a copy of all the raw data files - volunteer  
outdir=~/fastscratch/TEMP_anima/volunteer/anima/
indir=/home/ch215616/abd/mwf_data/mwf_maps_all_patients/volunteer/julia/
ls ${indir}*[0-9].nii.gz | wc -l 
cp ${indir}*[0-9].nii.gz $outdir

# run docker - volunteer 
data=~/fastscratch/TEMP_anima/volunteer/anima/
cd ~/code/mwf/synth_unet/train_anima 
./anima_docker.sh $data 

# run docker - clinical
data=~/fastscratch/TEMP_anima/clinical/anima/
cd ~/code/mwf/synth_unet/train_anima 
./anima_docker.sh $data 

