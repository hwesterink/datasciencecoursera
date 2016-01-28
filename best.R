##  The function "best" finds the best hospital in a state for a specific
##  outcome.
##  The function takes the variables state and outcome.
##    - state     Two letter abbriviation of the state in capitals
##    - outcome   One of the following: "heart attack", "heart failure" or
##                "pneumonia"
##  The output of the function is the name of the hospital with the lowest
##  death rate for the selected outcome.

best <- function(state, outcome)  {
    
  ##  Validate state input
    correct_state <- FALSE
    i <- 1
    num_states <- length(state.abb)
    repeat  {
        correct_state <- (state == state.abb[i])
        i <- i + 1
        if(correct_state | (i > num_states)) {
            break
        }
    }
    if(!correct_state)  {
        stop("invalid state")
    }
    
    ##  Validate outcome input
    if((outcome != "heart attack") & (outcome != "heart failure") & (outcome != "pneumonia"))  {
        stop("invalid outcome")
    }
    
    ##  Read data from outcome file
    outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ##  Select data needed to find the best hospital
    outcome_selection <- data.frame()
    num_rows <- nrow(outcome_data)
    for(i in 1:num_rows)  {
        if(state == outcome_data[i, "State"])  {
          outcome_selection <- rbind(outcome_selection, outcome_data[i, ])
        }
    }

    ##  Find the best hospital with the lowest mortality rate
    num_rows <- nrow(outcome_selection)
    if(outcome == "heart attack") { num_rate <- 11}
    else if(outcome == "heart failure")  { num_rate <- 17}
    else { num_rate <- 23}
    outcome_selection[, num_rate] <- as.numeric(outcome_selection[, num_rate])
    lowest_rate <- 1000000
    for(i in 1:num_rows)  {
        if(!is.na(outcome_selection[i, num_rate]))  {
            if(lowest_rate > outcome_selection[i, num_rate])  {
                lowest_rate <- outcome_selection[i, num_rate]
                hospitals <- outcome_selection[i, 2]
            } else if(lowest_rate == outcome_selection[i, num_rate])  {
                hospitals <- c(hospitals, outcome_selection[i, 2])
            }
        }
    }
    
    ##  Select the hospital that comes first in the alphabet if there is
    ##  more then 1 hospital selected
    numb_hospitals <- length(hospitals)
    if(numb_hospitals > 1)  {
        best_hospital <- hospitals[1]
        for(i in 2:numb_hospitals)  {
            if(best_hospital > hospitals[i])  {
                best_hospital <- hospitals[i]
            }
        }
    } else {
        best_hospital <- hospitals
    }
    best_hospital
}