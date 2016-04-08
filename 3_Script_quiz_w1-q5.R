## Downloading data
## Download date = 25-3-2016
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="R Scripts/Data/2006_Idoha.csv")
dateDownload <- date()
## Install data.table-package
install.packages("data.table")
library(data.table)
## Loading data into R
DT <- data.table(fread("R Scripts/Data/2006_Idoha.csv"))
head(DT)
class(DT)
## Data analysis
func <- function (repeats, choice)  {
  for(i in 1:repeats)  {
    if(choice == 1) {
      tapply(DT$pwgtp15,DT$SEX,mean)
    } else if(choice == 2) {
      rowMeans(DT)[DT$SEX==1]
      rowMeans(DT)[DT$SEX==2]
    } else if(choice == 3) {
      mean(DT$pwgtp15,by=DT$SEX)
    } else if(choice == 4) {
      mean(DT[DT$SEX==1,]$pwgtp15)
      mean(DT[DT$SEX==2,]$pwgtp15)
    } else if(choice == 5) {
      sapply(split(DT$pwgtp15,DT$SEX),mean)
    } else if(choice == 6) {
      DT[,mean(pwgtp15),by=SEX]
    }
  }
}
system.time(func(1000,1))   ## user=2.51    system=0.00    elapsed=2.52
system.time(func(1000,2))   ## Error in rowMeans(DT) : 'x' must be numeric
system.time(func(10000,3))  ## user=0.61    system=0.00    elapsed=0.61
system.time(func(20,4))     ## user=1.06    system=0.00    elapsed=1.11
system.time(func(1000,5))   ## user=1.53    system=0.00    elapsed=1.54
system.time(func(1000,6))   ## user=1.46    system=0.00    elapsed=1.47
