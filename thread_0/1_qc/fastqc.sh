#!/bin/bash
#SBATCH -c 5 --mem=5g
#SBATCH -t 1:00:00
#SBATCH --mail-user=mackenziecnoon@gmail.com
#SBATCH --mail-type=END,FAIL

module load FastQC

# Loop through each .fastq file in the current directory
for fastq_file in /home/mcn26/palmer_scratch/joe/data/chip/*.fastq
do
    # Create a directory for FastQC output, named after the FASTQ file
    output_dir="${fastq_file%.*}_fastqc_output"
    mkdir -p "$output_dir"

    # Run FastQC and direct the output to the created directory
    fastqc -o "$output_dir" "$fastq_file"

    echo "FastQC analysis completed for $fastq_file"
done

echo "All FastQC analyses are complete"
