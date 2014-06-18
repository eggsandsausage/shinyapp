library(reshape2)
library(xlsx)
zefiles <- list.files()

for (zefile in zefiles) {
  makezecsv(zefile)
  
} 

makezecsv <- function(x) {
  y <- read.xlsx(x, 1, check.names=F)
  x <- sub(".{5}$","", x)
  colnames(y)[1]<- "country"
  y <-melt(y, id.vars="country")
  colnames(y)[2]<- "year"
  y[is.na(y$value),"value"] <- 0
  y$value <- round(y$value,2)
  y$type <- x
  y$year <- type.convert(as.character(y$year))
  y <- y[y$year>1950,]
  write.table(y, paste("../fixed-csvs/",x, ".csv"), sep = ",", row.names=F)
  
}