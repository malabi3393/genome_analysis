#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 25:30:00
#SBATCH -J count2may18
#SBATCH --mail-type=ALL
#SBATCH --mail-user mariam.alabi@outlook.com
#SBATCH --output=%x.%j.ou

BINDIR=/home/maal9346/genome_analysis/6_functional_annotation
READ1_1=/home/maal9346/genome_analysis/0_rawdata/3_Thrash_2017/RNA_untrimmed/SRR4342137.1.fastq.gz
READ1_2=/home/maal9346/genome_analysis/0_rawdata/3_Thrash_2017/RNA_untrimmed/SRR4342137.2.fastq.gz
READ2_1=/home/maal9346/genome_analysis/0_rawdata/3_Thrash_2017/RNA_untrimmed/SRR4342139.1.fastq.gz
READ2_2=/home/maal9346/genome_analysis/0_rawdata/3_Thrash_2017/RNA_untrimmed/SRR4342139.2.fastq.gz
MAP=/home/maal9346/genome_analysis/7_mapping_rna_bin/sorted_bam

module load bioinfo-tools
module load htseq
module load samtools
module load bowtie2



while read bin 
do 

sed '/^##FASTA/Q' $BINDIR/${bin}/${bin}.gff > $BINDIR/${bin}/${bin}_noseq.gff
gff=$BINDIR/${bin}/${bin}_noseq.gff
binFile=$BINDIR/${bin}/${bin}.faa


bowtie2-build -f $binFile $binFile

htseq-count ${MAP}/${bin}_SRR4342137.sorted.bam $gff -t CDS -i product --nonunique none > ${bin}_137.forward.counts.txt

htseq-count ${MAP}/${bin}_SRR4342139.sorted.bam $gff -t CDS -i product --nonunique none > ${bin}_139.forward.counts.txt





done < /home/maal9346/genome_analysis/5_binning_evaluation/top_bins_combined.txt