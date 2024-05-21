# Genome Analysis 2024: 
### Mariam Alabi


This github reporsitory is created with the goal of recreating the results from the paper "Metabolic Roles of Uncultivated Bacterioplankton Lineages in the Northern Gulf of Mexico "Dead Zone"", by Thrash _et al._ for 1MB462 Genome Analysis at Uppsala University.

The order of the scripts  exceuted are based on the numbering of the directories. They were each run as a batch script:
```
sbatch script_name.sh
```
Some subdirectories contain python files, with the purpose of generating figures and tables. The generated images can be found in the img/ folder of the directory. They must be run **AFTER** running the bash script for that folder.

For example, in directory `5_binning_evaluation`, it would be run as:

```
sbatch bin_evaluation.sh
python3 quality_bins.py
```
