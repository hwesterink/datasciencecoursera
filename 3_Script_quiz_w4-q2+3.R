## Downloading data
## Download date = 16-4-2016
##
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile="R Scripts/Data/FGDP_Ranking.csv")
dateDownload <- date()
## Loading data into R
data <- read.csv("R Scripts/Data/FGDP_Ranking.csv", stringsAsFactors = FALSE)
head(data)
## Load libraries
library(dplyr)
##
## Data analysis for question 2
filteredData <- filter(data, X != "", Gross.domestic.product.2012 != "")
removed <- gsub(",", "", filteredData$X.3)
mean(as.numeric(removed))
##
## Data analysis for question 3
grep("^United",filteredData$X.2)