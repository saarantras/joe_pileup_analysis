#!/bin/bash
#SBATCH -c 16 --mem=32g
#SBATCH -t 4:00:00
#SBATCH --mail-user=mackenziecnoon@gmail.com
#SBATCH --mail-type=END,FAIL
#SBATCH -p ycga

module load SAMtools

cd /home/mcn26/palmer_scratch/joe/data/aligned

samtools merge -@ 16 inp_merge.bam inp_r1.sorted.bam inp_r2.sorted.bam

samtools merge -@ 16 k27_merge.bam k27_r1.sorted.bam k27_r2.sorted.bam



