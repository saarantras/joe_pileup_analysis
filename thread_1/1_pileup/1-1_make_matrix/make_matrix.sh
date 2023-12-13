#!/bin/bash
#SBATCH --job-name=computematrix
#SBATCH --output=%x_%A_%a.out
#SBATCH --error=%x_%A_%a.err
#SBATCH --time=03:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=3
#SBATCH --array=1-16
#SBATCH -p ycga

module load deepTools

# Directories containing BED and BW files
bed_dir="/home/mcn26/palmer_scratch/joe/data/de_beds"
bw_dir="/home/mcn26/palmer_scratch/joe/data/bigwig"

# Create arrays of BED and BW files
bed_files=($(ls $bed_dir/*.bed))
bw_files=($(ls $bw_dir/*.bw))

# Compute the total number of BED and BW files
num_bed_files=${#bed_files[@]}
num_bw_files=${#bw_files[@]}

# Calculate the indices for BED and BW files
bed_index=$(( ($SLURM_ARRAY_TASK_ID - 1) / num_bw_files ))
bw_index=$(( ($SLURM_ARRAY_TASK_ID - 1) % num_bw_files ))

# Get the file names
bed_file=${bed_files[$bed_index]}
bw_file=${bw_files[$bw_index]}

# Extract the base names without extensions
bed_base=$(basename $bed_file .bed)
bw_base=$(basename $bw_file .bw)

# Construct the output matrix file name
output_matrix="${bed_base}_${bw_base}_matrix.gz"

# Run deepTools computematrix

computeMatrix reference-point --referencePoint TSS \
    -b 2000 -a 2000 \
    -R $bed_file \
    -S $bw_file \
    -o $output_matrix

echo "Processed BED file: $bed_file with BW file: $bw_file. Output: $output_matrix"
