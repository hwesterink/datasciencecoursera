##  The function "rankall" finds the hospitals in each state with the given
##  ranking for a specific outcome.
##  The function takes the variables outcome, and num.
##    - outcome   One of the following: "heart attack", "heart failure" or
##                "pneumonia"
##    - num       Ranking of the hospital in the state, can also be "best"
##                or "worst"
##  The output of the function is a data frame the name of the hospital and the
##  abbriviation of the state with the given ranking in an increasing death rate
##  ranking for the selected outcome in each row.

rankall <- function(outcome, num = "best")  {
    
    ##  Validate outcome input
    if((outcome != "heart attack") & (outcome != "heart failure") & (outcome != "pneumonia"))  {
        stop("invalid outcome")
    }
    
    ##  Validate num input
    if(is.numeric(num))  {
        if(num < 1)  {
            stop("num < 1 - invalid num")
        }
    } else {
        if(num == "best") {
            num <- 1
        } else {
            if(num != "worst")  {
                stop("invalid num")
            }
        }
    }
    
    ##  Read data from Outcome file
    outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ##  Find the hospitals with the given ranking in the states and build up the output
    num_states <- length(state.abb)
    for(i in 1:num_states)  {
        hospital <- ranked_hospital(outcome_data, state.abb[i], outcome, num)
        if(i == 1) {
            hospitals <- data.frame(hospital = hospital, state = state.abb[i])
            out <- paste ("==> Hospital in state", i, "selected")
            print(out)
        } else {
            new_line <- data.frame(hospital = hospital, state = state.abb[i])
            out <- paste ("==> Hospital in state", i, "selected")
            print(out)
            hospitals <- rbind.data.frame(hospitals, new_line)
        }
    }
    hospitals
}  

    
##  The function "ranked_hospital" finds the hospital with the given ranking
##  in a state for a specific outcome.
##  The function takes the variables x, state, outcome, and num.
##    - x         The 
##    - state     Two letter abbriviation of the state in capitals
##    - outcome   One of the following: "heart attack", "heart failure" or
##                "pneumonia"
##    - num       Ranking of the hospital in the state
##  The output of the function is the name of the hospital with given
##  ranking in an increasing death rate ranking for the selected outcome.


ranked_hospital <- function(x, state, outcome, num)  {
    
    ##  Select data needed to find the rated hospital
    num_rows <- nrow(x)
    count <- 0
    if(outcome == "heart attack") { num_rate <- 11
    } else if(outcome == "heart failure")  { num_rate <- 17
    } else { num_rate <- 23 }
    for(i in 1:num_rows)  {
        if(state == x[i, 7] & x[i, num_rate] != "Not Available")  {
            if(count == 0)  {
                count <- 1
                outcome_selection <- c(x[i, 2], x[i, 7], x[i, 11], x[i, 17], x[i, 23])
            } else {
                count <- count + 1
                outcome_selection <- rbind(outcome_selection, c(x[i, 2], x[i, 7], x[i, 11], x[i, 17], x[i, 23]))
            }
        }
    }
    
    ##  Convert the strings in the column needed to the right length
    if(outcome == "heart attack") { num_rate <- 3
    } else if(outcome == "heart failure")  { num_rate <- 4
    } else { num_rate <- 5 }
    for( i in 1:count)  {
        if(as.numeric(outcome_selection[i,num_rate]) < 10)  {
            outcome_selection[i,num_rate] <- paste("0", outcome_selection[i,num_rate], sep = "")
        }
    }   

    ##  Rank the hospitals in increasing death rate for outcome
    ##  and hospital name
    ranking <- order(outcome_selection[, num_rate], outcome_selection[, 1])

    ##  Return the hospital name with the given ranking
    if(num == "worst")  {
      num <- count
    }
    if(num > count)  {
        ranked_hospital <- NA
    } else {
        ranked_hospital <- outcome_selection[ranking[num], 1]
    }
    ranked_hospital
}