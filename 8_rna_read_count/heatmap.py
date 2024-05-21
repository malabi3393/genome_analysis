import os
import pandas as pd
import re 
import matplotlib.pyplot as plt
import seaborn as sns

"""
Here I am creating heatmaps for my rna counts
There is one heatmap for each sample and a third in which they are combined

"""

X = 25
Y = 100
s = 10

curr = ""

path = '/home/maal9346/genome_analysis/8_rna_read_count'
ext = '.forward.counts.txt'
count_files = []

dfs_137 = pd.DataFrame()
dfs_139 = pd.DataFrame()

for root, dirs, files in os.walk(path):
    for n in files:
        if ext in n: count_files.append(n) 


for file in count_files:
    try:
        curr = file
        df = pd.read_csv(file, sep = '\t', header = None)
        bin_no = re.sub(r'[^0-9]', '', file)
        df.columns = ['gene', 'count']
        rna = int(bin_no[-3:])
        b = len(bin_no) - len(bin_no[-3:])
        bin_no = f'Bin {bin_no[:-6]}, Metagenome {bin_no[-6:-3]} RNA Sample {bin_no[-3:]}'
        df = df[df.iloc[:,1] > 0]
        df['source'] = bin_no
        df = df.sort_values('count', ascending=False)
        df = df[:s]
        if rna == 137:
            dfs_137 = pd.concat([dfs_137, df])
        else:
            dfs_139 = pd.concat([dfs_139, df])

    except pd.errors.EmptyDataError:
        print(f"No data can be found in {curr}, it will be skipped")
        continue

dfs_137 = dfs_137.sort_values('count', ascending=False)
dfs_139 = dfs_139.sort_values('count', ascending=False)

dfs = pd.concat([dfs_137, dfs_139])
dfs.sort_values('count', ascending= False, inplace = True)

heatmap_data_137 = dfs_137.pivot(index='gene', columns='source', values='count')

plt.figure(figsize=(X, Y))
sns.set_theme(font_scale=6)
sns.heatmap(heatmap_data_137, annot=True, cmap='coolwarm', fmt='g')

plt.savefig(f'img/HEATMAP_137.png', bbox_inches='tight', pad_inches=0.1)
plt.close()

heatmap_data_139 = dfs_139.pivot(index='gene', columns='source', values='count')
plt.figure(figsize=(X, Y))
sns.set_theme(font_scale=6)
sns.heatmap(heatmap_data_139, annot=True, cmap='coolwarm', fmt='g')
plt.savefig(f'img/HEATMAP_139.png', bbox_inches='tight', pad_inches=0.1)
plt.close()


hm = dfs.pivot(index='gene', columns='source', values='count')
plt.figure(figsize=(X, Y))
sns.set_theme(font_scale=6)
sns.heatmap(hm, annot=False, cmap='coolwarm', fmt='g')
plt.savefig(f'img/heatmap.png', bbox_inches='tight', pad_inches=0.1)
plt.close()
