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
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window).

The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity.

The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

# The Variables


# Processing Approach
  Details of the transformations and work performed to clean up the data

## Merge

## Extract mean and standard deviation

## Create an independent tidy data set
