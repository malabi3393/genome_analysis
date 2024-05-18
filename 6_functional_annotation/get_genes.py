import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import os
import re
from venn import venn 

"""
I wanted to create tables that show the most common genes found on prokka and creating a table
The tables were filtered, showing only genes whose count is equal to 5

I also created a Venn diagram to show which of those genes are in common

"""

bin_genes = {}

fl = []
try:
    with open('/home/maal9346/genome_analysis/5_binning_evaluation/top_bins.txt', 'r') as f:
        fl = f.read().splitlines()
except FileNotFoundError as e:
        print(f"{e} not found.")

for bin in fl:
     file_path = os.path.join('/home/maal9346/genome_analysis/6_functional_annotation/top_five', bin, f"{bin}.tsv")
     df = pd.read_csv(file_path, sep= '\t')
     product_counts = df['product'].value_counts()
     product_counts = product_counts.to_frame().reset_index()
     product_counts.columns = ['product', 'count']
     notTrimmed = product_counts.copy()
     product_counts = product_counts[product_counts['count'] > 5]

     

     fig, ax = plt.subplots() # Adjust the size of the figure as needed
     ax.axis('tight')
     ax.axis('off')
     table = pd.plotting.table(ax, product_counts, loc='center', cellLoc='center')
     bin_no = re.sub(r"[^0-9]","", bin)
     bin_genes[f'Bin {bin_no}'] = set(notTrimmed.iloc[:, 0])
     plt.title(f'Genes in Bin {bin_no}', fontsize=16)
     # Save the table as a PNG image
     plt.savefig(f'bin{bin_no}_genes.png', bbox_inches='tight', pad_inches=0.1)
     plt.close()


diagram = venn(bin_genes)
fig, ax = plt.gcf(), plt.gca() # Adjust the size of the figure as needed
ax.axis('tight')
ax.axis('off')
plt.savefig('common_genes.png')
plt.close()

