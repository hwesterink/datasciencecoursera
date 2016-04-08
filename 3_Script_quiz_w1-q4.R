## Downloading data
## Download date = 24-3-2016
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl, destfile="R Scripts/Data/Balt_rest.xml")
dateDownload <- date()
## Install XML-package
install.packages("XML")
library(XML)
## Loading data into R
doc <- xmlTreeParse("R Scripts/Data/Balt_rest.xml", useInternal=TRUE)
rootNode <- xmlRoot(doc)
## Data analysis
xmlName(rootNode)
names(rootNode)
rootNode[1]
data <- xpathSApply(rootNode, "//zipcode", xmlValue)
count <- 0
number <- length(data)
for(i in 1:number)  {
  if(!is.na(data[i]))  {
    if(data[i] == 21231)  {
      count <- count + 1
    }  
  }
}
print(count)