# The data

The tidy data set was been created by transforming the raw data set, which description paste below. The result data set represents an average of the mean and standard deviation for each measurement for each activity and each subject of row data set.

It includes variable mean information about experiments with a group of 30 volunteers and set activity. 

Row data set was provided by:

1. Smartlab, DIBRIS - UniversitÃ  degli Studi di Genova, Genoa (16145), Italy.
2. CETpD - Universitat PolitÃ¨cnica de Catalunya. Vilanova i la GeltrÃº (08800), Spain

Data set containing information about the experiments which have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

See more information about row data set [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

You can fing row data set [original here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) or [here](https://github.com/ditiatev/JHU_DataScience/tree/master/GettingCleaningData/CourseProject/data/UCI%20HAR%20Dataset).

___
# The variables


Data contain 4 collumns: "subject","activity","variable","mean_value".

**subject** - one of 30 volunteers.

**activity** - one of the record activities, such as:

- WALKING;
- WALKING_UPSTAIRS;
- WALKING_DOWNSTAIRS;
- SITTING;
- STANDING;
- LAYING.

**variable** - represent the average of the mean and standard deviation for each measurement for each activity and each subject. As means and standard deviation have bene considers the measurement of row data set which includes in the name exactly "mean()" - Mean value and "std()" Standard deviation patterns. 

Here all list of names colomns from row data set:

 [1] "subject"                     "ind_activities"              "tbodyacc-mean()-x"          
 [4] "tbodyacc-mean()-y"           "tbodyacc-mean()-z"           "tbodyacc-std()-x"           
 [7] "tbodyacc-std()-y"            "tbodyacc-std()-z"            "tgravityacc-mean()-x"       
[10] "tgravityacc-mean()-y"        "tgravityacc-mean()-z"        "tgravityacc-std()-x"        
[13] "tgravityacc-std()-y"         "tgravityacc-std()-z"         "tbodyaccjerk-mean()-x"      
[16] "tbodyaccjerk-mean()-y"       "tbodyaccjerk-mean()-z"       "tbodyaccjerk-std()-x"       
[19] "tbodyaccjerk-std()-y"        "tbodyaccjerk-std()-z"        "tbodygyro-mean()-x"         
[22] "tbodygyro-mean()-y"          "tbodygyro-mean()-z"          "tbodygyro-std()-x"          
[25] "tbodygyro-std()-y"           "tbodygyro-std()-z"           "tbodygyrojerk-mean()-x"     
[28] "tbodygyrojerk-mean()-y"      "tbodygyrojerk-mean()-z"      "tbodygyrojerk-std()-x"      
[31] "tbodygyrojerk-std()-y"       "tbodygyrojerk-std()-z"       "tbodyaccmag-mean()"         
[34] "tbodyaccmag-std()"           "tgravityaccmag-mean()"       "tgravityaccmag-std()"       
[37] "tbodyaccjerkmag-mean()"      "tbodyaccjerkmag-std()"       "tbodygyromag-mean()"        
[40] "tbodygyromag-std()"          "tbodygyrojerkmag-mean()"     "tbodygyrojerkmag-std()"     
[43] "fbodyacc-mean()-x"           "fbodyacc-mean()-y"           "fbodyacc-mean()-z"          
[46] "fbodyacc-std()-x"            "fbodyacc-std()-y"            "fbodyacc-std()-z"           
[49] "fbodyaccjerk-mean()-x"       "fbodyaccjerk-mean()-y"       "fbodyaccjerk-mean()-z"      
[52] "fbodyaccjerk-std()-x"        "fbodyaccjerk-std()-y"        "fbodyaccjerk-std()-z"       
[55] "fbodygyro-mean()-x"          "fbodygyro-mean()-y"          "fbodygyro-mean()-z"         
[58] "fbodygyro-std()-x"           "fbodygyro-std()-y"           "fbodygyro-std()-z"          
[61] "fbodyaccmag-mean()"          "fbodyaccmag-std()"           "fbodybodyaccjerkmag-mean()"
[64] "fbodybodyaccjerkmag-std()"   "fbodybodygyromag-mean()"     "fbodybodygyromag-std()"     
[67] "fbodybodygyrojerkmag-mean()" "fbodybodygyrojerkmag-std()"

**mean_value** - value result for each mean mesurements.

___
# Transformations

Row data sets represent a few separate *.txt files:

- test and training groups of data sets.

Each of these data contains separate information about volunteers, activity, and set with all features.
Labels and sets represent separately.


### General steps of data transformations.

#### Combine data sets into df_all.

- Read data sets "X_train.txt", "subject_train.txt", "y_train.txt".
- Read "features.txt" to get the column's name for "X_train.txt" and follow "X_test.txt"
- Rename "X_train.txt", "subject_train.txt", "y_train.txt"
- Create common colomn "rn" with row names.
- Mearge "X_train.txt", "subject_train.txt", "y_train.txt" by "rn".

The same steps for data sets "X_test.txt", "subject_test.txt", "y_test.txt".

Merge result of train and test data sets into **"df_all"**.

#### Create subset "df_all_ms" from general "df_all".

- create vector "colMeanStd" of columns name of "df_all" using regular expressions "mean\\()|std\\()". 
- create sub set data frame df_all_ms by using vector of interesting columns names.

#### Create final set "df_all_means" from "df_all_ms"

- reshape data "df_all_ms" into data set with 4 coloms: "subject","activity","variable","mean_value".
- grouping variables "subject","activity","variable" to colculate mean of "mean_value".
- save data set as "smartphone_human_act_means.txt".

More detailed information about transforming data you can find in comments in ["run_ananlysis.R" file on GitHub](https://github.com/ditiatev/JHU_DataScience/blob/master/GettingCleaningData/CourseProject/script/run_analysis.R).