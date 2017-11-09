#!/bin/bash

exec > logfile 2>&1

# ファイル名の整形と gz の解凍
rename 's/_001//' *.gz
rename 's/L001_R//' *.gz

touch filenames.txt
ls *.gz >> filenames.txt

parallel -a filenames.txt gunzip

rm filenames.txt

# 引数の作成 
touch samples.txt
ls *_1.fastq >> samples.txt
sed -e 's/_1.fastq//' samples.txt > samples2.txt
rm samples.txt

# SAM ファイルへの変換
sh `dirname $0`/fastqToSam.sh `cat samples2.txt`
rm samples2.txt

# sam ファイルからリード数への変換、および統合
sh `dirname $0`/bindData.sh

# 外挿
Rscript --vanilla --slave `dirname $0`/extraporlation.R
