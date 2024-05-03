#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J 2_dna_assembly
#SBATCH --mail-type=ALL
#SBATCH --mail-user mariam.alabi@outlook.com
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load megahit
WRDIR=/home/maal9346/genome_analysis/0_rawdata/3_Thrash_2017/DNA_trimmed  


megahit -1 $WRDIR/SRR4342133_1.paired.trimmed.fastq.gz -2 $WRDIR/SRR4342133_1.paired.trimmed.fastq.gz \
        -o megahit_results_133
