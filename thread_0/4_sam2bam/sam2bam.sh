#!/bin/bash
#SBATCH -c 16 --mem=32g
#SBATCH -t 4:00:00
#SBATCH --mail-user=mackenziecnoon@gmail.com
#SBATCH --mail-type=END,FAIL
#SBATCH --array=1-4
#SBATCH -p ycga

module load SAMtools


cd /home/mcn26/palmer_scratch/joe/data/aligned

# Define an array of file names
FILES=($(ls *.sam))

# Select the file based on the SLURM array task ID
SAM_FILE=${FILES[$SLURM_ARRAY_TASK_ID - 1]}

# Convert SAM to BAM
samtools view -bS ${SAM_FILE} > ${SAM_FILE%.sam}.bam

#run commands...
