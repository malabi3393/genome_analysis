#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J 5_binning_eval_0428_643PM
#SBATCH --mail-type=ALL
#SBATCH --mail-user mariam.alabi@outlook.com
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load CheckM/1.0.12

#run check 
checkm lineage_wf  -t 8 -x fa /home/maal9346/genome_analysis/4_binning/bins /home/maal9346/genome_analysis/5_binning_evaluation/checkm