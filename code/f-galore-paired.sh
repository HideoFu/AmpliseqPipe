#!/bin/bash

# Input files: *_1.fastq, *_2.fastq
# Output files: *_1_val_1.fq, *_2_val_2.fq

CORE=$EXPcore    # number of CPU cores. exported from 'main.sh' and so on.

mkdir Raw
mkdir Trimmed
mkdir FastQC

trim_galore -o Trimmed -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -a2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --paired ${EXP1}_1.fastq ${EXP1}_2.fastq --fastqc --fastqc_args "--nogroup -t $CORE -o FastQC"

mv ${EXP1}_1.fastq ./Raw
mv ${EXP1}_2.fastq ./Raw
