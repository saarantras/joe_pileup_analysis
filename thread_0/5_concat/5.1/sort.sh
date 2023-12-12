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
FILES=(inp_r1.bam  inp_r2.bam  k27_r1.bam  k27_r2.bam)

# Select the file based on the SLURM array task ID
BAM_FILE=${FILES[$SLURM_ARRAY_TASK_ID - 1]}

samtools sort -@4 --write-index ${BAM_FILE} -o ${BAM_FILE%.bam}.sorted.bam



