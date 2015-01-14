library(stringr)
library(plyr)
library(dplyr)

original_directory <- getwd()

meta_dir <- "/home/jaydm/courseWork/gettingAndCleaningData/UCI HAR Dataset/"
test_dir <- paste0(meta_dir, "test/")
train_dir <- paste0(meta_dir, "train/")

test_dir
train_dir

feature.file <- paste0(meta_dir, "features.txt")
features <- read.table(feature.file, sep = " ", col.names = c("feature_id", "feature_name"), colClasses=c("numeric","character"))

features <- mutate(features, feature_name = gsub(",","-",gsub("\\)","",gsub("\\(","",features$feature_name))))

str(features)
head(features)

activity.file <- paste0(meta_dir, "activity_labels.txt")
activities <- read.table(activity.file, sep = " ", col.names = c("activity_id", "activity_name"))

str(activities)
head(activities)

train.subject.file <- paste0(train_dir, "subject_train.txt")
train.subject <- read.table(train.subject.file, col.names = c("subject_id"))

str(train.subject)
head(train.subject)

train.activity.file <- paste0(train_dir, "y_train.txt")
train.activity <- read.table(train.activity.file, col.names = c("activity_id"))

str(train.activity)
head(train.activity)

train.data.file <- paste0(test_dir, "X_train.txt")
train.data <- read.fwf(train.data.file, widths = rep(16, 561), col.names = features$feature_name, n = 1)

str(train.data)
head(train.data)

test.subject.file <- paste0(test_dir, "subject_test.txt")
test.subject <- read.table(test.subject.file, col.names = c("subject_id"))

str(test.subject)
head(test.subject)

test.activity.file <- paste0(test_dir, "y_test.txt")
test.activity <- read.table(test.activity.file, col.names = c("activity_id"))

str(test.activity)
head(test.activity)

test.data.file <- paste0(test_dir, "X_test.txt")
test.data <- read.fwf(test.data.file, widths = rep(16, 561), col.names = features$feature_name, n = 1)

str(test.data)
head(test.data)

