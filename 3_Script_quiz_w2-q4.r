## Load packages needed
library(httr)
library(XML)
library(stringi)
## Read html webpage into R
## Date webpage read = 30-3-2016
url <- "http://biostat.jhsph.edu/~jleek/contact.html"
html <- GET(url)
html_content <- content(html, as="text")
print(html_content)
write(html_content, file="R Scripts/Data/DataQ4.txt")
htmlList <- stri_read_lines("R Scripts/Data/DataQ4.txt")
print(htmlList)
## Data analysis
print(paste("Lenght line 10:  ", nchar(htmlList[10])))
print(paste("Lenght line 20:  ", nchar(htmlList[20])))
print(paste("Lenght line 30:  ", nchar(htmlList[30])))
print(paste("Lenght line 100: ", nchar(htmlList[100])))
