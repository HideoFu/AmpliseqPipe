#!/bin/bash

# make samfile list file

touch samfiles
ls *.sam >> samfiles

# call Lcount.R and bind read-count

Rscript --vanilla --slave bindData.R

rm samfiles
