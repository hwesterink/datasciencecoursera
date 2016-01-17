pollutantmean <- function(directory, pollutant, id = 1:332)  {
        ##  'directory' is a character vector of length 1 indicating
        ##  the location of the CSV files.
  
        ##  'pollutant' is a character vector of length 1 indicating
        ##  the name of the pollutant for which we will calculate the
        ##  mean; either "sulfate" or "nitrate".
  
        ##  'id' is an integer vector indicating the monitor ID numbers
        ##  to be used.
  
        ##  This function returns the mean of the pollutant across all
        ##  monitors in the 'id' vector (ignoring NA values).
        ##  NOTE: the result is not rounded.
  
  tot_pollutant <- 0
  tot_samples <- 0
  
  if((pollutant != "sulfate") & (pollutant != "nitrate")) {
    print("==> Error in pollutantmean: You can only use sulfate or nitrate as pollutant.")
  } else  {
    num_mon <- length(id)
 
    for(i in 1:num_mon)  {

      if((id[i] < 1) | (id[i] > 332))  {
        warning_txt = paste("*** Monitor number", id[i],"outside range 1-332: Monitor ignored.")
        print(warning_txt)
      } else  {  
        if(id[i] < 10)  {
           fil_name <- paste(directory, "/00", id[i], ".csv", sep = "")
        } else if((id[i] >= 10) & (id[i] < 100))  {
           fil_name <- paste(directory, "/0", id[i], ".csv", sep = "")
        } else  {
           fil_name <- paste(directory, "/", id[i], ".csv", sep = "")
        }

        monitor <- read.csv(fil_name)
        num_samples <- nrow(monitor)
        if(num_samples == 0)  {
          warning_txt = paste("*** Monitor number", id[i],"delivered an empty file.") 
          print(warning_txt)
           next
        }
        for(j in 1:num_samples)  {
          if(!is.na(monitor[j, pollutant]))  {
             tot_pollutant <- tot_pollutant + monitor[j, pollutant]
             tot_samples <- tot_samples + 1
          }
        }
      }  
    }
    pollutantmean <- tot_pollutant / tot_samples
    pollutantmean
  }
}
