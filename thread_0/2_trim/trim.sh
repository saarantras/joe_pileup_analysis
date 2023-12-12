#!/bin/bash
#SBATCH -c 10 --mem=20g
#SBATCH -t 4:00:00
#SBATCH --mail-user=mackenziecnoon@gmail.com
#SBATCH --mail-type=END,FAIL
#SBATCH -p ycga

module load Trimmomatic

ADAPTER_FILE="./adapters.fa"

basedir="/home/mcn26/palmer_scratch/joe/data/chip"

trim="java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar"

for forward in ${basedir}/*_1.fastq
do
    # Define the corresponding reverse file
    reverse="${forward/_1.fastq/_2.fastq}"

    # Check if the reverse file exists
    if [ -f "$reverse" ]; then
        # Output file names
        forward_paired="${forward/.fastq/_paired.fastq}"
        forward_unpaired="${forward/.fastq/_unpaired.fastq}"
        reverse_paired="${reverse/.fastq/_paired.fastq}"
        reverse_unpaired="${reverse/.fastq/_unpaired.fastq}"

        # Run Trimmomatic
        $trim PE \
            "$forward" "$reverse" \
            "$forward_paired" "$forward_unpaired" \
            "$reverse_paired" "$reverse_unpaired" \
            ILLUMINACLIP:$ADAPTER_FILE:2:30:10 \
            LEADING:30 TRAILING:30 \
            MINLEN:1
    else
        echo "Reverse file for $forward not found."
    fi
done
