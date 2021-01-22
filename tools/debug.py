""" THe purpose of this script is to restart a half completed job with the anima container after the container it had already processed some images in the given directory. 

This script copies all the preprocessed files, including the input files, into a separate directory. 

Run: 
python debug.py <datadir> <newdir>

"""

import os 
import shutil 
import glob 
import sys 

def move(file,newdir):
    src = file 
    dest = newdir+ "/" + os.path.basename(src)
    shutil.move(src, dest)

if __name__ == '__main__':
    
    datadir = sys.argv[1] # '/home/ch215616/fastscratch/TEMP_anima/volunteer/anima/'
    newdir = sys.argv[2]
    
    # find all the files that have been processed by inspecting the calculated b1 maps 
    b1s = glob.glob(datadir+'/'+'*b1.nii.gz')
    
    for b1 in b1s:
        print(b1)
        
        # find the remaining files 
        output = b1.replace("_b1.nii.gz","_out.nii.gz")
        weights = b1.replace("_b1.nii.gz", "_weights.nii.gz")
        m0 = b1.replace("_b1.nii.gz", "_m0.nii.gz")
        sigma_square = b1.replace("_b1.nii.gz", "_sigmasquare.nii.gz")
        original = b1.replace("_b1.nii.gz", ".nii.gz")       
        
        # assert existence of all the output files first, before moving 
        assert os.path.exists(output)
        assert os.path.exists(weights)
        assert os.path.exists(m0)
        assert os.path.exists(sigma_square)
        assert os.path.exists(original)
    
        # move all these files to new location 
        os.makedirs(newdir,exist_ok=True)        
        move(b1,newdir)
        move(output,newdir)
        move(weights,newdir)
        move(m0,newdir)
        move(sigma_square,newdir)
        move(original,newdir)


        