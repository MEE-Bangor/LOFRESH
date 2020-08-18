#!/bin/bash
#############################
### Job Descriptors ###
#SBATCH --account=scw1081
## Job name
#SBATCH --job-name=cutadapt_demultiplex
## Job stdout file
#SBATCH --output=cutadapt_demultiplex.out%J
## Job stderr file
#SBATCH --error=cutadapt_demultiplex.err%J
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
module load cutadapt/2.3
perl 2_cutadapt_WP1_18S.pl FastqList_WP1_18S