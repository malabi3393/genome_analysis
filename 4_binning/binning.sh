#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J 4_binning_0428_627PM
#SBATCH --mail-type=ALL
#SBATCH --mail-user mariam.alabi@outlook.com
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load MetaBat


export FILEPATH=/home/maal9346/genome_analysis/2_dna_assembly




metabat -i $FILEPATH/megahit_results_129/final.contigs.fa $FILEPATH/megahit_results_133/final.contigs.fa -o bin_no 