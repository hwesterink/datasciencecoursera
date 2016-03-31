## Downloading data
## Download date = 29-3-2016
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, destfile="R Scripts/Data/Fwksst8110.for")
dataDownload <- date()
## Loading data into R
colwidths <- c(10, 9, 4, 9, 4, 9, 4, 9, 4)
data <- read.fwf("R Scripts/Data/Fwksst8110.for", widths=colwidths, skip=4)
head(data)
## Data analysis
sum(data[,4])
