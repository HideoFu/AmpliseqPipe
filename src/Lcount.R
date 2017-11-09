# sam is filename of sam.
# Argument loc must have columns "Chr", "start", "end" and "id". Use "L1000locGRChxx.txt".

Lcount <- function(sam,loc){

	# read 2 columns (Chromosome, and start position) from sam file.
    data <- read.delim(sam,header=F,skip=196, colClasses=c(rep("NULL",2),"character","integer",rep("NULL",18)))
    colnames(data) <- c("Chr","start")

    result <- foreach(i = 1:nrow(loc), .combine = c) %dopar% length(row.names(data[data$Chr==loc[i,"Chr"] & data$start>=loc[i,"start"] &
                                                                        data$start<=loc[i,"end"],]))

    return(result)
}