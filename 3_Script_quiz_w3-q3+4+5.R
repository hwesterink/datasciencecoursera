## Downloading data
## Download date = 7-4-2016
##
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl1, destfile="R Scripts/Data/FGDP_Ranking.csv")
download.file(fileUrl2, destfile="R Scripts/Data/EdStats_country.csv")
##
## The following files are available:
## 1.1 = FGDP_Ranking.csv:        2012 GDP-data via the link in the quiz
## 1.2 = GDP_Ranking.csv:         2014 GDP-data direct from the website
## 2.1 = EdStats_Country.csv:     EdStats-data via the link in the quiz
## 2.2 = Edstats_Country (2).csv: EdStats-data direct from the website
dateDownload <- date()
## Loading data into R
data1 <- read.csv("R Scripts/Data/FGDP_Ranking.csv", stringsAsFactors = FALSE)
## data1 <- read.csv("R Scripts/Data/GDP_Ranking.csv", stringsAsFactors = FALSE)
data2 <- read.csv("R Scripts/Data/EdStats_Country.csv", stringsAsFactors = FALSE)
## data2 <- read.csv("R Scripts/Data/EdStats_Country (2).csv", stringsAsFactors = FALSE)
head(data1)
head(data2)
## Load libraries
library(dplyr)
## Select data needed for the analysis
sdata1 <- select(data1, X, Gross.domestic.product.2012, X.2)
## sdata1 <- select(data1, X, Gross.domestic.product.2014, X.2)
sdata2 <- select(data2, CountryCode, Income.Group)
##
## Data analysis for question 3
mergedData <- merge(sdata1, sdata2, by.x="X", by.y="CountryCode", all=FALSE)
mergedData <- filter(mergedData, Gross.domestic.product.2012 != "")
mergedDataConv <- mutate(mergedData, Gross.domestic.product.2012=as.numeric(Gross.domestic.product.2012))
sortedData <- arrange(mergedDataConv, desc(Gross.domestic.product.2012))
## mergedData <- filter(mergedData, Gross.domestic.product.2014 != "")
## mergedDataConv <- mutate(mergedData, Gross.domestic.product.2014=as.numeric(Gross.domestic.product.2014))
## sortedData <- arrange(mergedDataConv, desc(Gross.domestic.product.2014))
##
## Data analysis for question 4
groupedData <- group_by(mergedData, Income.Group)
summarize(groupedData, meanRanking=mean(as.numeric(Gross.domestic.product.2012)))
## summarize(groupedData, meanRanking=mean(as.numeric(Gross.domestic.product.2014)))
##
## Data analysis for question 5
quantile(as.numeric(mergedData$Gross.domestic.product.2012), probs=seq(0, 1, (1/5)))
## This gives a quantile distribution of 1 --> 38 --> 76 --> 114 --> 152 --> 189
## quantile(as.numeric(mergedData$Gross.domestic.product.2014), probs=seq(0, 1, (1/5)))
## This gives a quantile distribution of 1 --> 38 --> 76 --> 115 --> 154 --> 193
sortedData <- arrange(mergedDataConv, Gross.domestic.product.2012)
## sortedData <- arrange(mergedDataConv, Gross.domestic.product.2014)
ExtMergedData <- mutate(sortedData, Ranking.Group=5)
ExtMergedData[1:38, 5] <- 1
ExtMergedData[39:76, 5] <- 2
ExtMergedData[77:114, 5] <- 3
ExtMergedData[115:152, 5] <- 4
## ExtMergedData[77:115, 5] <- 3
## ExtMergedData[116:154, 5] <- 4
table(ExtMergedData$Income.Group, ExtMergedData$Ranking.Group)
