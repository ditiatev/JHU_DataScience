# Settings, library
setwd("./GettingCleaningData/CourseProject/")
library(plyr)
library(reshape2)
library(dplyr)

###################################################################################################
###### 1. Merges the training and the test sets to create one data set. ###########################
###################################################################################################

# TRAIN data set =======================================================================+=======

## X_train -------------------------------------------------------------------------------------

### read X_train
df_x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", 
                       stringsAsFactor = FALSE)
### read columns names, make vector, convert to lover case, rename columns
colnames <- tolower(
    unlist(
        read.table("./data/UCI HAR Dataset/features.txt",
                   colClasses = c("NULL","character"))))
names(df_x_train) <- colnames
### add index column
df_x_train$rn <- row.names(df_x_train)


## Subject_train -------------------------------------------------------------------------------

### read subject_train, rename column & add index column
df_subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",
                               stringsAsFactor = FALSE)
names(df_subject_train) <- "subject"
df_subject_train$rn <- row.names(df_subject_train)


## Y_train -------------------------------------------------------------------------------------

### read y_train, rename column & add index column
df_y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt",
                               stringsAsFactor = FALSE)
names(df_y_train) <- "ind_activities"
df_y_train$rn <- row.names(df_y_train)


## Mearge Train data sets by index col ---------------------------------------------------------
df_train <- join_all(list(
    df_x_train,
    df_y_train,
    df_subject_train),
    by = "rn")

### remove "rn" column
df_train <- df_train[,-grep("rn", names(df_train), fixed = T)]
### delete primary data
rm(df_subject_train);rm(df_x_train);rm(df_y_train)

# TEST data set ========================================================================+=======

## X_test --------------------------------------------------------------------------------------

### read X_train, rename columns & add index column
df_x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", 
                         stringsAsFactor = FALSE)
names(df_x_test) <- colnames
df_x_test$rn <- row.names(df_x_test)


## Subject_test --------------------------------------------------------------------------------

### read subject_train, rename column & add index column
df_subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",
                               stringsAsFactor = FALSE)
names(df_subject_test) <- "subject"
df_subject_test$rn <- row.names(df_subject_test)


## Y_test --------------------------------------------------------------------------------------

### read y_train, rename column & add index column
df_y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", 
                      stringsAsFactor = FALSE)
names(df_y_test) <- "ind_activities"
df_y_test$rn <- row.names(df_y_test)


## Mearge Test data sets by index col ---------------------------------------------------------
df_test <- join_all(
    list(
        df_x_test,
        df_y_test,
        df_subject_test),
    by = "rn")

### remove "rn" column
df_test <- df_test[,-grep("rn", names(df_test), fixed = T)]
### delete primary data
rm(df_subject_test);rm(df_y_test);rm(df_x_test);rm(colnames)


# Mearge df_train & df_test ============================================================+=======
df_all <- rbind(df_train,df_test)
### delete primary data
rm(df_test); rm(df_train)

####################################################################################################
#### 2. Extracts only the measurements on the mean and standard deviation for each measurement. ####
####################################################################################################

# choose columns which include combination mean() or std(), make subset
colMeanStd <- c("subject","ind_activities",grep("mean\\()|std\\()", names(df_all), value = T))
df_all_ms <- df_all[,colMeanStd]

####################################################################################################
#### 3. Uses descriptive activity names to name the activities in the data set #####################
####################################################################################################

### read activity_labels
df_actlabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt",
                           stringsAsFactor = FALSE)
### rename columns
names(df_actlabels) <- c("ind_activities","activity")

### mearge df_all_ms & df_actlabels
df_all_ms <- merge(df_all_ms,df_actlabels,by = "ind_activities",all.x = T)
### remove "ind_activities"
df_all_ms <- df_all_ms[,-grep("ind_activities", names(df_all_ms), fixed = T)]
### delete primary data
rm(df_actlabels)

#####################################################################################################
#### 4. Appropriately labels the data set with descriptive variable names. ##########################
#####################################################################################################

# We already got a result on the step N1

# Save result data set into csv file
if (!file.exists("output")) dir.create("output")
write.csv(df_all_ms,"./output/smartphone_human_act.csv")

#####################################################################################################
#### 5. From the data set in step 4, creates a second, independent tidy data set ####################
####    with the average of each variable for each activity and each subject. #######################
#####################################################################################################

# reshape data
id_vars      <- c("subject","activity")
measure_vars <- names(df_all_ms)[-grep("subject|activity", names(df_all_ms))]

df_all_means <- melt(data = df_all_ms, id.vars = id_vars, measure_vars)

# calculate mean for each combination
df_all_means <- df_all_means %>%
    group_by(subject,activity,variable) %>%
    summarise(mean_value = mean(value))

# Save result data set into csv file
write.table(df_all_means,"./data/smartphone_human_act_means.txt", row.names = F)

## delete primary data
rm(id_vars); rm(measure_vars)

