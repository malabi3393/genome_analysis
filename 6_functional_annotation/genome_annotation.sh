#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 12:30:00
#SBATCH -J annotate_top_5
#SBATCH --mail-type=ALL
#SBATCH --mail-user mariam.alabi@outlook.com
#SBATCH --output=%x.%j.out



module load bioinfo-tools
module load prokka

IN=/home/maal9346/genome_analysis/4_binning
WRDIR=/home/maal9346/genome_analysis/6_functional_annotation

while read bin
do 
for b in $IN/${bin}.fa
do
filename=$(basename "$b")
name=${filename%.fa}
prokka --outdir $WRDIR/$name --prefix $name $b
done
done < /home/maal9346/genome_analysis/5_binning_evaluation/top_bins_combined.txt