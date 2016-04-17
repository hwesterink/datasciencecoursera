## Downloading data
##
## Download date = 16-4-2016
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl1, destfile="R Scripts/Data/FGDP_Ranking.csv")
dateDownload1 <- date()
## Download date = 17-4-2016
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl2, destfile="R Scripts/Data/FEDSTATS_Country.csv")
dateDownload2 <- date()
## Loading data into R
data1 <- read.csv("R Scripts/Data/FGDP_Ranking.csv", stringsAsFactors = FALSE)
head(data1)
data2 <- read.csv("R Scripts/Data/FEDSTATS_Country.csv", stringsAsFactors = FALSE)
head(data2)
## Load libraries
library(dplyr)
## Filter data for relevant records and columns
filteredData1 <- filter(data1, X != "", Gross.domestic.product.2012 != "")
head(filteredData1)
sdata2 <- select(data2, CountryCode, Special.Notes)
##
## Data analysis
mergedData <- merge(filteredData1, sdata2, by.x="X", by.y="CountryCode", all=FALSE)
length(grep("^Fiscal year end: June",mergedData$Special.Notes))