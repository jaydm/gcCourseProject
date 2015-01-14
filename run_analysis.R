library(stringr)

original_directory <- getwd()

meta_dir <- "/home/jaydm/courseWork/gettingAndCleaningData/UCI HAR Dataset/"
test_dir <- paste0(meta_dir, "test")
train_dir <- paste0(meta_dir, "train")

test_dir
train_dir

feature_file <- paste0(meta_dir, "features.txt")
features <- read.table(feature_file, sep = " ", col.names = c("feature_id", "feature_name"))

str(features)

head(features)