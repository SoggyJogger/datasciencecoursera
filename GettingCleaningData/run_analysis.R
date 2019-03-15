## R script for Coursera "Course Getting and Cleaning Data" course project

# The objectives of this script are as follows:

# 1)Merges the training and the test sets to create one data set.
# 2)Extracts only the measurements on the mean and standard deviation for each measurement.
# 3)Uses descriptive activity names to name the activities in the data set
# 4)Appropriately labels the data set with descriptive variable names.
# 5) From the data set in step 4, creates a second, independent tidy data set with the average 
#    of each variable for each activity and each subject.

# The data for the project are located here:
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##############################
# To run this code, set your desired working directory below

### Set working directory
file_location <- "C:/Users/Jon/Desktop/temp/course3week4/"
setwd(file_location)


##############################
## script for part 1:
## Merges the training and the test sets to create one data set.

# download and read in the data
#install.packages("curl")
library(curl)
dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataURL, 
              destfile = paste0(file_location, "projectData.zip"),
              method = "curl")
dateDownloaded <- date()

## You will need to unzip these files to the same directory
zipFile <- paste0(file_location, "projectData.zip")
unzip(zipFile)
## files are located in a single folder, sets this as the new path prefix
file_location <- paste0(file_location, "UCI HAR Dataset/")


## read in the data
## the feature data corresponds to the statistics calculated off of the raw inertia (x/y/z-axis) data
## features.txt has the variable names (a single column with one variable name per row), dim 1x561 
## train/X_train.txt has the calculated statistics, with columns corresponding with the features and rows as observations, dim 561x2947
## train/Y_train.txt has the performed activity (1-6), with type corresponding to values in activity_labels.txt
## same for test

## train/subjects_test.txt has the participant number (a single column) corresponding with the observations, dim 1x2947
## the "train/Inertial Signals/[x/y/z]" data has the raw data informing these statistics, with 2947 rows corresponding to 128 time observations (dim 128x2947)

# load the features, make it a vector for renaming X data
features <- read.table(paste0(file_location, "features.txt"))
newNames <- as.vector(features$V2)

## read in and merge the test data
test_x <- read.table(paste0(file_location, "test/X_test.txt"))
test_y <- read.table(paste0(file_location, "test/Y_test.txt"))
test_subject <- read.table(paste0(file_location, "test/subject_test.txt"))

## rename columns and combine with the measurement data
colnames(test_subject) <- "participantID"
colnames(test_y) <- "activity_code"
colnames(test_x) <- newNames
test_combined <- cbind(test_subject, test_y, test_x)

## read in and merge the training data
train_x <- read.table(paste0(file_location, "train/X_train.txt"))
train_y <- read.table(paste0(file_location, "/train/Y_train.txt"))
train_subject <- read.table(paste0(file_location, "train/subject_train.txt"))

## rename columns and combine with the measurement data
colnames(train_subject) <- "participantID"
colnames(train_y) <- "activity_code"
colnames(train_x) <- newNames
train_combined <- cbind(train_subject, train_y, train_x)

## combine training and testing data
data_combined <- rbind(train_combined, test_combined)


##############################
## script for part 2:
## Extracts only the measurements on the mean and standard deviation for each measurement.

## reduce data to the columns that contain mean or standard deviation measurements
## NOTE: this includes only the columns for "Mean values", not the columns for "mean frequency";
##       to include the latter, remove the '\\()' portion of the the grepl call.
data_mean_std <- data_combined[grepl("mean\\()|std\\()", colnames(data_combined))]

## re-combine with participant data
data_reduced <- cbind(data_combined[,1:2], data_mean_std)


##############################
## script for part 3:
## Uses descriptive activity names to name the activities in the data set.

activity_raw <- read.table(paste0(file_location, "activity_labels.txt"))

for(counter in c(1:6)){
  temp_name <- as.character(activity_raw$V2[activity_raw$V1==counter])
  data_reduced$activity_code[data_reduced$activity_code==counter] <- temp_name
}


##############################
## script for part 4:
## Appropriately labels the data set with descriptive variable names. 

## The variable names were already labeled with descriptive column names as part of the import and merge
## (in the colnames step). These names came from the features list in the readme files.


##############################
## script for part 5:
## From the data set in step 4, creates a second, independent tidy data set with the average of 
## each variable for each activity and each subject. 

## group the data by activity/participant, and generate the mean for all variables
data_summary <- group_by_at(data_reduced, vars(activity_code, participantID)) %>% summarize_all(funs(mean))

## export data to a .csv
write.table(data_summary, paste0(paste0(file_location, "Overall_means.txt")))
