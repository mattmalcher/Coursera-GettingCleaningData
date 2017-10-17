# The Data

## Data Source
  The data was downloaded from a mirror of `archive.ics.uci.edu` provided by coursera:
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Description
As per the [Original Documentation](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) This is data from experiments carried out with  30 volunteers aged 19-48 years. Each person in the experiment sperformed six activities, wearing a Samsung Galaxy S II on their waist:
* WALKING,
* WALKING_UPSTAIRS,
* WALKING_DOWNSTAIRS,
* SITTING,
* STANDING,
* LAYING

Using its accelerometer and gyroscope linear acceleration and angular velocity were sampled at a constant rate of 50Hz.
The experiments have been video-recorded to label the data manually.

The obtained dataset has been randomly partitioned into two sets:
* 70% of the volunteers generated training data.
* 30% generated test data.

## Pre Processing
The sensor signals (accelerometer and gyroscope) can be found in the folders:
* `test/Inertial Signals`
* `trial/Inertial Signals`

 This data has been pre-processed by the research team using filters and windowing functions, the result of this are the files in the root of the `test` and `trial` directories.

The exact details of this pre-processing can be found in the [Original Documentation](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

# Processing Approach
The following steps were followed to process the data.

## Build Test & Trial Data Frames
The data in `test` and `trial` directories each consist of several files (where xxxx is test or trial):

* `y_xxxx` - The activity data (walking, sitting etc)
* `subject_xxxx` - The data indicating which subject is performing the activity
* `X_xxxx` - The summarised accelerometer data as described in `features.txt`

The first step of the data processing was to read these sets of three files in for the test and trial data and column bind them together to form a complete data frame.

During this stage of the process the column names for the summarised accelerometer data were read in from `features.txt` and applied to the dataframes.

Before applying the variable names to the columns they were cleaned to remove periods, commas and parentheses.

## Merge
The data in the original dataset was split into test and trial sets for the machine learning model. For our purposes we want one merged set of data.

To achieve this the second step of the data processing was to column bind the trial and test data sets together to form one complete record.

## Extract mean and standard deviation
The original data summary files contain a large number of variables (561). For this project we have decided to extract only the summary columns containing the mean or standard deviation of the data. These have been identified as the variables where the name contains `std` or `mean`.

This was achieve using the `matches` function within dplyr which allowed the dataframe columns to be filtered using regular expressions.

At this stage the activity column - which was numeric up to this point was converted to a factor so that when it is printed it showed the relevant activity names. A factor representation rather than a charachter representation was selected to minimise file size.

## Create an independent tidy data set
The final step was to create a tidy dataset, which contained only the averages of each of the variables for each activity and participant combination.

This was achived using the group_by and summarise_all functions within dplyr: grouping by Subject, then Activity and using summarise to calculate the means for each combination.

`tidydata <- desireddata %>%
  group_by(Subject,Activity) %>%
  summarise_all(funs(m=mean))`

# Variables in Tidy Dataset
The following table shows the variables in the tidy dataset. These are the means for a variable in the original summary dataset.

The following table shows the original variable name and feature numbers next to the variable name in the tidy dataset for the equivalent mean and the column index.

This should allow you to follow a variable through from the old code book to the equivalent mean value in the tidy data.

| Feature Number |Old Variable Name | Variable Name in Tidy Dataset Containing the Equivalent Mean Quantity | Column Index in Tidy Data|
| --- | --- | --- |
| 1 | tBodyAcc-mean()-X | tBodyAccmeanX_m | 3 |
| 2 | tBodyAcc-mean()-Y | tBodyAccmeanY_m | 4 |
| 3 | tBodyAcc-mean()-Z | tBodyAccmeanZ_m | 5 |
| 4 | tBodyAcc-std()-X | tBodyAccstdX_m | 6 |
| 5 | tBodyAcc-std()-Y | tBodyAccstdY_m | 7 |
| 6 | tBodyAcc-std()-Z | tBodyAccstdZ_m | 8 |
| 41 | tGravityAcc-mean()-X | tGravityAccmeanX_m | 9 |
| 42 | tGravityAcc-mean()-Y | tGravityAccmeanY_m | 10 |
| 43 | tGravityAcc-mean()-Z | tGravityAccmeanZ_m | 11 |
| 44 | tGravityAcc-std()-X | tGravityAccstdX_m | 12 |
| 45 | tGravityAcc-std()-Y | tGravityAccstdY_m | 13 |
| 46 | tGravityAcc-std()-Z | tGravityAccstdZ_m | 14 |
| 81 | tBodyAccJerk-mean()-X | tBodyAccJerkmeanX_m | 15 |
| 82 | tBodyAccJerk-mean()-Y | tBodyAccJerkmeanY_m | 16 |
| 83 | tBodyAccJerk-mean()-Z | tBodyAccJerkmeanZ_m | 17 |
| 84 | tBodyAccJerk-std()-X | tBodyAccJerkstdX_m | 18 |
| 85 | tBodyAccJerk-std()-Y | tBodyAccJerkstdY_m | 19 |
| 86 | tBodyAccJerk-std()-Z | tBodyAccJerkstdZ_m | 20 |
| 121 | tBodyGyro-mean()-X | tBodyGyromeanX_m | 21 |
| 122 | tBodyGyro-mean()-Y | tBodyGyromeanY_m | 22 |
| 123 | tBodyGyro-mean()-Z | tBodyGyromeanZ_m | 23 |
| 124 | tBodyGyro-std()-X | tBodyGyrostdX_m | 24 |
| 125 | tBodyGyro-std()-Y | tBodyGyrostdY_m | 25 |
| 126 | tBodyGyro-std()-Z | tBodyGyrostdZ_m | 26 |
| 161 | tBodyGyroJerk-mean()-X | tBodyGyroJerkmeanX_m | 27 |
| 162 | tBodyGyroJerk-mean()-Y | tBodyGyroJerkmeanY_m | 28 |
| 163 | tBodyGyroJerk-mean()-Z | tBodyGyroJerkmeanZ_m | 29 |
| 164 | tBodyGyroJerk-std()-X | tBodyGyroJerkstdX_m | 30 |
| 165 | tBodyGyroJerk-std()-Y | tBodyGyroJerkstdY_m | 31 |
| 166 | tBodyGyroJerk-std()-Z | tBodyGyroJerkstdZ_m | 32 |
| 201 | tBodyAccMag-mean() | tBodyAccMagmean_m | 33 |
| 202 | tBodyAccMag-std() | tBodyAccMagstd_m | 34 |
| 214 | tGravityAccMag-mean() | tGravityAccMagmean_m | 35 |
| 215 | tGravityAccMag-std() | tGravityAccMagstd_m | 36 |
| 227 | tBodyAccJerkMag-mean() | tBodyAccJerkMagmean_m | 37 |
| 228 | tBodyAccJerkMag-std() | tBodyAccJerkMagstd_m | 38 |
| 240 | tBodyGyroMag-mean() | tBodyGyroMagmean_m | 39 |
| 241 | tBodyGyroMag-std() | tBodyGyroMagstd_m | 40 |
| 253 | tBodyGyroJerkMag-mean() | tBodyGyroJerkMagmean_m | 41 |
| 254 | tBodyGyroJerkMag-std() | tBodyGyroJerkMagstd_m | 42 |
| 266 | fBodyAcc-mean()-X | fBodyAccmeanX_m | 43 |
| 267 | fBodyAcc-mean()-Y | fBodyAccmeanY_m | 44 |
| 268 | fBodyAcc-mean()-Z | fBodyAccmeanZ_m | 45 |
| 269 | fBodyAcc-std()-X | fBodyAccstdX_m | 46 |
| 270 | fBodyAcc-std()-Y | fBodyAccstdY_m | 47 |
| 271 | fBodyAcc-std()-Z | fBodyAccstdZ_m | 48 |
| 294 | fBodyAcc-meanFreq()-X | fBodyAccmeanFreqX_m | 49 |
| 295 | fBodyAcc-meanFreq()-Y | fBodyAccmeanFreqY_m | 50 |
| 296 | fBodyAcc-meanFreq()-Z | fBodyAccmeanFreqZ_m | 51 |
| 345 | fBodyAccJerk-mean()-X | fBodyAccJerkmeanX_m | 52 |
| 346 | fBodyAccJerk-mean()-Y | fBodyAccJerkmeanY_m | 53 |
| 347 | fBodyAccJerk-mean()-Z | fBodyAccJerkmeanZ_m | 54 |
| 348 | fBodyAccJerk-std()-X | fBodyAccJerkstdX_m | 55 |
| 349 | fBodyAccJerk-std()-Y | fBodyAccJerkstdY_m | 56 |
| 350 | fBodyAccJerk-std()-Z | fBodyAccJerkstdZ_m | 57 |
| 373 | fBodyAccJerk-meanFreq()-X | fBodyAccJerkmeanFreqX_m | 58 |
| 374 | fBodyAccJerk-meanFreq()-Y | fBodyAccJerkmeanFreqY_m | 59 |
| 375 | fBodyAccJerk-meanFreq()-Z | fBodyAccJerkmeanFreqZ_m | 60 |
| 424 | fBodyGyro-mean()-X | fBodyGyromeanX_m | 61 |
| 425 | fBodyGyro-mean()-Y | fBodyGyromeanY_m | 62 |
| 426 | fBodyGyro-mean()-Z | fBodyGyromeanZ_m | 63 |
| 427 | fBodyGyro-std()-X | fBodyGyrostdX_m | 64 |
| 428 | fBodyGyro-std()-Y | fBodyGyrostdY_m | 65 |
| 429 | fBodyGyro-std()-Z | fBodyGyrostdZ_m | 66 |
| 452 | fBodyGyro-meanFreq()-X | fBodyGyromeanFreqX_m | 67 |
| 453 | fBodyGyro-meanFreq()-Y | fBodyGyromeanFreqY_m | 68 |
| 454 | fBodyGyro-meanFreq()-Z | fBodyGyromeanFreqZ_m | 69 |
| 503 | fBodyAccMag-mean() | fBodyAccMagmean_m | 70 |
| 504 | fBodyAccMag-std() | fBodyAccMagstd_m | 71 |
| 513 | fBodyAccMag-meanFreq() | fBodyAccMagmeanFreq_m | 72 |
| 516 | fBodyBodyAccJerkMag-mean() | fBodyBodyAccJerkMagmean_m | 73 |
| 517 | fBodyBodyAccJerkMag-std() | fBodyBodyAccJerkMagstd_m | 74 |
| 526 | fBodyBodyAccJerkMag-meanFreq() | fBodyBodyAccJerkMagmeanFreq_m | 75 |
| 529 | fBodyBodyGyroMag-mean() | fBodyBodyGyroMagmean_m | 76 |
| 530 | fBodyBodyGyroMag-std() | fBodyBodyGyroMagstd_m | 77 |
| 539 | fBodyBodyGyroMag-meanFreq() | fBodyBodyGyroMagmeanFreq_m | 78 |
| 542 | fBodyBodyGyroJerkMag-mean() | fBodyBodyGyroJerkMagmean_m | 79 |
| 543 | fBodyBodyGyroJerkMag-std() | fBodyBodyGyroJerkMagstd_m | 80 |
| 552 | fBodyBodyGyroJerkMag-meanFreq() | fBodyBodyGyroJerkMagmeanFreq_m | 81 |
| 555 | angle(tBodyAccMean,gravity) | angletBodyAccMeangravity_m | 82 |
| 556 | angle(tBodyAccJerkMean),gravityMean) | angletBodyAccJerkMeangravityMean_m | 83 |
| 557 | angle(tBodyGyroMean,gravityMean) | angletBodyGyroMeangravityMean_m | 84 |
| 558 | angle(tBodyGyroJerkMean,gravityMean) | angletBodyGyroJerkMeangravityMean_m | 85 |
| 559 | angle(X,gravityMean) | angleXgravityMean_m | 86 |
| 560 | angle(Y,gravityMean) | angleYgravityMean_m | 87 |
| 561 | angle(Z,gravityMean) | angleZgravityMean_m | 88 |
