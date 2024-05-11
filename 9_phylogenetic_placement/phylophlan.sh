#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 12:30:00
#SBATCH -J 9_phyloplan
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


# 

phylophlan_assign_sgbs -i /home/maal9346/genome_analysis/9_phylogenetic_placement/bins \
                        -o metagenome_phylogenetic_placement \
                        --database_folder /proj/uppmax2024-2-7/Genome_Analysis/conda_envs/SGB/phylophlan_database \
                        -d SGB.Jan21 \
                        --verbose 2>&1 | tee logs/phylophlan_metagenomic.log




#IN=/home/maal9346/genome_analysis/4_binning/bins
# meta_genomes=""

# while read bin
# do 
# meta_genomes+="${IN}/${bin}.fa "
# done < /home/maal9346/genome_analysis/5_binning_evaluation/top_bins.txt

# echo $meta_genomes are the files

# """
# phylophlan_assign_sgbs \
#     -i input_metagenomic \
#     -o output_metagenomic \
#     --nproc 4 \
#     -n 1 \
#     -d ethiopia_tutorial \
#     --database_folder ethiopia_tutorial_db \
#     --verbose 2>&1 | tee logs/phylophlan_metagenomic.log

# """


