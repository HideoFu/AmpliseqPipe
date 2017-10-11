wd <- commandArgs(trailingOnly=TRUE)[1]
filenames <- read.delim("samfiles", header=F, stringsAsFactors=F)

source(paste(wd, "Lcount.R", sep="/"))
library(dplyr)
library(foreach)
library(doParallel)

# read reference file
pwd <- getwd()
setwd(wd)
setwd("..")
loc <- read.delim("./lib/L1000locGRCh37.txt")
etwd(pwd)

cl <- makeCluster(detectCores())
registerDoParallel(cl)

for ( i in 1:dim(filenames)[1]){
	# count reads for each gene in loc file
  read_count <- Lcount(sam=filenames[i,1], loc=loc)
  write.table(read_count, file = paste(strsplit(filenames[i,1], "\\.")[[1]][1],
				       "txt", sep="."), row.names=F)
}

stopCluster(cl)
