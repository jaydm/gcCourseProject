library(stringr)
library(plyr)
library(dplyr)
library(data.table)
library(LaF)

original_directory <- getwd()

meta_dir <- "/home/jaydm/courseWork/gettingAndCleaningData/UCI HAR Dataset/"
test_dir <- paste0(meta_dir, "test/")
train_dir <- paste0(meta_dir, "train/")

test_dir
train_dir

feature.file <- paste0(meta_dir, "features.txt")
features <- read.table(feature.file, sep = " ", col.names = c("feature_id", "feature_name"), colClasses=c("numeric","character"))

features <- mutate(features, feature_name = gsub(",","-",gsub("\\)","",gsub("\\(","",features$feature_name))))
features <- data.table(features)

str(features)
head(features)

activity.file <- paste0(meta_dir, "activity_labels.txt")
activities <- read.table(activity.file, sep = " ", col.names = c("activity_id", "activity_name"))

activities <- data.table(activities)

str(activities)
head(activities)

train.subject.file <- paste0(train_dir, "subject_train.txt")
train.subject <- read.table(train.subject.file, col.names = c("subject_id"))

train.subject <- data.table(train.subject)
train.subject$row_number <- seq_len(nrow(train.subject))

setkey(train.subject, row_number)

str(train.subject)
head(train.subject)

train.activity.file <- paste0(train_dir, "y_train.txt")
train.activity <- read.table(train.activity.file, col.names = c("activity_id"))

train.activity <- data.table(train.activity)
train.activity$row_number <- seq_len(nrow(train.activity))

setkey(train.activity, row_number)

str(train.activity)
head(train.activity)

train.data.file <- paste0(train_dir, "X_train.txt")
laf <- laf_open_fwf(train.data.file, column_widths = rep(16,561),column_types=rep("numeric",561),column_names=features$feature_name)

train.data <- data.table(laf[,])
train.data$row_number <- seq_len(nrow(train.data))

setkey(train.data, row_number)

str(train.data)
head(train.data)

training <- merge(merge(train.data, train.subject), train.activity)

colnames(training)

setkey(training, activity_id)

training.full <- merge(training, activities)

test.subject.file <- paste0(test_dir, "subject_test.txt")
test.subject <- read.table(test.subject.file, col.names = c("subject_id"))

test.subject <- data.table(test.subject)
test.subject$row_number <- seq_len(nrow(test.subject))

setkey(test.subject, row_number)

str(test.subject)
head(test.subject)

test.activity.file <- paste0(test_dir, "y_test.txt")
test.activity <- read.table(test.activity.file, col.names = c("activity_id"))

test.activity <- data.table(test.activity)
test.activity$row_number <- seq_len(nrow(test.activity))

setkey(test.activity, row_number)

str(test.activity)
head(test.activity)

test.data.file <- paste0(test_dir, "X_test.txt")
laf <- laf_open_fwf(test.data.file, column_widths = rep(16,561),column_types=rep("numeric",561),column_names=features$feature_name)

test.data <- data.table(laf[,])
test.data$row_number <- seq_len(nrow(test.data))

setkey(test.data, row_number)

str(test.data)
head(test.data)

testing <- merge(test.data, test.subject, all=TRUE)
testing <- merge(testing, test.activity, all=TRUE)

colnames(testing)

setkey(testing, activity_id)

testing.full <- merge(testing, activities)

full.data <- rbind(training.full, testing.full)
