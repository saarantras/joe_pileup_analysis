#!/bin/bash
#SBATCH -c 5 --mem=5g
#SBATCH -t 4:00:00
#SBATCH --mail-user=mackenziecnoon@gmail.com
#SBATCH --mail-type=END,FAIL

#SRR14005196 is GSM5183542 is "H3K27me3 ChIP-seq #1 on H1 WT hESCs"
#SRR14005197 is GSM5183543 is "H3K27me3 ChIP-seq #2 on H1 WT hESCs"

#SRR14005231  GSM5183577 	Input sample from H1 WT hESCs #1
#SRR14005232  GSM5183578 	Input sample from H1 WT hESCs #2

cd /home/mcn26/palmer_scratch/joe/data/chip

module load SRA-Toolkit

SRR_ids=(SRR14005196 SRR14005197 SRR14005231 SRR14005232)

# Loop through each SRR ID
for srr_id in "${SRR_ids[@]}"
do
    echo "Processing $srr_id"
    
    # Download and dump to FASTQ using fastq-dump
    # Note: --split-files option is used in case of paired-end reads
    fasterq-dump --split-files $srr_id

    echo "$srr_id processing complete"
done

echo "All downloads complete"


