filenames <- read.delim("samfiles", header=F, stringsAsFactors=F)

source("./code/Lcount.R")
library(dplyr)
library(pforeach)

# read reference file
loc <- read.delim("./lib/L1000locGRCh37.txt")


for ( i in 1:dim(filenames)[1]){
	# count reads for each gene in loc file
  read_count <- Lcount(sam=filenames[i,1], loc=loc)
  if (i ==1 ){
    combined_read <- read_count
  } else {
    combined_read <- full_join(combined_read, read_count, by="id")
  }
}

colnames(combined_read) <- c("id", filenames[,1])
combined_read[is.na(combined_read)] <- 0

write.table(combined_read, "combined_read.txt", sep="\t")
