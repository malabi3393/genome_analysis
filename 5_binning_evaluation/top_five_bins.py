import os
import pandas as pd
import re 
import glob
import fnmatch
import ast




df = pd.read_csv('/home/maal9346/genome_analysis/5_binning_evaluation/checkm_results/storage/bin_stats_ext.tsv', sep ='\t', header = None)

dicti={}
for _, row in df.iterrows():
    dicti[row[0]] = ast.literal_eval(row[1])

sorted_data = dict(sorted( dicti.items(), key = lambda x: x[1]['Completeness']))

for k, v in sorted_data.items():
    sorted_data[k] = [v['Completeness'], v['Contamination']]

sorted_datas = dict(sorted(sorted_data.items(), key = lambda kv : -kv[1][0]))

test = {k: v for k,v in sorted_datas.items() if v[0] > 80}
test = {k: v for k,v in test.items() if v[1] < 100}

f = open("top_bins.txt", "w+")

for i, k in zip(range(5), test.items()):
    f.write(f"{k[0]}\n")

f.close()