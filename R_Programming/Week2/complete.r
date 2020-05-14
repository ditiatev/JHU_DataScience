complete <- function(directory, id = 1:332) {
  setwd("C:/R/0_courses/JHU_DataScience/R_Programming/Week2/")
  
  # get single file
  get_df <- function(i) {
    full_name <- paste0(directory,"/",formatC(i, width=3, flag="0"),".csv")
    df <- read.csv(file = full_name)
    df
  }
  
  # united files
  df_compl <- data.frame(id   = integer(),
                         nobs = integer())
  for (i in id) {
    df_compl[i,"id"] <- i
    df <- get_df(i)
    df_compl[i, "nobs"] <- length(df[complete.cases(df),"sulfate"])
  }
  
  df_compl
}