#!/bin/bash

# make samfile list file

touch samfiles
ls *.sam >> samfiles

# call Lcount.R and bind read-count

Rscript --vanilla --slave `dirname $0`/bindData.RÅ@`dirname $0`

rm samfiles
