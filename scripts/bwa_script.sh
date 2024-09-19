#!/usr/bin/bash

# this causes the script to stop and extit if there is an error
set -uex


echo hello please wait while I perform the alignment

bio fetch $1 --format fasta > refs/$1.fa

fastq-dump -X 10000 --split-files $2

bwa index refs/$1.fa

bwa mem refs/$1.fa $2_1.fastq > output.sam

samtools sort output.sam  -o ouput.sorted.bam
