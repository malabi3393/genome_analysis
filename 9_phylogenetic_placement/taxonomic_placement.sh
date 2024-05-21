#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 12:30:00
#SBATCH -J 9_phyloplan_COMBINED
#SBATCH --mail-type=ALL
#SBATCH --mail-user mariam.alabi@outlook.com
#SBATCH --output=%x.%j.out


# Load modules
module load bioinfo-tools
module load megahit

module load conda
export CONDA_ENVS_PATH=/proj/uppmax2024-2-7/Genome_Analysis/conda_envs
source conda_init.sh
conda activate phylophlan


phylophlan_assign_sgbs -i /home/maal9346/genome_analysis/4_binning/combined \
                        -e fa \
                        -n 1 \
                        -o metagenome_phylogenetic_placement_combiend \
                        --database_folder /proj/uppmax2024-2-7/Genome_Analysis/conda_envs/SGB/phylophlan_database \
                        -d SGB.Jan21 \
                        --verbose 2>&1 | tee logs/phylophlan_metagenomic.log




