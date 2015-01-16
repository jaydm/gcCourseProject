library(plyr)
library(dplyr)
library(data.table)
library(LaF)

process <- function(data_dir = "/home/jaydm/courseWork/gettingAndCleaningData/UCI HAR Dataset", output_dir = ".") {
  ## store the original directory
  original_directory <- getwd()
  
  setwd(data_dir)
  
  ## the test and train directory variable should not require any modification
  test_dir <- "test/"
  train_dir <- "train/"
  
  ## it is necessary to load in the feature names in order to use them for column headings
  feature.file <- "features.txt"
  features <- read.table(feature.file, sep = " ", col.names = c("feature_id", "feature_name"), colClasses=c("numeric","character"))
  
  ## remove the variable once it is no longer needed
  rm("feature.file")
  
  ## but, there are a number of invalid characters in the feature names
  ## create a 'pretty' version of the feature names that will be valid as
  ## column headings
  pretty_features <- mutate(features, feature_name = gsub(",","-",gsub("\\)","",gsub("\\(","",features$feature_name))))
  
  ## load in the activity lables for cross referencing in the ouput data
  activity.file <- "activity_labels.txt"
  activities <- read.table(activity.file, sep = " ", col.names = c("activity_id", "activity_name"))
  
  ## remove the variable once it is no longer needed
  rm("activity.file")
  
  activities <- data.table(activities)
  
  ## begin the actual processing of the data
  
  ## begin processing of the training data
  setwd(train_dir)
  
  ## load the test subjects
  train.subject.file <- "subject_train.txt"
  train.subject <- read.table(train.subject.file, col.names = c("subject_id"))
  
  train.subject <- data.table(train.subject)
  
  ## add an id that correspond to the row so that the relationship
  ## will not be lost during merges
  train.subject$id <- seq_len(nrow(train.subject))
  
  ## create a key on the training subject table for the row id
  setkey(train.subject, id)
  
  ## load the activities that correspond to the test data
  train.activity.file <- "y_train.txt"
  train.activity <- read.table(train.activity.file, col.names = c("activity_id"))
  
  train.activity <- data.table(train.activity)
  
  ## add an id that correspond to the row so that the relationship
  ## will not be lost during merges
  train.activity$id <- seq_len(nrow(train.activity))
  
  ## create a key on the training activity table for the row id
  setkey(train.activity, id)
  
  ## load the actual training data using the LaF package
  ## for faster loading of large tables of fixed
  ## width data
  train.data.file <- "X_train.txt"
  laf <- laf_open_fwf(train.data.file, column_widths = rep(16,561),column_types=rep("numeric",561),column_names=pretty_features$feature_name)
  
  train.data <- data.table(laf[,])
  
  ## select only the columns that are standard deviations and means
  train.selected <- train.data %>% select(features[grepl("mean\\(", features$feature_name) | grepl("std\\(", features$feature_name),]$feature_id)
  
  ## create a key on the training data for the row id
  train.selected$id <- seq_len(nrow(train.selected))
  
  ## create a key on the training data table for the row id
  setkey(train.selected, id)
  
  ## combine the reduced column training data with the
  ## training subjects and activities
  ## (using the created id column in each)
  training <- join_all(list(train.selected, train.subject, train.activity))
  
  ## remove variables and tables no longer needed
  rm("train.subject.file")
  rm("train.subject")
  rm("train.activity.file")
  rm("train.activity")
  rm("train.data.file")
  rm("train.data")
  rm("train.selected")
  
  setwd("..")
  
  ## Begin processing of the test data
  
  setwd(test_dir)
  
  ## load the testing subjects
  test.subject.file <- "subject_test.txt"
  test.subject <- read.table(test.subject.file, col.names = c("subject_id"))
  
  test.subject <- data.table(test.subject)
  
  ## add a row id column to protect against row re-ordering
  test.subject$id <- seq_len(nrow(test.subject))
  
  ## add a key based on the row id for later joining
  setkey(test.subject, id)
  
  ## load the test activities
  test.activity.file <- "y_test.txt"
  test.activity <- read.table(test.activity.file, col.names = c("activity_id"))
  
  test.activity <- data.table(test.activity)
  
  ## add a row id column to protect against row re-ordering
  test.activity$id <- seq_len(nrow(test.activity))
  
  ## add a key base on the row id for later joining
  setkey(test.activity, id)
  
  ## load the actual test data using the LaF package
  ## for faster loading of large tables of fixed
  ## width data
  test.data.file <- "X_test.txt"
  laf <- laf_open_fwf(test.data.file, column_widths = rep(16,561),column_types=rep("numeric",561),column_names=pretty_features$feature_name)
  
  test.data <- data.table(laf[,])
  
  ## select only the columns that are standard deviations and means
  test.selected <- test.data %>% select(features[grepl("mean\\(", features$feature_name) | grepl("std\\(", features$feature_name),]$feature_id)
  
  ## add a row id column to protect against re-ordering
  test.selected$id <- seq_len(nrow(test.selected))
  
  ## set a key to the row id for joining
  setkey(test.selected, id)
  
  ## join together the selected test data columns
  ## to the test subject and test activity tables
  testing <- join_all(list(test.selected, test.subject, test.activity))
  
  ## remove unneeded variables/tables
  rm("test.subject.file")
  rm("test.subject")
  rm("test.activity.file")
  rm("test.activity")
  rm("test.data.file")
  rm("test.data")
  rm("test.selected")
  
  ## combine the training and testing data tables
  ## into a single table
  full.data <- data.table(rbind(training, testing))
  
  ## remove the partials
  rm("training")
  rm("testing")
  
  setwd("..")
  
  ## set a key on the activity id for merging with the
  ## activity descriptions
  setkey(full.data, activity_id)
  
  ## merge in the activity descriptions
  full.data <- merge(full.data, activities)
  
  ## replace the current row ids with the new
  ## current row positions (not actually necessary)
  full.data$id <- seq_len(nrow(full.data))
  
  ## set the key on the full data set
  ## to be the row position variable
  setkey(full.data, id)
  
  ## select data changing column names along the way
  ## and store the result in 'tidy'
  tidy <- full.data %>%
    select(activity = activity_name,
           subject = subject_id,
           time.body.acceleration.mean.x = tBodyAcc.mean.X,
           time.body.acceleration.mean.y = tBodyAcc.mean.Y,
           time.body.acceleration.mean.z = tBodyAcc.mean.Z,
           time.body.acceleration.standard.deviation.x = tBodyAcc.std.X,
           time.body.acceleration.standard.deviation.y = tBodyAcc.std.Y,
           time.body.acceleration.standard.deviation.z = tBodyAcc.std.Z,
           time.gravity.acceleration.mean.x = tGravityAcc.mean.X,
           time.gravity.acceleration.mean.y = tGravityAcc.mean.Y,
           time.gravity.acceleration.mean.z = tGravityAcc.mean.Z,
           time.gravity.acceleration.standard.deviation.x = tGravityAcc.std.X,
           time.gravity.acceleration.standard.deviation.y = tGravityAcc.std.Y,
           time.gravity.acceleration.standard.deviation.z = tGravityAcc.std.Z,
           time.body.acceleration.jerk.mean.x = tBodyAccJerk.mean.X,
           time.body.acceleration.jerk.mean.y = tBodyAccJerk.mean.Y,
           time.body.acceleration.jerk.mean.z = tBodyAccJerk.mean.Z,
           time.body.acceleration.jerk.standard.deviation.x = tBodyAccJerk.std.X,
           time.body.acceleration.jerk.standard.deviation.y = tBodyAccJerk.std.Y,
           time.body.acceleration.jerk.standard.deviation.z = tBodyAccJerk.std.Z,
           time.body.gyro.mean.x = tBodyGyro.mean.X,
           time.body.gyro.mean.y = tBodyGyro.mean.Y,
           time.body.gyro.mean.z = tBodyGyro.mean.Z,
           time.body.gyro.standard.deviation.x = tBodyGyro.std.X,
           time.body.gyro.standard.deviation.y = tBodyGyro.std.Y,
           time.body.gyro.standard.deviation.z = tBodyGyro.std.Z,
           time.body.gyro.jerk.mean.x = tBodyGyroJerk.mean.X,
           time.body.gyro.jerk.mean.y = tBodyGyroJerk.mean.Y,
           time.body.gyro.jerk.mean.z = tBodyGyroJerk.mean.Z,
           time.body.gyro.jerk.standard.deviation.x = tBodyGyroJerk.std.X,
           time.body.gyro.jerk.standard.deviation.y = tBodyGyroJerk.std.Y,
           time.body.gyro.jerk.standard.deviation.z = tBodyGyroJerk.std.Z,
           time.body.acceleration.magnitude.mean = tBodyAccMag.mean,
           time.body.acceleration.magnitude.standard.deviation = tBodyAccMag.std,
           time.gravity.acceleration.magnitude.mean = tBodyAccMag.mean,
           time.gravity.acceleration.magnitude.standard.deviation = tBodyAccMag.std,
           time.body.acceleration.jerk.magnitude.mean = tBodyAccJerkMag.mean,
           time.body.acceleration.jerk.magnitude.standard.deviation = tBodyAccJerkMag.std,
           time.body.gyro.magnitude.mean = tBodyGyroMag.mean,
           time.body.gyro.magnitude.standard.deviation = tBodyGyroMag.std,
           time.body.gyro.jerk.magnitude.mean = tBodyGyroJerkMag.mean,
           time.body.gyro.jerk.magnitude.standard.deviation = tBodyGyroJerkMag.std,
           frequency.body.acceleration.mean.x = fBodyAcc.mean.X,
           frequency.body.acceleration.mean.y = fBodyAcc.mean.Y,
           frequency.body.acceleration.mean.z = fBodyAcc.mean.Z,
           frequency.body.acceleration.standard.deviation.x = fBodyAcc.std.X,
           frequency.body.acceleration.standard.deviation.y = fBodyAcc.std.Y,
           frequency.body.acceleration.standard.deviation.z = fBodyAcc.std.Z,
           frequency.body.acceleration.jerk.mean.x = fBodyAccJerk.mean.X,
           frequency.body.acceleration.jerk.mean.y = fBodyAccJerk.mean.Y,
           frequency.body.acceleration.jerk.mean.z = fBodyAccJerk.mean.Z,
           frequency.body.acceleration.jerk.standard.deviation.x = fBodyAccJerk.std.X,
           frequency.body.acceleration.jerk.standard.deviation.y = fBodyAccJerk.std.Y,
           frequency.body.acceleration.jerk.standard.deviation.z = fBodyAccJerk.std.Z,
           frequency.body.gyro.mean.x = fBodyGyro.mean.X,
           frequency.body.gyro.mean.y = fBodyGyro.mean.Y,
           frequency.body.gyro.mean.z = fBodyGyro.mean.Z,
           frequency.body.gyro.standard.deviation.x = fBodyGyro.std.X,
           frequency.body.gyro.standard.deviation.y = fBodyGyro.std.Y,
           frequency.body.gyro.standard.deviation.z = fBodyGyro.std.Z,
           frequency.body.acceleration.magnitude.mean = fBodyAccMag.mean,
           frequency.body.acceleration.magnitude.standard.deviation = fBodyAccMag.std,
           frequency.body.acceleration.jerk.magnitude.mean = fBodyBodyAccJerkMag.mean,
           frequency.body.acceleration.jerk.magnitude.standard.deviation = fBodyBodyAccJerkMag.std,
           frequency.body.gyro.magnitude.mean = fBodyBodyGyroMag.mean,
           frequency.body.gyro.magnitude.standard.deviation = fBodyBodyGyroMag.std,
           frequency.body.gyro.jerk.magnitude.mean = fBodyBodyGyroJerkMag.mean,
           frequency.body.gyro.jerk.magnitude.standard.deviation = fBodyBodyGyroJerkMag.std
    ) %>%
    arrange(activity, subject) %>%
    group_by(activity, subject)
  
  tidy.averages <- tidy %>%
    summarise_each(funs(mean))
  
  setwd(output_dir)
  
  ## write out the two versions of the tidy data
  write.table(tidy, file="tidy.output", row.names=FALSE)
  write.table(tidy.averages, file="tidy.averages.output", row.names=FALSE)
  
  ## write out csv versions
  ## write.csv(tidy, file="tidy.csv", row.names=FALSE)
  ## write.csv(tidy.averages, file="tidy.averages.csv", row.names=FALSE)
  
  setwd(original_directory)
}