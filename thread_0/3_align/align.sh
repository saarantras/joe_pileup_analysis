#!/bin/bash
#SBATCH -c 5 --mem=5g
#SBATCH -t 1:00:00
#SBATCH --mail-user=mackenziecnoon@gmail.com
#SBATCH --mail-type=END,FAIL

#module load whatever
/gpfs/gibbs/data/genomes/Homo_sapiens/UCSC/hg38/Sequence

cd ~/project

#run commands...
