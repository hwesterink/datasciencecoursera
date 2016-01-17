complete <- function(directory, id = 1:332)  {
        ##  'directory' is a character vector of length 1 indicating
        ##  the location of the CSV files.
  
        ##  'id' is an integer vector indicating the monitor ID numbers
        ##  to be used.
  
        ##  This function returns a data frame of the form:
        ##  id nobs
        ##  1  117
        ##  2  1041
        ##  ...
        ##  where 'id' is the monitor ID number and 'nobs' is the
        ##  number of complete cases.

    
  
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
        num_complete <- 0
        if(num_samples == 0)  {
           warning_txt = paste("*** Monitor number", id[i],"delivered an empty file.")
           print(warning_txt)
           next
        }
        for(j in 1:num_samples)  {
          if(!is.na(monitor[j, "sulfate"]) & (!is.na(monitor[j, "nitrate"])))  {
             num_complete <- num_complete + 1
          }
        }
        if(i == 1)  {
          complete <- data.frame(id = id[i], nobs = num_complete)
        } else  {
          new_complete <- data.frame(id = id[i], nobs = num_complete)
          complete <- rbind(complete, new_complete)
        }
      }  
    }
    complete
}
