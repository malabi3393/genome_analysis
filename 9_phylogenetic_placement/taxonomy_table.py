import os
import pandas as pd
import re 
import matplotlib.pyplot as plt


df = pd.read_csv('metagenome_phylogenetic_placement_combiend.tsv', sep = '\t')
cols = df.columns[1]
cols = cols.split(':')
cols.insert(0, 'bin')
newdf = df['[u|k]_[S|G|F]GBid:taxa_level:taxonomy:avg_dist'].str.split(':', expand=True)
newdf = newdf[:21]
bins = pd.DataFrame(df['#input_bin'][:21])
newdfs = pd.concat([bins, newdf], axis = 1)
newdfs.columns = cols

fig, ax = plt.subplots() # Adjust the size of the figure as needed
fig.set_size_inches(20, 20)
ax.axis('off')
table = pd.plotting.table(ax, newdfs, loc='center', cellLoc='center')
table.auto_set_font_size(False)
table.set_fontsize(10)  # Set desired font size
plt.title(f'Taxonomic Allocation', fontsize=16)
# Save the table as a PNG image
newdfs.to_csv(f'Taxonomy.csv', index = False)
plt.close()