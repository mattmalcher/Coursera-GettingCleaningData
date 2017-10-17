# Getting & Cleaning Data Coursera Week 4 Project
# M. Malcher 17/10/17

#{r Load Libraries}
library(dplyr)
library(tidyr)

# Set working directory
setwd("~/Dropbox/MOOC/Coursera/Data Science Beginner/3. Getting & Cleaning Data/Project/Coursera-GettingCleaningData")

# Get Data
# The following steps are for reliably re-aquiring the source data if I do something silly.
# They are commented out to avoid re-downloading & unzipping each time script is run

# # Clear out the dataset if it exists
# system('rm -R \'UCI\ HAR\ Dataset/\'', wait=TRUE)
# 
# # Download the data from coursera link
# url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
# download.file(url,'UCI HAR Dataset.zip')
# 
# # Unzip it
# system('unzip \'UCI HAR Dataset.zip\'',wait=TRUE)


# Merge the training and the test sets to create one data set.
# Note that the raw data (contained in the 'Inertial Signals' subdirectories) does not need to be merged as we are not re-performing this stage of the analysis - i.e the pre-processing.
# Instead, only the following files need to be merged:
#   * 'subject_*.txt' 
# * 'X_*.txt' 
# * 'y_*.txt' 

# Read in the feature names from the file
X_names=read.table('UCI HAR Dataset/features.txt', header = FALSE,
                   sep = " ", col.names=c('feature_id','feature_name'))

# Use a regular expression to get rid of any .'s or -'s or ,'s or ()'s 
# Note - a double escape needed to use \, as \ itself is a special charachter)
# Note - ? used to prevent greedy matching
X_names$feature_name_clean <- gsub("(\\.|-|,|\\(|\\))?", "", X_names$feature_name)

# Read activity names to a new table
activity_names=read.table('UCI HAR Dataset/activity_labels.txt', header = FALSE,
                          sep = " ", col.names=c('activity_id','activity_name'))

# Read in the test data
sub_test <- read.table( 'UCI HAR Dataset/test/subject_test.txt', header = FALSE, 
                        sep = " ", col.names=c('Subject'))

# Note the column names are assiged as the feature names at this point
X_test <- read.table('UCI HAR Dataset/test/X_test.txt', header = FALSE, 
                     sep = "", col.names=X_names$feature_name_clean)

# Read the Activity information to a table
y_test <- read.table('UCI HAR Dataset/test/y_test.txt', header = FALSE,
                     sep = " ", col.names=c('Activity'))


# Read in the training data
sub_train <- read.table( 'UCI HAR Dataset/train/subject_train.txt', header = FALSE, 
                         sep = " ", col.names=c('Subject'))

# Note the column names are assiged as the feature names at this point
X_train <- read.table('UCI HAR Dataset/train/X_train.txt', header = FALSE, 
                      sep = "", col.names=X_names$feature_name_clean)

# Read the Activity information to a table                     
y_train <- read.table('UCI HAR Dataset/train/y_train.txt', header = FALSE,
                      sep = " ", col.names=c('Activity'))


# Column bind the subject, activity and data for the test data
testdata <- cbind(sub_test,y_test,X_test)
dim(testdata) # Check dimensions
rm(sub_test,y_test,X_test) # Tidy workspace

# Column bind the subject, activity and data for the training data
traindata <- cbind(sub_train,y_train,X_train)
dim(traindata) # Check dimensions
rm(sub_train,y_train,X_train) # Tidy workspace

# Row bind the test & training data together
alldata <- rbind(testdata,traindata)
dim(alldata) # Check dimensions
rm(testdata,traindata)  # Tidy workspace

# Extract
# Extract only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.

# Select only data where the column heading contains std, mean, Subject or Activity
# This brings us down to 88 variables

desireddata <- select(alldata, matches('std|mean|Subject|Activity'))

# Change the Activity variable to a factor, applying the labels in 'activity_name' read in from activity_labels.txt - This allows it to be descriptive without taking up unnecesary space.
desireddata$Activity <- factor(desireddata$Activity,
                               labels=activity_names$activity_name)

# Tidy
# From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.

# Group the data by subject, then activity, and then summarise all of the variable columns 
# using the mean for each of the resulting 180 rows.
tidydata <- desireddata %>% 
  group_by(Subject,Activity) %>% 
  summarise_all(funs(m=mean))

# Check the dimensions are as expected (88 vars selected by 30 subjects x 6 activities)
dim(tidydata)

# Write tidied data out to a file
write.table(tidydata, file='TidyData.txt', append=FALSE, row.names = FALSE)
#

