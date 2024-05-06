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
WRDIR=/home/maal9346/genome_analysis/7_mapping_rna_bin

mkdir -p $WRDIR/sam

# #do the indexing
# for ref in $REF_DIR/*.fa 
# do 
# #removes full path name 
# filename=$(basename "$ref")
# #removes extension
# name=${filename%.fa}
# bwa index $ref 
# done

for ref in $REF_DIR/*.fa 
do
filename=$(basename "$ref")
name=${filename%.fa}
bwa index $ref 
for read1 in $READ_DIR/*.1.fastq.gz
do
#replace .1 with .2
read2=${read1/.1/.2}
read_filename=$(basename "$read1")
read_name=${read_filename%.*.fastq.gz}
bwa mem -t 8 $ref $read1 $read2 > $WRDIR/sam/${name}_${read_name}.sam
#convert to bam
samtools view -b $WRDIR/sam/${name}_${read_name}.sam > $WRDIR/bam/${name}_${read_name}.bam
#remove sam files 
rm -r $WRDIR/sam
#sort the bam files
samtools sort -o $WRDIR/sorted_bam/${name}_${read_name}.sorted.bam $WRDIR/bam/${name}_${read_name}.bam

#remove bam files 
rm -r $WRDIR/bam

# #try sorting sam files
# samtools sort -o $WRDIR/sorted_sam/${name}_${read_name}.sorted.sam $WRDIR/sam/${name}_${read_name}.sam

done
done
    
    

