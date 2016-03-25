## Downloading data
## Download date = 24-3-2016
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile="R Scripts/Data/NGPA_data.xlsx")
dataDownload <- date()
## Install xlsx-package
## Loading the library asks to install Java
install.packages("xlsx")
library(xlsx)
## Loading data into R
colIndex <- 7:15
rowIndex <- 18:23
dat = read.xlsx("R Scripts/Data/NGPA_data.xlsx", sheetindex=1, header=TRUE, colIndex=colIndex, rowIndex=rowIndex)
head(dat)
## Data analysis
print(sum(dat$Zip*dat$Ext,na.rm=T))