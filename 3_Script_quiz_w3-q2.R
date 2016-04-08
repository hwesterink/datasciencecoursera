## Install and load the jpeg package
install.packages("jpeg")
library(jpeg)
## Downloading data
## Download date = 7-4-2016
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl, destfile="R Scripts/Data/jeff.jpg", mode="wb")
dateDownload <- date()
## Loading data into R
img_jeff <- readJPEG("R Scripts/Data/jeff.jpg", native=TRUE)
## Data analysis
quantile(img_jeff, probs=c(0.3, 0.8))