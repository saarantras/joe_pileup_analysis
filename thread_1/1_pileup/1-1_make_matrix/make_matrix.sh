#!/bin/bash
#SBATCH --job-name=computematrix
#SBATCH --output=%x_%A_%a.out
#SBATCH --error=%x_%A_%a.err
#SBATCH --time=03:00:00
#SBATCH --mem=128G
#SBATCH --cpus-per-task=3
#SBATCH --array=1-16
#SBATCH -p ycga

module load deepTools

# Directories containing BED and BAM files
bed_dir="/home/mcn26/palmer_scratch/joe/data/de_beds"
bam_dir="/home/mcn26/palmer_scratch/joe/data/bams"

# Create arrays of BED and BAM files
bed_files=($(ls $bed_dir/*.bed))
bam_files=($(ls $bam_dir/*.bam))

# Compute the total number of BED and BAM files
num_bed_files=${#bed_files[@]}
num_bam_files=${#bam_files[@]}

# Calculate the indices for BED and BAM files
bed_index=$(( ($SLURM_ARRAY_TASK_ID - 1) / num_bam_files ))
bam_index=$(( ($SLURM_ARRAY_TASK_ID - 1) % num_bam_files ))

# Get the file names
bed_file=${bed_files[$bed_index]}
bam_file=${bam_files[$bam_index]}

# Extract the base names without extensions
bed_base=$(basename $bed_file .bed)
bam_base=$(basename $bam_file .bam)

# Construct the output matrix file name
output_matrix="${bed_base}_${bam_base}_matrix.gz"

# Run deepTools computematrix

computeMatrix reference-point --referencePoint TSS \
    -b 2000 -a 2000 \
    -R $bed_file \
    -S $bam_file \
    -o $output_matrix

echo "Processed BED file: $bed_file with BAM file: $bam_file. Output: $output_matrix
