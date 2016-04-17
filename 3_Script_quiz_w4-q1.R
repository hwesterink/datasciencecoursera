## Downloading data
## Download date = 23-3-2016
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="R Scripts/Data/2006survey.csv")
dateDownload <- date()
## Loading data into R
data <- read.csv("R Scripts/Data/2006survey.csv")
head(data)
## Data analysis
count <- 0
rows <- nrow(data)
for(i in 1:rows)  {
   if(!is.na(data[i, "VAL"]))  {
       if(data[i, "VAL"] == 24)  {
           count <- count + 1
       }  
   }
}
print(count)