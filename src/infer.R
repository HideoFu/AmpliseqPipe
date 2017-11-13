# Read params
col_ids <- read.delim("/mnt/nas/public/L1000exporlate/ols_col_ids.txt", stringsAsFactors = F)
conv_tbl <- read.csv("/mnt/nas/public/L1000exporlate/ols_entrez.csv", stringsAsFactors = F)


# Read and clean data
data <- read.delim("combined_read.txt", stringsAsFactors = F)

m <- match(col_ids$gene_id, data$id)
data <- data[m,]

rownames(data) <- data$id
data$id <- NULL


# Define function
l1000exp <- function(count, conv_dt){
  #count is a vector converted from count table column
  count <- c(1, count)
  count_dt <- as.data.table(t(count))
  exp_dt <- conv_dt[, .SD * count_dt, by=gene_id]
  result <- exp_dt[, apply(.SD, 1, sum), by=gene_id]
  
  result[result$V1<0, "V1"] <- 0
  result <- result[, 2, with=FALSE]
  
  return(result)
}


# Extraporlation
library(doParallel)
library(foreach)
library(data.table)

conv_dt <- data.table(conv_tbl)

cl <- makeCluster(detectCores())
registerDoParallel(cl)

exp_tbl <- foreach(i=1:ncol(data), .combine=cbind, .packages="data.table") %dopar% {
  l1000exp(data[,i], conv_dt)
}

stopCluster(cl)

exp_tbl <- cbind(conv_dt$gene_id, exp_tbl)
colnames(exp_tbl) <- c("id", colnames(data))
fwrite(exp_tbl, "exp_tbl.csv")

# Check duplication
l1000_id <- rownames(data)
l1000_id <- as.integer(l1000_id)

exp_id <- as.data.frame(exp_tbl$id)
exp_id <- exp_id[,1]

dup_id <- intersect(l1000_id, exp_id)

m1 <- match(dup_id, rownames(data))
m2 <- match(dup_id, exp_tbl$id)


# save objects
saveRDS(data, "data.obj")
saveRDS(exp_tbl, "exp_tbl.obj")
saveRDS(m1, "m1.obj")
saveRDS(m2, "m2.obj")


# rbind data and infered 
exp_tbl_nodup <- exp_tbl[-m2,]

data <- cbind(id=l1000_id, data)

combined_data <- rbind(data, exp_tbl_nodup)

fwrite(combined_data, "extraporlated_data.csv")
