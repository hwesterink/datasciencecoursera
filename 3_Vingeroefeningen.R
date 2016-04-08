##
##           WEEK 1
##           ======
##

## 7. Downloading Files
if(!file.exists("./R Scripts/Test"))  {
    dir.create("./R Scripts/Test")
}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./R Scripts/Test/cameras.csv")
list.files("./R Scripts/Test")
dateDownloaded <- date()

## 9. Reading Excel Files
install.packages("xlsx")
library(xlsx)
read.xlsx
colIndex <- 7:15
rowIndex <- 18:23
dat = read.xlsx("./R Scripts/Data/NGPA_data.xlsx", sheetIndex=1, colIndex=colIndex, rowIndex=rowIndex)

## 10. Reading XML
install.packages("XML")
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[1]
rootNode[[1]]
xmlSApply(rootNode,xmlValue)

## 11. Reading JSON
install.packages("jsonlite")
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login
jsonData$created_at[8]                    ## Creation date of the repo datasharing
myJSON <- toJSON(iris, pretty=TRUE)
cat(myJSON)
iris2 <- fromJSON(myJSON)

## 12. The data.table Package
install.packages("data.table")
library(data.table)
DF <- data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
DT <- data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
tables()
DT[,list(mean(x),sum(z))]
DT[,w:=z^2]
DT[,m:={tmp<-(x+z);log2(tmp+5)}]
DT[,a:=x>0]
DT[,b:=mean(x+w),by=a]
setkey(DT,x)
DT1 <- data.table(x=c("a","a","b","dt1"),y=1:4)
DT2 <- data.table(x=c("a","b","dt2"),y=5:7)
DT3 <- copy(DT1)
setkey(DT1,x);setkey(DT2,x)
merge(DT1,DT2)
big_df <- data.frame(x=rnorm(1E6),y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t",quote=FALSE)
system.time(fread(file))
system.time(read.table(file, header=TRUE, sep="\t"))

##
##           WEEK 2
##           ======
##

## 1. Reading from MySQL
install.packages("RMySQL")
library(RMySQL)
ucscDb <- dbConnect(MySQL(), user = "genome", host = "genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;")
dbDisconnect(ucscDb)
hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19", host = "genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
affyFields <- dbListFields(hg19, "affyU133Plus2")
queryResult1 <- dbGetQuery(hg19, "select count(*) from affyU133Plus2")
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)
affyMisSmall <- fetch(query, n=10)
dbClearResult(query)
dim(affyMisSmall)
dbDisconnect(hg19)

## 2.Reading from HDF5
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
if(!file.exists("./R Scripts/Test"))  {
  dir.create("./R Scripts/Test")
}
h5createFile("./R Scripts/Test/example.h5")
h5createGroup("./R Scripts/Test/example.h5", "foo")
h5createGroup("./R Scripts/Test/example.h5", "baa")
h5createGroup("./R Scripts/Test/example.h5", "foo/foobaa")
h5ls("./R Scripts/Test/example.h5")
A <- matrix(1:10,nr=5,nc=2)
h5write(A, "./R Scripts/Test/example.h5", "foo/A")
B <- array(seq(0.1,2.0,by=0.1), dim=c(5,2,2))
h5write(B, "./R Scripts/Test/example.h5", "foo/foobaa/B")
df <- data.frame(1L:5L, seq(0,1,length.out=5), c("ab","cde","fghi","a","s"), stringsAsFactors = FALSE)
h5write(df, "./R Scripts/Test/example.h5", "df")
readA <- h5read("./R Scripts/Test/example.h5", "foo/A")
h5write(c(12,13,14), "./R Scripts/Test/example.h5", "foo/A", index=list(1:3,1))

## 3. Reading from the web
con <- url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode <- readLines(con)
close(con)
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)             ## Geeft list()
library(httr)
html2 <- GET(url)
content2 <- content(html2, as="text")
parsedHtml <- htmlParse(content2, asText=TRUE)

##
##           WEEK 3
##           ======
##

## 1. Subsetting en sorting
set.seed(13435)
X <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
X <- X[sample(1:5),]
X$var2[c(1,3)] = NA
X[1:2,"var2"]
X[(X$var1<=3&X$var3>11),]
X[(X$var1<=3|X$var3>11),]
X[(X$var2>8),]
X[which(X$var2>8),]
sort(X$var1)
sort(X$var1, decreasing = TRUE)
sort(X$var2, na.last = TRUE)
X[order(X$var1),]
X[order(X$var1,X$var3),]
install.packages("plyr")
library(plyr)
arrange(X,var1)
arrange(X,desc(var1))
X$var4 <- rnorm(5)
Y <- cbind(X,rnorm(5))

