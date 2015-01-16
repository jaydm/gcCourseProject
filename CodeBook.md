---
title: Code Book
author: Jay D. McHugh
date: 01/09/2015
output: html_document
---
# Original Data

The original data was produced by Samsung and is described as follows.

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

As these are averages of the averages and standard deviations which are unitless - all of these values are also unitless.

The following are the values extracted from the original data set as well as the original measurement names:

- activity
- subject
- time.body.acceleration.mean.x
- time.body.acceleration.mean.y
- time.body.acceleration.mean.z 
- time.body.acceleration.standard.deviation.x 
- time.body.acceleration.standard.deviation.y 
- time.body.acceleration.standard.deviation.z 
- time.gravity.acceleration.mean.x 
- time.gravity.acceleration.mean.y 
- time.gravity.acceleration.mean.z 
- time.gravity.acceleration.standard.deviation.x 
- time.gravity.acceleration.standard.deviation.y 
- time.gravity.acceleration.standard.deviation.z 
- time.body.acceleration.jerk.mean.x 
- time.body.acceleration.jerk.mean.y 
- time.body.acceleration.jerk.mean.z 
- time.body.acceleration.jerk.standard.deviation.x 
- time.body.acceleration.jerk.standard.deviation.y 
- time.body.acceleration.jerk.standard.deviation.z 
- time.body.gyro.mean.x 
- time.body.gyro.mean.y 
- time.body.gyro.mean.z 
- time.body.gyro.standard.deviation.x 
- time.body.gyro.standard.deviation.y 
- time.body.gyro.standard.deviation.z 
- time.body.gyro.jerk.mean.x 
- time.body.gyro.jerk.mean.y 
- time.body.gyro.jerk.mean.z 
- time.body.gyro.jerk.standard.deviation.x 
- time.body.gyro.jerk.standard.deviation.y 
- time.body.gyro.jerk.standard.deviation.z 
- time.gravity.acceleration.magnitude.mean 
- time.gravity.acceleration.magnitude.standard.deviation 
- time.body.acceleration.jerk.magnitude.mean 
- time.body.acceleration.jerk.magnitude.standard.deviation 
- time.body.gyro.magnitude.mean 
- time.body.gyro.magnitude.standard.deviation 
- time.body.gyro.jerk.magnitude.mean 
- time.body.gyro.jerk.magnitude.standard.deviation 
- frequency.body.acceleration.mean.x 
- frequency.body.acceleration.mean.y 
- frequency.body.acceleration.mean.z 
- frequency.body.acceleration.standard.deviation.x 
- frequency.body.acceleration.standard.deviation.y 
- frequency.body.acceleration.standard.deviation.z 
- frequency.body.acceleration.jerk.mean.x 
- frequency.body.acceleration.jerk.mean.y 
- frequency.body.acceleration.jerk.mean.z 
- frequency.body.acceleration.jerk.standard.deviation.x 
- frequency.body.acceleration.jerk.standard.deviation.y 
- frequency.body.acceleration.jerk.standard.deviation.z 
- frequency.body.gyro.mean.x 
- frequency.body.gyro.mean.y 
- frequency.body.gyro.mean.z 
- frequency.body.gyro.standard.deviation.x 
- frequency.body.gyro.standard.deviation.y 
- frequency.body.gyro.standard.deviation.z 
- frequency.body.acceleration.magnitude.mean 
- frequency.body.acceleration.magnitude.standard.deviation 
- frequency.body.acceleration.jerk.magnitude.mean 
- frequency.body.acceleration.jerk.magnitude.standard.deviation
- frequency.body.gyro.magnitude.mean 
- frequency.body.gyro.magnitude.standard.deviation 
- frequency.body.gyro.jerk.magnitude.mean 
- frequency.body.gyro.jerk.magnitude.standard.deviation 