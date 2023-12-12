#!/bin/bash


# Generate a list of file pairs
for forward_paired in /home/mcn26/palmer_scratch/joe/data/trimmed/*1_paired.fastq
do
    reverse_paired="${forward_paired/1_paired.fastq/2_paired.fastq}"
    if [ -f "$reverse_paired" ]; then
        echo "$forward_paired $reverse_paired"
    fi
done > file_pairs_list.txt

