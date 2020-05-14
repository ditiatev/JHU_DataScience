pollutantmean <- function(directory, pollutant = "sulfate", id = 1:332) {
  setwd("C:/R/0_courses/JHU_DataScience/R_Programming/Week2/")
  
  # get single file
  get_df <- function(i) {
    full_name <- paste0(directory,"/",formatC(i, width=3, flag="0"),".csv")
    df <- read.csv(file = full_name)
    df
  }
  
  # united files
  fi <- T
  for (i in id) {
    if (fi == T) {
      df <- get_df(i)
      fi <- F} else {
        df <- rbind(df,get_df(i))
      }
  }
  
  # get mean
  poll_mean = mean(df[[pollutant]], na.rm = T)
  
  poll_mean
}