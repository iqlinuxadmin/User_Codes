#!/bin/bash
#SBATCH -J count_down
#SBATCH -o count_down.out
#SBATCH -e count_down.err
#SBATCH -p shared
#SBATCH -N 1
#SBATCH -c 1
#SBATCH -t 0-00:30
#SBATCH --mem=4000

# Load required software modules
module load R/3.5.1-fasrc01

# Run program
R CMD BATCH --no-save --no-restore count_down.R 

