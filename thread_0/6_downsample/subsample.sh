#!/bin/bash
#SBATCH -c 12 --mem=32g
#SBATCH -t 1:00:00
#SBATCH --mail-user=mackenziecnoon@gmail.com
#SBATCH --mail-type=END,FAIL
#SBATCH -p ycga

module load SAMtools

module load picard

cd /home/mcn26/palmer_scratch/joe/data/merged


# Ensure that Picard is in your PATH or specify its path here
PICARD_PATH=picard.jar

# Input BAM files
TARGET_BAM="k27_merge.bam"
LARGE_BAM="inp_merge.bam"

# Output BAM file
OUTPUT_BAM="inp_subsample.bam"

# Calculate the number of reads in each BAM file
TARGET_READS=$(samtools view -c "$TARGET_BAM")
LARGE_READS=$(samtools view -c "$LARGE_BAM")

# Calculate subsampling ratio
RATIO=$(echo "$TARGET_READS / $LARGE_READS" | bc -l)

# Subsample the larger BAM file
java -jar $EBROOTPICARD/picard.jar DownsampleSam \
    I=$LARGE_BAM \
    O=$OUTPUT_BAM \
    P=$RATIO

echo "Subsampling completed. Output is in $OUTPUT_BAM"

