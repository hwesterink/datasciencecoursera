## Created an API "Reading data from GitHub HW" on https://github.com/settings/applications
## Creation date = 29-3-2016
## Install httr-package
install.packages("httr")
install.packages("httpuv")
library(httr)
library(httpuv)
## Accessing data
## Access date = 29-3-2016
oauth_endpoints("github")
myapp <- oauth_app("github", key = "3bbee6ceef4f86af2faa", 
   secret = "da48cb8c6a5278d43fb367828aa76a0f8f6088b7") 
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
## Use API to load and read the data
gtoken <- config(token = github_token) 
req <- GET("https://api.github.com/users/jtleek/repos", gtoken) 
stop_for_status(req) 
content(req) 
