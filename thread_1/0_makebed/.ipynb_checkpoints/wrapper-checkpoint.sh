#!/bin/bash
#SBATCH -J makebed
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem=5G
#SBATCH -t 4:00:00
#SBATCH -p ycga

module load miniconda
conda activate joezone

# Convert the Jupyter notebook to a Python script
jupyter nbconvert --to script makebed.ipynb

# Execute the converted Python script
python makebed.py

# Remove the Python script after execution
rm makebed.py
