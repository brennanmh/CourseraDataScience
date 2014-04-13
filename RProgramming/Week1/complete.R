
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
  datafiles <- paste0(paste(directory, sprintf("%03d", id), sep = "/"), ".csv")

  # load all the files, rbind'ing as we go and assigne to poldata
  poldata <- do.call("rbind", lapply(datafiles,
                                      function(fn) data.frame(Filename=fn, read.csv(fn)))
  )

  # get only the complete cases
  cc <- poldata[complete.cases(poldata), ]

  # aggregate on ID
  agg <- aggregate(ID ~ factor(cc$ID, levels = id), data=cc, FUN = length)
  colnames(agg) <- c("id", "nobs")

  return(agg)

}

