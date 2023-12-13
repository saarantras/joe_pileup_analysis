#!/bin/bash
#SBATCH --job-name=bam_to_bigwig
#SBATCH --output=bam_to_bigwig_%A_%a.out
#SBATCH --error=bam_to_bigwig_%A_%a.err
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH -p ycga

# Load deeptools module if available
module load deepTools
module load SAMtools

cd /home/mcn26/palmer_scratch/joe/data/bams

samtools index h3k27me3.bam

bamCoverage --bam h3k27me3.bam --outFileName h3k27me3.bw --binSize 10 --normalizeUsing RPKM

samtools index input.bam

bamCoverage --bam input.bam --outFileName input.bw --binSize 10 --normalizeUsing RPKM
