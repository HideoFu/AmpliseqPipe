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
loc <- read.delim("./lib/L1000locGRCh38.txt")
setwd(pwd)


cl <- makeCluster(detectCores())
registerDoParallel(cl)

combined_read <- foreach(i=1:dim(filenames)[1], .combine = cbind, .packages = c("foreach", "doParallel")) %dopar%
  Lcount(sam=filenames[i,1], loc=loc)

stopCluster(cl)    # in ad hoc test, DO NOT forget


combined_read <- as.data.frame(combined_read)
combined_read <- cbind(loc$id, combined_read)
colnames(combined_read) <- c("id", filenames[,1])

write.table(combined_read, "combined_read.txt", sep="\t", row.names=F)