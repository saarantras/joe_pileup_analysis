#!/bin/bash
#SBATCH -c 15 --mem=64g
#SBATCH -t 4:00:00
#SBATCH --mail-user=mackenziecnoon@gmail.com
#SBATCH --mail-type=END,FAIL
#SBATCH --array=1-4
#SBATCH --output=align_reads_%A_%a.out
#SBATCH --error=align_reads_%A_%a.err
#SBATCH -p ycga

module load Bowtie2

BOWTIE_INDEX="/gpfs/gibbs/data/genomes/Homo_sapiens/UCSC/hg38/Sequence/Bowtie2Index/genome"

# Read file pair from the list
file_pair=$(sed -n "${SLURM_ARRAY_TASK_ID}p" file_pairs_list.txt)
forward_paired=$(echo $file_pair | cut -d ' ' -f 1)
reverse_paired=$(echo $file_pair | cut -d ' ' -f 2)

# Output SAM file name
sam_file="${forward_paired/_1_paired.fastq/.sam}"

bowtie_command="bowtie2 -x $BOWTIE_INDEX -1 $forward_paired -2 $reverse_paired -S $sam_file"

# Print the command
echo "Running command: $bowtie_command"

# Execute the command
eval $bowtie_command

