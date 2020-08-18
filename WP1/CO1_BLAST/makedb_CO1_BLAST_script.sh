#!/bin/bash
#############################
### Job Descriptors ###
#SBATCH --account=scw1081
## Job name
#SBATCH --job-name=makedb_BLAST_18S
## Job stdout file
#SBATCH --output=makedb_BLAST_18S.out%J
## Job stderr file
#SBATCH --error=makedb_BLAST_18S.err%J
## Email me when the job has ended
#SBATCH --mail-type=ALL
#SBATCH --mail-user=w.perry@bangor.ac.uk
### Job resources ###
## Number of nodes
#SBATCH -N 1
## Number of tasks
#SBATCH -n 12
## Number of cores to give to each task
#SBATCH --cpus-per-task 1
## Amount of RAM
#SBATCH --mem 17000MB
## Partition to run the job on (run on htc or dev if testing. dev jobs are limited to 1 hour)
#SBATCH -p htc
## Rough amount of time the job will take to run (default is 3 days)
#SBATCH -t 12:00:00
#############################
module purge
module load  BLAST/2.10.0+

makeblastdb -in /nfshome/store02/users/b.bsp81d/Lofresh_raw_data/WP1/Davies_metabarcoding_analysis/CO1_BLAST/CO1_NCBI_database.fasta -out /nfshome/store02/users/b.bsp81d/Lofresh_raw_data/WP1/Davies_metabarcoding_analysis/CO1_BLAST/CO1_local_BLASTdb -dbtype nucl -parse_seqids -taxid_map /nfshome/store02/users/b.bsp81d/Lofresh_raw_data/WP1/Davies_metabarcoding_analysis/18S_BLAST/nucl_gb.accession2taxid -blastdb_version 5  