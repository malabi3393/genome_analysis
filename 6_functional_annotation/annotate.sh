#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 04:30:00
#SBATCH -J annotate
#SBATCH --mail-type=ALL
#SBATCH --mail-user mariam.alabi@outlook.com
#SBATCH --output=%x.%j.out



module load bioinfo-tools
module load prokka

IN=/home/maal9346/genome_analysis/4_binning/bins
WRDIR=/home/maal9346/genome_analysis/6_functional_annotation
for b in $IN/*.fa
do
#removes full path name
filename=$(basename "$b")
#removes extension 
name=${filename%.fa}

prokka --outdir $WRDIR/$name --prefix $name $b

done