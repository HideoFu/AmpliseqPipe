#!/bin/sh

# -x <hisat2-idx> is in  $HISAT2_INDEXES folder
# input file is ***_1_val_1.fq and ***_2_val_2.fq
# output file: *.sam

core=$EXPcore  #number of threads. exported from 'main.sh' and so on

cd Trimmed

hisat2 -p $core -q --dta -x genome -1 ${EXP1}_1_val_1.fq -2 ${EXP1}_2_val_2.fq -S ${EXP1}.sam

mv ${EXP1}.sam ..
cd ..
