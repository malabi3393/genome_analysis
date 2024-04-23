from git.repo import Repo
import os 
HOME = os.environ.get("HOME")


REPO = os.path.join(HOME,'genome_analysis')

curr = os.path.join(REPO, '3_assembly_evaluation')
r = Repo(REPO)

print(curr)

for file in os.scandir(curr):
	file_path =file.path
	print(file_path)
	print("I AM GERE") 
	file_stats = os.stat(file_path)
	file_size = file_stats.st_size
	if file_size < 1000000:
		r.index.add([file_path])
		r.index.commit("add file")
		origin = r.remotes[0]
		origin.push()
		
