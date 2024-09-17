#!/usr/bin/bash

#The genome accession number and SRR number need to be provided as arguments on the command line
#or illustration use AF086833 for the ebola genome and SRR1972739 for the SRR.  These sequences come from project PRJNA257197  

# this causes the script to stop and extit if there is an error
set -uex

# Here just sending a message to the user to say things are getting started
echo hello please wait while I perform the alignment

# bio fetch gets a gb file then with the format option downloads the fasta file.  $1 says to use the accession #number provided as the first argument on the command line

bio fetch $1 --format fasta > refs/$1.fa

#fastqdump downloads sequencing reads as fastq files.  -X 10000 limits the number of sequences downloaded.  split #files splits the paired reads into single reads _1 and _2.  The SRR number is provided as argument 2 on the #command line.

fastq-dump -X 10000 --split-files $2

#bwa index creates an index of the ref genome.  This index is used by bwa mem to map the reads
bwa index refs/$1.fa

# this is the actual mapping step.  This creates a SAM file of mapped reads.
bwa mem refs/$1.fa $2_1.fastq > output.sam

#this step sorts the mapped reads by position along the genome and converts the file to a bam file.
samtools sort output.sam  -o ouput.sorted.bam
