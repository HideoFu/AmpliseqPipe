# sam is filename of sam.
# Argument loc must have columns "Chr", "start", "end" and "id". Use "L1000locGRChxx.txt".

Lcount <- function(sam,loc){

	# read 2 columns (Chromosome, and start position) from sam file.
    data <- read.delim(sam,header=F,skip=196, colClasses=c(rep("NULL",2),"character","integer",rep("NULL",18)))
    colnames(data) <- c("Chr","start")

    
    id_list <- foreach(i = 1:nrow(loc)) %dopar% row.names(data[data$Chr==loc[i,"Chr"] & data$start>=loc[i,"start"] & data$start<=loc[i,"end"],])

    for ( i in 1:nrow(loc)){
	    data[id_list[[i]], "id"] <- loc[i, "id"]
    }


    data <- data[!is.na(data$id),]
    counttable <- table(data$id)

    result <- as.data.frame(names(counttable))
    count <- as.vector(counttable)

    result$count <- count
    colnames(result) <- c("id","count")

    return(result)

}
