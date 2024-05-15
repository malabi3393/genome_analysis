#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 05:30:00
#SBATCH -J 7mapping
#SBATCH --mail-type=ALL
#SBATCH --mail-user mariam.alabi@outlook.com
#SBATCH --output=%x.%j.out



module load bioinfo-tools
module load bwa
module load samtools

#1. index the bin

REF_DIR=/home/maal9346/genome_analysis/4_binning/bins
READ_DIR=/home/maal9346/genome_analysis/0_rawdata/3_Thrash_2017/RNA_untrimmed
WRDIR=/home/maal9346/genome_analysis/7_mapping_rna_bin/top_5

mkdir -p $WRDIR/sam
mkdir -p $WRDIR/bam

# #do the indexing
# for ref in $REF_DIR/*.fa 
# do 
# #removes full path name 
# filename=$(basename "$ref")
# #removes extension
# name=${filename%.fa}
# bwa index $ref 
# done


while read bin
do 
filename=$(basename $REF_DIR/${bin}.fa)
name=${filename%.fa}
bwa index $REF_DIR/${bin}.fa 
for read1 in $READ_DIR/*.1.fastq.gz
do
#replace .1 with .2
read2=${read1/.1/.2}
read_filename=$(basename "$read1")
read_name=${read_filename%.*.fastq.gz}
bwa mem -t 8 $REF_DIR/${bin}.fa $read1 $read2 > $WRDIR/sam/${bin}_${read_name}.sam
#convert to bam
samtools view -b $WRDIR/sam/${bin}_${read_name}.sam > $WRDIR/bam/${bin}_${read_name}.bam

#remove the sam 
rm $WRDIR/sam/${bin}_${read_name}.sam

#sort the bam files
samtools sort -o $WRDIR/sorted_bam/${bin}_${read_name}.sorted.bam $WRDIR/bam/${bin}_${read_name}.bam



# #try sorting sam files
# samtools sort -o $WRDIR/sorted_sam/${name}_${read_name}.sorted.sam $WRDIR/sam/${name}_${read_name}.sam

done
done < /home/maal9346/genome_analysis/5_binning_evaluation/top_bins.txt

# #remove sam files 
# rm -r $WRDIR/sam

# #remove bam files 
# rm -r $WRDIR/bam
    
    

