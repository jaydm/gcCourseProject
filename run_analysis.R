library(plyr)
library(dplyr)
library(data.table)
library(LaF)
library(tidyr)

## store the original directory
original_directory <- getwd()

## set meta_dir to the parent folder of the unzipped data set
meta_dir <- "/home/jaydm/courseWork/gettingAndCleaningData/UCI HAR Dataset/"

## the test and train directory variable should not require any modification
test_dir <- paste0(meta_dir, "test/")
train_dir <- paste0(meta_dir, "train/")

## set output_dir to the location where you want the tidy data to be created
## if you want them in the working directory
## output_dir <- "."
## if you want them in the base of the data set directory
output_dir <- meta_dir

setwd(output_dir)

## it is necessary to load in the feature names in order to use them for column headings
feature.file <- paste0(meta_dir, "features.txt")
features <- read.table(feature.file, sep = " ", col.names = c("feature_id", "feature_name"), colClasses=c("numeric","character"))

## remove the variable once it is no longer needed
rm("feature.file")

## but, there are a number of invalid characters in the feature names
## create a 'pretty' version of the feature names that will be valid as
## column headings
pretty_features <- mutate(features, feature_name = gsub(",","-",gsub("\\)","",gsub("\\(","",features$feature_name))))

## load in the activity lables for cross referencing in the ouput data
activity.file <- paste0(meta_dir, "activity_labels.txt")
activities <- read.table(activity.file, sep = " ", col.names = c("activity_id", "activity_name"))

## remove the variable once it is no longer needed
rm("activity.file")

activities <- data.table(activities)

## begin the actual processing of the data

## begin processing of the training data

## load the test subjects
train.subject.file <- paste0(train_dir, "subject_train.txt")
train.subject <- read.table(train.subject.file, col.names = c("subject_id"))

train.subject <- data.table(train.subject)

## add an id that correspond to the row so that the relationship
## will not be lost during merges
train.subject$id <- seq_len(nrow(train.subject))

## create a key on the training subject table for the row id
setkey(train.subject, id)

## load the activities that correspond to the test data
train.activity.file <- paste0(train_dir, "y_train.txt")
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
train.data.file <- paste0(train_dir, "X_train.txt")
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

## Begin processing of the test data

## load the testing subjects
test.subject.file <- paste0(test_dir, "subject_test.txt")
test.subject <- read.table(test.subject.file, col.names = c("subject_id"))

test.subject <- data.table(test.subject)

## add a row id column to protect against row re-ordering
test.subject$id <- seq_len(nrow(test.subject))

## add a key based on the row id for later joining
setkey(test.subject, id)

## load the test activities
test.activity.file <- paste0(test_dir, "y_test.txt")
test.activity <- read.table(test.activity.file, col.names = c("activity_id"))

test.activity <- data.table(test.activity)

## add a row id column to protect against row re-ordering
test.activity$id <- seq_len(nrow(test.activity))

## add a key base on the row id for later joining
setkey(test.activity, id)

## load the actual test data using the LaF package
## for faster loading of large tables of fixed
## width data
test.data.file <- paste0(test_dir, "X_test.txt")
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
         time.body.accelerometer.mean.x = tBodyAcc.mean.X,
         time.body.accelerometer.mean.y = tBodyAcc.mean.Y,
         time.body.accelerometer.mean.z = tBodyAcc.mean.Z,
         time.body.accelerometer.standard.deviation.x = tBodyAcc.std.X,
         time.body.accelerometer.standard.deviation.y = tBodyAcc.std.Y,
         time.body.accelerometer.standard.deviation.z = tBodyAcc.std.Z,
         time.gravity.accelerometer.mean.x = tGravityAcc.mean.X,
         time.gravity.accelerometer.mean.y = tGravityAcc.mean.Y,
         time.gravity.accelerometer.mean.z = tGravityAcc.mean.Z,
         time.gravity.accelerometer.standard.deviation.x = tGravityAcc.std.X,
         time.gravity.accelerometer.standard.deviation.y = tGravityAcc.std.Y,
         time.gravity.accelerometer.standard.deviation.z = tGravityAcc.std.Z,
         time.body.accelerometer.jerk.mean.x = tBodyAccJerk.mean.X,
         time.body.accelerometer.jerk.mean.y = tBodyAccJerk.mean.Y,
         time.body.accelerometer.jerk.mean.z = tBodyAccJerk.mean.Z,
         time.body.accelerometer.jerk.standard.deviation.x = tBodyAccJerk.std.X,
         time.body.accelerometer.jerk.standard.deviation.y = tBodyAccJerk.std.Y,
         time.body.accelerometer.jerk.standard.deviation.z = tBodyAccJerk.std.Z,
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
         frequency.body.accelerometer.mean.x = fBodyAcc.mean.X,
         frequency.body.accelerometer.mean.y = fBodyAcc.mean.Y,
         frequency.body.accelerometer.mean.z = fBodyAcc.mean.Z,
         frequency.body.accelerometer.standard.deviation.x = fBodyAcc.std.X,
         frequency.body.accelerometer.standard.deviation.y = fBodyAcc.std.Y,
         frequency.body.accelerometer.standard.deviation.z = fBodyAcc.std.Z,
         frequency.body.accelerometer.jerk.mean.x = fBodyAccJerk.mean.X,
         frequency.body.accelerometer.jerk.mean.y = fBodyAccJerk.mean.Y,
         frequency.body.accelerometer.jerk.mean.z = fBodyAccJerk.mean.Z,
         frequency.body.accelerometer.jerk.standard.deviation.x = fBodyAccJerk.std.X,
         frequency.body.accelerometer.jerk.standard.deviation.y = fBodyAccJerk.std.Y,
         frequency.body.accelerometer.jerk.standard.deviation.z = fBodyAccJerk.std.Z,
         frequency.body.gyro.mean.x = fBodyGyro.mean.X,
         frequency.body.gyro.mean.y = fBodyGyro.mean.Y,
         frequency.body.gyro.mean.z = fBodyGyro.mean.Z,
         frequency.body.gyro.standard.deviation.x = fBodyGyro.std.X,
         frequency.body.gyro.standard.deviation.y = fBodyGyro.std.Y,
         frequency.body.gyro.standard.deviation.z = fBodyGyro.std.Z
         ) %>%
  arrange(activity, subject) %>%
  group_by(activity, subject)

tidy.averages <- tidy %>%
  summarise_each(funs(mean))

## write out the two versions of the tidy data
write.table(tidy, file="tidy.output", row.names=FALSE)
write.table(tidy.averages, file="tidy.averages.output", row.names=FALSE)

## write out csv versions
write.csv(tidy, file="tidy.csv", row.names=FALSE)
write.csv(tidy.averages, file="tidy.averages.csv", row.names=FALSE)

setwd(original_directory)