#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J read_quality_control
#SBATCH --mail-type=ALL
#SBATCH --mail-user mariam.alabi@outlook.com
#SBATCH --output=%x.%j.out


# Load modules
module load bioinfo-tools
module load FastQC

# Run quality checks
fastqc $HOME/genome_analysis/0_rawdata/3_Thrash_2017/DNA_trimmed/*.fastq.gz --outdir $HOME/genome_analysis/1_read_quality_control
