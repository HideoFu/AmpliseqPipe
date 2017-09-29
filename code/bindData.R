filenames <- read.delim("txtfiles", header=F, stringsAsFactors=F)

for (i in 1:dim(filenames)[1]){
	if (i == 1){
		combined_read <- read.table(filenames[i,1], header=T)
	} else {
		read_count <- read.table(filenames[i,1], header=T)
		combined_read <- cbind(combined_read, read_count$count)
	}
}


colnames(combined_read) <- c("id", filenames[,1])
combined_read[is.na(combined_read)] <- 0

write.table(combined_read, "combined_read.txt", sep="\t")
