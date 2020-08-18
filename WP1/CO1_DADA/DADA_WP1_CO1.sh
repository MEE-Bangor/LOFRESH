#!/bin/bash
#############################
### Job Descriptors ###
#SBATCH --account=scw1081
## Job name
#SBATCH --job-name=DADA_WP2A_CO1
## Job stdout file
#SBATCH --output=DADA_WP2A_CO1.out%J
## Job stderr file
#SBATCH --error=DADA_WP2A_CO1.err%J
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
#SBATCH --mem 40000MB
## Partition to run the job on (run on htc or dev if testing. dev jobs are limited to 1 hour)
#SBATCH -p htc
## Rough amount of time the job will take to run (default is 3 days, this is set for 1 hour 30 minutes)
#SBATCH -t 72:00:00
#############################

module purge
module load R/3.6.2
R
Rscript DADA_WP1_CO1.R