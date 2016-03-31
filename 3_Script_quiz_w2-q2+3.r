## Downloading data
## Download date = 29-3-2016
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="R Scripts/Data/Fss06pid.csv")
dataDownload <- date()
## Install sqldf-package
install.packages("sqldf")
library(sqldf)
## Loading data into R
acs <- read.csv("R Scripts/Data/Fss06pid.csv")
head(acs)
## Use sqldf package to look at the data for question 2
result <- sqldf("select * from acs where AGEP<50")
head(result)
result <- sqldf("select * from acs")
result <- sqldf("select pwgtp1 from acs where AGEP<50")
head(result)                                               ## gives the result asked for                                             
result <- sqldf("select pwgtp1 from acs")
## Use sqldf package to look at the data for question 3
result_unique <- unique(acs$AGEP)
result_unique
result_sql <- sqldf("select distinct pwgtp1 from acs")
result_sql                                                 ## shows another result as unique()
result_sql <- sqldf("select unique * from acs")            ## gives syntax error
result_sql <- sqldf("select AGEP where unique from acs")   ## gives syntax error
result_sql <- sqldf("select distinct AGEP from acs")
result_sql                                                 ## shows the same result, but in another format