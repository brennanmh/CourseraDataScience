

best <- function(state, outcome) {

  ## read outcome data
  outcomes <- read.csv("outcome-of-care-measures.csv",
                       header=TRUE,
                       colClasses="character")
  goutcomes <<- outcomes

  ## check that state and outcome are valid
  valid_states <- unique(outcomes$State)
  if (!(state %in% valid_states)) {
    stop("invalid state")
  }

  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  if (!(outcome %in% valid_outcomes)) {
    stop("invalid outcome")
  }

  outcomes_in_state <- outcomes[outcomes$State == state,]

  ## for each type

  ## strip "Not Available"
  clean_ois <- ois[ois[,11]!="Not Available",11]

  outcomes_in_state

}
