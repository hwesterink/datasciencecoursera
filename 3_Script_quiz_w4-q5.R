## Getting data
##
## Date = 17-4-2016
install.packages("quantmod")
library(quantmod)
amzn <- getSymbols("AMZN", auto.assign=FALSE)
sampleTimes = index(amzn)
##
## Data analysis
convYearsDays <- format(sampleTimes, "%Y %a")
length(grep("^2012", convYearsDays))
length(grep("^2012 ma", convYearsDays))