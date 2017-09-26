#!/bin/bash

export EXPcore=6
export EXPgene=/mnt/nas/public/Homo_sapiens/NCBI/build37.2/Annotation/genes.gtf

# argument must be "foo" of "foo_1.fastq"

while [ "$1" != "" ]
do
	export EXP1=$1

       	sh ./f-galore-paired.sh    # trim reads
       	sh ./hisat2-paired.sh    # map reads to the Genome

    shift
done
