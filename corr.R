corr <- function(directory, threshold = 0)  {
        ##  'directory' is a character vector of length 1 indicating
        ##  the location of the CSV files.
  
        ##  'threshold' is a numeric vector of lenght 1 indicating the
        ##  number of completely observed observations (on all
        ##  variables) required to compute the correlation between
        ##  nitrate and sulfate; the default is 0.
  
        ##  The function returns a numeric vector of correlations.
        ##  NOTE: The result is not rounded.

    corr <- vector(mode = "numeric")
 
    for(i in 1:332)  {
      num_compl_cases <- complete(directory, i)
      if(num_compl_cases[1, "nobs"] > threshold)  {
        if(i < 10)  {
          fil_name <- paste(directory, "/00", i, ".csv", sep = "")
        } else if((i >= 10) & (i < 100))  {
          fil_name <- paste(directory, "/0", i, ".csv", sep = "")
        } else  {
          fil_name <- paste(directory, "/", i, ".csv", sep = "")
        }
        
        monitor <- read.csv(fil_name)
        monitor <- monitor[!is.na(monitor[,"sulfate"]) & !is.na(monitor[,"nitrate"]),]
        corr_monitor <- cor(monitor[,"sulfate"], monitor[,"nitrate"])
        corr <- cbind(corr, corr_monitor)
        out <- paste("* Monitor", i, "verwerkt.")
        print(out)
      }
    }
    corr <- as.vector(corr)
    corr
}
