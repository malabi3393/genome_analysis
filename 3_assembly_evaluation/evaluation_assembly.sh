#!/bin/bash -l
#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 28:30:00
#SBATCH -J 3_dna_eval_both
#SBATCH --mail-type=ALL
#SBATCH --mail-user mariam.alabi@outlook.com
#SBATCH --output=%x.%j.out


module load bioinfo-tools
module load quast


WRDIR=/home/maal9346/genome_analysis

python quast/quast.py -o $WRDIR/3_assembly_evaluation/quast_133 $WRDIR/2_dna_assembly/megahit_results_133/final.contigs.fa
python quast/quast.py -o $WRDIR/3_assembly_evaluation/quast_129 $WRDIR/2_dna_assembly/megahit_results_129/final.contigs.fa