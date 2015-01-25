---
title: Code Book
author: Jay D. McHugh
date: 01/16/2015
output: html_document
---
# Original Data

The original data was produced by Samsung and is described as follows. *See below for the converted data descriptions.*

## Feature Selection 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern: 
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt' in the data archive.

# Converted output

After the processing, the data has been consolidated with the descriptive activity and subject numbers. And, only the mean and standard deviations are extracted from the original data.

Once they have been extracted, they are then summarized by activity and subject with each of the measurements averaged over those ranges.

As these are averages of the averages and standard deviations which are unitless - *all of these values are also unitless*.

Although tidy data frequently strives to remove any extraneous characters from the column names, dots have been put in to make the names more easily readable. Also, the labels have been fully expanded to make it more readable to viewers without a specific background in physics/engineering.

The following are the values extracted from the original data set as well as the original measurement names:

- activity

    This is the descriptive name of the activity. It is pulled from the activity\_labels.text file by using the y\_xxxxx.txt file as a reference to determine which activity corresponds to the measurement data.
    
    There are six different activities: WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, and LAYING
  
- subject

    This is the subject number pulled from the subject\_xxxxx.txt file that corresponds to the row in the measurement data.
    
    The study is comprised of thirty anonymous subjects so there is only the subject number (from 1 through 30)
    
- time.body.acceleration.mean.x

    This is the average of the original measurement tBodyAcc.mean().X from the source data for each activity/subject combination. The original value is the average acceleration on the x axis.
    
- time.body.acceleration.mean.y

    This is the average of the original measurement tBodyAcc.mean().Y from the source data for each activity/subject combination. The original value is the average acceleration on the y axis.
    
- time.body.acceleration.mean.z

    This is the average of the original measurement tBodyAcc.mean().Z from the source data for each activity/subject combination. The original value is the average acceleration on the Z axis.
    
- time.body.acceleration.standard.deviation.x

    This is the average of the original measurement tBodyAcc.std().x from the source data for each activity/subject combination. The original value is the standard deviation of the acceleration along the x axis.
    
- time.body.acceleration.standard.deviation.y

    This is the average of the original measurement tBodyAcc.std().y from the source data for each activity/subject combination. The original value is the standard deviation of the acceleration along the y axis.
    
- time.body.acceleration.standard.deviation.z

    This is the average of the original measurement tBodyAcc.std().z from the source data for each activity/subject combination. The original value is the standard deviation of the acceleration along the z axis.
    
- time.gravity.acceleration.mean.x

    This is the average of the original measurement tGravAcc.mean().x from the source data for each activity/subject combination.

- time.gravity.acceleration.mean.y 

    This is the average of the original measurement tGravAcc.mean().y from the source data for each activity/subject combination.

- time.gravity.acceleration.mean.z 

    This is the average of the original measurement tGravAcc.mean().Z from the source data for each activity/subject combination.

- time.gravity.acceleration.standard.deviation.x 

    This is the average of the original measurement tGravAcc.std().X from the source data for each activity/subject combination.

- time.gravity.acceleration.standard.deviation.y 

    This is the average of the original measurement tGravAcc.std().Y from the source data for each activity/subject combination.

- time.gravity.acceleration.standard.deviation.z 


    This is the average of the original measurement tGravAcc.std().Z from the source data for each activity/subject combination.

- time.body.acceleration.jerk.mean.x 

    This is the average of the original measurement tBodyAccJerk.mean().X from the source data for each activity/subject combination.

- time.body.acceleration.jerk.mean.y 

    This is the average of the original measurement tBodyAccJerk.mean().Y from the source data for each activity/subject combination.

- time.body.acceleration.jerk.mean.z 

    This is the average of the original measurement tBodyAccJerk.mean().Z from the source data for each activity/subject combination.

- time.body.acceleration.jerk.standard.deviation.x 

    This is the average of the original measurement tBodyAccJerk.std().X from the source data for each activity/subject combination.

- time.body.acceleration.jerk.standard.deviation.y

    This is the average of the original measurement tBodyAccJerk.std().Y from the source data for each activity/subject combination.
    
- time.body.acceleration.jerk.standard.deviation.z 

    This is the average of the original measurement tBodyAccJerk.std().Z from the source data for each activity/subject combination.
    
- time.body.gyro.mean.x

    This is the average of the original measurement tBodyGyro.mean().X from the source data for each activity/subject combination.
    
- time.body.gyro.mean.y 

    This is the average of the original measurement tBodyGyro.mean().Y from the source data for each activity/subject combination.
    
- time.body.gyro.mean.z 

    This is the average of the original measurement tBodyGyro.mean().Z from the source data for each activity/subject combination.
    
- time.body.gyro.standard.deviation.x 

    This is the average of the original measurement tBodyGyro.std().X from the source data for each activity/subject combination.
    
- time.body.gyro.standard.deviation.y 

    This is the average of the original measurement tBodyGyro.std().Y from the source data for each activity/subject combination.
    
- time.body.gyro.standard.deviation.z 

    This is the average of the original measurement tBodyGyro.std().Z from the source data for each activity/subject combination.
    
- time.body.gyro.jerk.mean.x 

    This is the average of the original measurement tBodyGyroJerk.mean().X from the source data for each activity/subject combination.
    
