#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 05:30:00
#SBATCH -J counts
#SBATCH --mail-type=ALL
#SBATCH --mail-user mariam.alabi@outlook.com
#SBATCH --output=%x.%j.out

module load bioinfo-tools
module load htseq
module load samtools


ALI=/home/maal9346/genome_analysis/7_mapping_rna_bin/sorted_bam
GFF=/home/maal9346/genome_analysis/6_functional_annotation



alignment_files="" #the sorted bam 
for file in $ALI/*.sorted.bam
do 
samtools index $file
alignment_files+="${file} " 
done

echo $alignment_files

for bin in $GFF/bin.*
do
#removes full path name
bin_no=$(basename "$bin")
htseq-count -f bam $alignment_files $bin/${bin_no}_noseq.gff > output_counts.txt
done 