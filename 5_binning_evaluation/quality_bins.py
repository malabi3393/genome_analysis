import pandas as pd
import re 
import ast
import matplotlib.pyplot as plt



df = pd.read_csv('/home/maal9346/genome_analysis/5_binning_evaluation/checkm_results/storage/bin_stats_ext.tsv', sep ='\t', header = None)

dicti={}
for _, row in df.iterrows():
    dicti[row[0]] = ast.literal_eval(row[1])

sorted_data = dict(sorted( dicti.items(), key = lambda x: x[1]['Completeness']))

for k, v in sorted_data.items():
    sorted_data[k] = [v['Completeness'], v['Contamination']]

sorted_datas = dict(sorted(sorted_data.items(), key = lambda kv : -kv[1][0]))

complete_filter = {k: v for k,v in sorted_datas.items() if v[0] > 80}
contaim_complete_filter = {k: v for k,v in complete_filter.items() if v[1] < 100}

f = open("/home/maal9346/genome_analysis/5_binning_evaluation/top_bins_combined.txt", "w+")

for i, k in zip(range(5), contaim_complete_filter.items()):
    f.write(f"{k[0]}\n")

f.close()

sorted_data = dict(sorted( dicti.items(), key = lambda x: int(re.sub(r"[^0-9]","", x[0]))))

cols = list(sorted_data.get('bin_no.7_133').keys())

df2 = pd.DataFrame.from_dict(sorted_data , orient='index', columns=cols)
to_keep = ['Completeness', 'Contamination', 'Mean contig length', 'N50 (contigs)']

for name in cols:
    if name not in to_keep:
        df2 = df2.drop(name, axis = 1)
top_bins = []
try: 
    with open('/home/maal9346/genome_analysis/5_binning_evaluation/top_bins_combined.txt', 'r') as f:
        top_bins = f.read()
        top_bins = top_bins.split()
except FileNotFoundError:
    print("file not found")

df3 = df2.copy()

for row in df3.index:
    if row not in top_bins:
        df3 = df3.drop(row, axis = 0)
fig, ax = plt.subplots(figsize=(8, 2))  # Adjust the size of the figure as needed
ax.axis('tight')
ax.axis('off')

# Add the table to the axis
table = pd.plotting.table(ax, df3, loc='center', cellLoc='center')

# Save the table as a PNG image
plt.savefig('img/best_bins.png', bbox_inches='tight', pad_inches=0.1)
plt.close()


""""
generate the number of contigs for each bin 
"""

df = pd.read_csv('/home/maal9346/genome_analysis/5_binning_evaluation/checkm_results/storage/bin_stats.analyze.tsv', sep ='\t', header = None)
dicti={}
for _, row in df.iterrows():
    dicti[row[0]] = ast.literal_eval(row[1])

sorted_data = dict(sorted( dicti.items(), key = lambda x: x[1]['# contigs']))
for k, v in sorted_data.items():
    sorted_data[k] = [v['# contigs']]
cols = ['Number of Contigs']
df2 = pd.DataFrame.from_dict(sorted_data , orient='index', columns=cols)
df2['Number of Contigs'] = df2['Number of Contigs'].astype(int)
df2.loc['Total']= df2.sum()

fig, ax = plt.subplots(figsize=(8, 2))  # Adjust the size of the figure as needed
ax.axis('tight')
ax.axis('off')
table = pd.plotting.table(ax, df2, loc='center', cellLoc='center')

# Save the table as a PNG image
plt.savefig('img/num_contigs.png', bbox_inches='tight', pad_inches=0.1)
plt.close()