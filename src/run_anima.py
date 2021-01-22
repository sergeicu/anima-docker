"""Example script - fetches all nifti files inside a given folder and processes with example anima function. 

Args: 
     datain (str): fullpath to input directory in which nifti files are located. Must have read-write permissions for all users. 

"""

import os 
import glob 
import sys 
import subprocess

def execute(cmd):
    """Execute commands in bash and print output to stdout directly"""
    with subprocess.Popen(cmd, stdout=subprocess.PIPE, bufsize=1, universal_newlines=True) as p:
        for line in p.stdout:
            print(line, end='') # process line here

    if p.returncode != 0:
        raise subprocess.CalledProcessError(p.returncode, p.args)


if __name__ == '__main__':     
    
    print("Hello from Anima")

    # init 
    datain = sys.argv[1]
    
    # get all files
    files = glob.glob(datain+"/*.nii.gz")
    assert files, f"No .nii.gz files found in: {datain}"

    print(f"Found {len(files)} .nii.gz files in the following path: {datain}")
    for f in files:
        print(f)
        
        # set output names 
        output = f.replace(".nii.gz", "_out.nii.gz")
        weights = f.replace(".nii.gz", "_weights.nii.gz")
        m0 = f.replace(".nii.gz", "_m0.nii.gz")
        b1 = f.replace(".nii.gz", "_b1.nii.gz")
        sigma_square = f.replace(".nii.gz", "_sigmasquare.nii.gz")
        
                
        # skip already processed: 
        if os.path.exists(output):
            continue
        
        # example function 
	# replace with another function or create a platform for running all arguments passed via sys.argv 
        cmd = ["/anima/animaGMMT2RelaxometryEstimation", "-e", "9", "-i", f, "-o", output, "-O", weights, "--out-m0", m0, "--out-b1", b1, "--out-sig", sigma_square]
        execute(cmd)


        
        
        
# Example of running anima from CLI     
# ./animaGMMT2RelaxometryEstimation -e 9 -o out2.nii.gz -i volunteer1.nii.gz -O weights_im.nii.gz --out-m0 m0.nii.gz --out-b1 B1.nii.gz --out-sig sigma-square.nii.gz
    
