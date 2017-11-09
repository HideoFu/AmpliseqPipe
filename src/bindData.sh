#!/bin/bash

# make samfile list file

touch samfiles
ls *.sam > samfiles

# call Lcount.R and count reads
# write-out to temp file is required because of memory exhaust

Rscript --vanilla --slave `dirname $0`/countReads.R `dirname $0`

rm samfiles