- time.body.gyro.jerk.mean.y 

    This is the average of the original measurement tBodyGyroJerk.mean().Y from the source data for each activity/subject combination.
    
- time.body.gyro.jerk.mean.z 

    This is the average of the original measurement tBodyGyroJerk.mean().Z from the source data for each activity/subject combination.

- time.body.gyro.jerk.standard.deviation.x 

    This is the average of the original measurement tBodyGyroJerk.std().X from the source data for each activity/subject combination.

- time.body.gyro.jerk.standard.deviation.y 

    This is the average of the original measurement tBodyGyroJerk.std().Y from the source data for each activity/subject combination.

- time.body.gyro.jerk.standard.deviation.z 

    This is the average of the original measurement tBodyGyroJerk.std().Z from the source data for each activity/subject combination.

- time.gravity.acceleration.magnitude.mean 

    This is the average of the original measurement tGravAccMag.mean() from the source data for each activity/subject combination.

- time.gravity.acceleration.magnitude.standard.deviation 

    This is the average of the original measurement tGravAccMag.std() from the source data for each activity/subject combination.

- time.body.acceleration.jerk.magnitude.mean 

    This is the average of the original measurement tBodyAccJerkMag.mean() from the source data for each activity/subject combination.

- time.body.acceleration.jerk.magnitude.standard.deviation 

    This is the average of the original measurement tBodyAccJerkMag.std() from the source data for each activity/subject combination.

- time.body.gyro.magnitude.mean 

    This is the average of the original tBodyGyroMag.mean() from the original source data for each activity/subject combination.

- time.body.gyro.magnitude.standard.deviation 

    This is the average of the original tBodyGyroMag.std() from the original source data for each activity/subject combination.

- time.body.gyro.jerk.magnitude.mean 

    This is the average of the original tBodyGyroJerkMag.mean() from the original source data for each activity/subject combination.

- time.body.gyro.jerk.magnitude.standard.deviation 

    This is the average of the original tBodyGyroJerkMag.std() from the original source data for each activity/subject combination.

- frequency.body.acceleration.mean.x 

    This is the average of the original fBodyAcc.mean().X from the original source data for each activity/subject combination.

- frequency.body.acceleration.mean.y 

    This is the average of the original fBodyAcc.mean().Y from the original source data for each activity/subject combination.

- frequency.body.acceleration.mean.z 

    This is the average of the original fBodyAcc.mean().Z from the original source data for each activity/subject combination.

- frequency.body.acceleration.standard.deviation.x 

    This is the average of the original fBodyAcc.std().X from the original source data for each activity/subject combination.

- frequency.body.acceleration.standard.deviation.y 

    This is the average of the original fBodyAcc.std().Y from the original source data for each activity/subject combination.

- frequency.body.acceleration.standard.deviation.z 

    This is the average of the original fBodyAcc.std().Z from the original source data for each activity/subject combination.

- frequency.body.acceleration.jerk.mean.x 

    This is the average of the original fBodyAccJerk.mean().X from the original source data for each activity/subject combination.

- frequency.body.acceleration.jerk.mean.y 

    This is the average of the original fBodyAccJerk.mean().Y from the original source data for each activity/subject combination.

- frequency.body.acceleration.jerk.mean.z 

    This is the average of the original fBodyAccJerk.mean().Z from the original source data for each activity/subject combination.

- frequency.body.acceleration.jerk.standard.deviation.x 

    This is the average of the original fBodyAccJerk.std().X from the original source data for each activity/subject combination.

- frequency.body.acceleration.jerk.standard.deviation.y 

    This is the average of the original fBodyAccJerk.std().Y from the original source data for each activity/subject combination.

- frequency.body.acceleration.jerk.standard.deviation.z 

    This is the average of the original fBodyAccJerk.std().Z from the original source data for each activity/subject combination.

- frequency.body.gyro.mean.x 

    This is the average of the original fBodyGyro.mean().X from the original source data for each activity/subject combination.

- frequency.body.gyro.mean.y 

    This is the average of the original fBodyGyro.mean().Y from the original source data for each activity/subject combination.

- frequency.body.gyro.mean.z 

    This is the average of the original fBodyGyro.mean().Z from the original source data for each activity/subject combination.

- frequency.body.gyro.standard.deviation.x 

    This is the average of the original fBodyGyro.std().X from the original source data for each activity/subject combination.

- frequency.body.gyro.standard.deviation.y 

    This is the average of the original fBodyGyro.std().Y from the original source data for each activity/subject combination.

- frequency.body.gyro.standard.deviation.z 
- frequency.body.acceleration.magnitude.mean 
- frequency.body.acceleration.magnitude.standard.deviation 
- frequency.body.acceleration.jerk.magnitude.mean 

    This is the average of the original fBodyBodyAccJerkMag.mean() from the original source data for each activity/subject combination. The original data column had a type including the word 'Body' twice.

- frequency.body.acceleration.jerk.magnitude.standard.deviation
- frequency.body.gyro.magnitude.mean 
- frequency.body.gyro.magnitude.standard.deviation 
- frequency.body.gyro.jerk.magnitude.mean 

    This is the average of the original calculation fBodyGyroJerkMag.mean() from the source data for each activity/subject combination.
    
- frequency.body.gyro.jerk.magnitude.standard.deviation 

    This is the average of the original measurement fBodyGyroJerkMag.std() for the source data for each activity/subject combination.