## 2. Summarizing data
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./R Scripts/Data/restaurants.csv")
restData <- read.csv("./R Scripts/Data/restaurants.csv")
head(restData)
tail(restData)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm=TRUE)
quantile(restData$councilDistrict, probs=c(0.5,0.75,0.9))
table(restData$zipCode, useNA="ifany")
table(restData$councilDistrict, restData$zipCode)
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode>0)
colSums(is.na(restData))
all(colSums(is.na(restData))==0)
table(restData$zipCode==c("21212"))
table(restData$zipCode %in% c("21212", "21213"))
restData[restData$zipCode %in% c("21212", "21213"),]
data(UCBAdmissions)
DF <- as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq~Gender+Admit, data=DF)
warpbreaks$replicate <- rep(1:9, len=54)
xt <- xtabs(breaks~., data=warpbreaks)
ftable(xt)
fakeData <- rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units="Mb")

## 3. Creating new variables
s1 <- seq(1,10,by=2)
S2 <- seq(1,10,length=3)
x <- c(1,3,8,25,100)
seq(along=x)
restData$nearMe <- restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)
restData$zipWrong <- ifelse(restData$zipCode<0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode<0)
restData$zipGroups <- cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)
install.packages("Hmisc")
library(Hmisc)
restData$zipGroups <- cut2(restData$zipCode, g=4)
table(restData$zipGroups)
restData$zcf <- factor(restData$zipCode)
yesno <- sample(c("yes", "no"), size=10, replace=TRUE)
yesnofac <- factor(yesno, levels=c("yes", "no"))
relevel(yesnofac, ref="yes")
as.numeric(yesnofac)
library(plyr)
restData2 <- mutate(restData, zipGroups=cut2(zipCode, g=4))
table(restData2$zipGroups)

## 4. Reshaping data
library(reshape2)
head(mtcars)
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c("carname", "gear", "cyl"), measure.vars=c("mpg", "hp"))
cylData <- dcast(carMelt, cyl~variable)
cylData <- dcast(carMelt, cyl~variable, mean)
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)
spIns <- split(InsectSprays$count, InsectSprays$spray)
spCount <- lapply(spIns, sum)
unlist(spCount)
sapply(spIns, sum)
ddply(InsectSprays, .(spray), summarize, sum=ave(count, FUN=sum))

## 6. Managing Data Frames with dplyr - Basic Tools
install.packages("dplyr")
library(dplyr)
options(width=105)
fileUrl <- "https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/dplyr/chicago.rds?raw=true"
download.file(fileUrl, destfile="./R Scripts/Test/chicago.rds", extra="-L", mode="wb")
chicago <- readRDS("./R Scripts/Test/chicago.rds")
dim(chicago)
str(chicago)
names(chicago)
head(select(chicago, city:dptp))
head(select(chicago, -(city:dptp)))
chic.f <- filter(chicago, pm25tmean2>30)
chic.f <- filter(chicago, pm25tmean2>30 & tmpd>80)
chicago <- arrange(chicago, date)
chicago <- arrange(chicago, desc(date))
chicago <- rename(chicago, pm25=pm25tmean2, dewpoint=dptp)
chicago <- mutate(chicago, pm25detrend=pm25-mean(pm25, na.rm=TRUE))
head(select(chicago, pm25, pm25detrend))
chicago <- mutate(chicago, tempcat=factor(1*(tmpd>80),labels=c("cold","hot")))
hotcold <- group_by(chicago, tempcat)
summarize(hotcold, pm25=mean(pm25), o3=max(o3tmean2), no2=median(no2tmean2))
summarize(hotcold, pm25=mean(pm25, na.rm=TRUE), o3=max(o3tmean2), no2=median(no2tmean2))
chicago <- mutate(chicago, year=as.POSIXlt(date)$year+1900)
years <- group_by(chicago, year)
summarize(years, pm25=mean(pm25, na.rm=TRUE), o3=max(o3tmean2), no2=median(no2tmean2))
chicago %>% mutate(month=as.POSIXlt(date)$mon+1) %>% group_by(month) %>%
  summarize(pm25=mean(pm25, na.rm=TRUE), o3=max(o3tmean2), no2=median(no2tmean2))

## 7. Merging data
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile="./R Scripts/Test/reviews.csv")
download.file(fileUrl2, destfile="./R Scripts/Test/solutions.csv")
reviews <- read.csv("./R Scripts/Test/reviews.csv")
solutions <- read.csv("./R Scripts/Test/solutions.csv")
mergedData <- merge(reviews, solutions, by.x="solution_id", by.y="id", all=TRUE)
intersect(names(solutions), names(reviews))
mergedData2 <- merge(reviews, solutions, all=TRUE)
df1 <- data.frame(id=sample(1:10), x=rnorm(10))
df2 <- data.frame(id=sample(1:10), y=rnorm(10))
arrange(join(df1,df2),id)
df3 <- data.frame(id=sample(1:10), Z=rnorm(10))
dfList <- list(df1,df2,df3)
join_all(dfList)

##
##           WEEK 4
##           ======
##
