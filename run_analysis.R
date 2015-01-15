library(dplyr)
library(data.table)
library(LaF)
library(tidyr)

original_directory <- getwd()

meta_dir <- "/home/jaydm/courseWork/gettingAndCleaningData/UCI HAR Dataset/"
test_dir <- paste0(meta_dir, "test/")
train_dir <- paste0(meta_dir, "train/")

test_dir
train_dir

feature.file <- paste0(meta_dir, "features.txt")
features <- read.table(feature.file, sep = " ", col.names = c("feature_id", "feature_name"), colClasses=c("numeric","character"))

rm("feature.file")

pretty_features <- mutate(features, feature_name = gsub(",","-",gsub("\\)","",gsub("\\(","",features$feature_name))))

features <- data.table(features)

str(features)
head(features)

activity.file <- paste0(meta_dir, "activity_labels.txt")
activities <- read.table(activity.file, sep = " ", col.names = c("activity_id", "activity_name"))

rm("activity.file")

activities <- data.table(activities)

str(activities)
head(activities)

train.subject.file <- paste0(train_dir, "subject_train.txt")
train.subject <- read.table(train.subject.file, col.names = c("subject_id"))

train.subject <- data.table(train.subject)
train.subject$id <- seq_len(nrow(train.subject))

setkey(train.subject, id)

str(train.subject)
head(train.subject)

train.activity.file <- paste0(train_dir, "y_train.txt")
train.activity <- read.table(train.activity.file, col.names = c("activity_id"))

train.activity <- data.table(train.activity)
train.activity$id <- seq_len(nrow(train.activity))

setkey(train.activity, id)

str(train.activity)
head(train.activity)

train.data.file <- paste0(train_dir, "X_train.txt")
laf <- laf_open_fwf(train.data.file, column_widths = rep(16,561),column_types=rep("numeric",561),column_names=pretty_features$feature_name)

train.data <- data.table(laf[,])

train.selected <- train.data %>% select(features[grepl("mean\\(", features$feature_name) | grepl("std\\(", features$feature_name)]$feature_id)
train.selected$id <- seq_len(nrow(train.selected))

setkey(train.selected, id)

str(train.selected)
head(train.selected)

training <- join_all(list(train.selected, train.subject, train.activity))

rm("train.subject.file")
rm("train.subject")
rm("train.activity.file")
rm("train.activity")
rm("train.data.file")
rm("train.data")
rm("train.selected")

test.subject.file <- paste0(test_dir, "subject_test.txt")
test.subject <- read.table(test.subject.file, col.names = c("subject_id"))

test.subject <- data.table(test.subject)
test.subject$id <- seq_len(nrow(test.subject))

setkey(test.subject, id)

str(test.subject)
head(test.subject)

test.activity.file <- paste0(test_dir, "y_test.txt")
test.activity <- read.table(test.activity.file, col.names = c("activity_id"))

test.activity <- data.table(test.activity)
test.activity$id <- seq_len(nrow(test.activity))

setkey(test.activity, id)

str(test.activity)
head(test.activity)

test.data.file <- paste0(test_dir, "X_test.txt")
laf <- laf_open_fwf(test.data.file, column_widths = rep(16,561),column_types=rep("numeric",561),column_names=pretty_features$feature_name)

test.data <- data.table(laf[,])

test.selected <- test.data %>% select(features[grepl("mean\\(", features$feature_name) | grepl("std\\(", features$feature_name)]$feature_id)
test.selected$id <- seq_len(nrow(test.selected))

setkey(test.selected, id)

str(test.selected)
head(test.selected)

testing <- join_all(list(test.selected, test.subject, test.activity))

rm("test.subject.file")
rm("test.subject")
rm("test.activity.file")
rm("test.activity")
rm("test.data.file")
rm("test.data")
rm("test.selected")

full.data <- data.table(rbind(training, testing))

rm("training")
rm("testing")

setkey(full.data, activity_id)

full.data <- merge(full.data, activities)
full.data$id <- seq_len(nrow(full.data))

setkey(full.data, id)

tables()

