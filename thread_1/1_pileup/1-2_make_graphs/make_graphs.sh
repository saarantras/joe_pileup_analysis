#!/bin/bash
#SBATCH --job-name=pileup_plots
#SBATCH --output=pileup_%A_%a.out
#SBATCH --error=pileup_%A_%a.err
#SBATCH --array=1-16
#SBATCH --time=04:00:00
#SBATCH --mem=4G
#SBATCH -p ycga

# Load the module or software if needed
module load deepTools

# Define the directory where your matrices are
MATRIX_DIR="/home/mcn26/palmer_scratch/joe/data/matricies"

# Create an array of all matrix files
MATRIX_FILES=($(ls ${MATRIX_DIR}/*.gz))

# Select the matrix file for this array job
MATRIX_FILE=${MATRIX_FILES[$SLURM_ARRAY_TASK_ID - 1]}

# Define output plot name
OUTPUT_PLOT="${MATRIX_FILE%.matrix}_pileup.png"

# Run the command to create the pileup plot
plotProfile --matrix ${MATRIX_FILE} --outFileName ${OUTPUT_PLOT}

# End of script
