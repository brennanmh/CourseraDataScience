
complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files

  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used

  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases

  # create a vector of the filenames for the monitors based on directory
  # and the ID vector
  datafiles <<- paste0(paste(directory, sprintf("%03d", id), sep = "/"), ".csv")

  # load all the files, rbind'ing as we go and assigne to poldata
  poldata <<- do.call("rbind",
                     lapply(datafiles,
                            function(fn) data.frame(Filename=fn, read.csv(fn)))
  )

  # init out results vector to length of id with 0's
  out <- rep(1:length(id), 0)
  # for each id, calculate the number of complete cases
  for (i in id) {
    out <- c(out, sum(complete.cases(poldata[poldata$ID == i, ])))
  }
  # bind the ids in
  final <- cbind(id, out)
  # set the desired column names
  colnames(final) <- c("id", "nobs")

  return(final)

}

