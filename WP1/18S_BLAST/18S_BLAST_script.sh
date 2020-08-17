#!/bin/bash
#############################
### Job Descriptors ###
#SBATCH --account=scw1081
## Job name
#SBATCH --job-name=BLAST_18S
## Job stdout file
#SBATCH --output=BLAST_18S.out%J
## Job stderr file
#SBATCH --error=BLAST_18S.err%J
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
export BLASTDB=/nfshome/store02/users/b.bsp81d/Lofresh_raw_data/WP1/Davies_metabarcoding_analysis/18S_BLAST/

blastn -query /nfshome/store02/users/b.bsp81d/Lofresh_raw_data/WP1/Davies_metabarcoding_analysis/18S_BLAST/WP1_18S_tax_tab_BLAST.fasta -out /nfshome/store02/users/b.bsp81d/Lofresh_raw_data/WP1/Davies_metabarcoding_analysis/18S_BLAST/BLAST_OUTPUT.txt -evalue 0.00001 -db /nfshome/store02/users/b.bsp81d/Lofresh_raw_data/WP1/Davies_metabarcoding_analysis/18S_BLAST/18S_local_BLASTdb -outfmt '6 qseqid sseqid pident evalue staxids sscinames scomnames sskingdoms stitle' -max_target_seqs 10   
