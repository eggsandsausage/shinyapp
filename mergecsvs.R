zefiles <- list.files()
dataset <- data.frame()

for (zefile in zefiles) {
  dataset <- rbind(dataset, read.csv(zefile, check.names =F))
  
} 

