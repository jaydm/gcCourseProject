# gcCourseProject
Course project for Coursera course: Getting and Cleaning Data

## Overview

This program is intended to take the testing data from a study performed on wearable device information and tidy the processed data in a way that makes it easier to perform additional analysis.

The initial data includes 561 measurements. But, the program only includes the means and standard deviations from the original data.

And the descriptive activity labels and subject (test subject) IDs are also pulled into the output data set.

## How to run the program

In order to execute the program, you must have the following packages installed in your R environment:

- plyr
- dplyr
- data.table
- LaF

To actually run the script type:

- source("run_analysis.R")
- process(data_dir = "<parent directory of the unzipped data archive>", output_dir = "<location where you want the tidied output to be created>")

The output_dir parameter is optional. If it is not specified, then it will default to the data_dir.

### Example:

If you have copied the run_analysis.R file into the data directory and want the output to be created in that directory as well type:

- source("run_analysis.R")
- process(data_dir = ".")

## Processing (What steps are involved in tidying the data)
1. The program will store the original directory location in order to be able to return to it after processing.
1. Next, the program will change into the data directory (specified by including 'data_dir = "." in the call to process() if the script is located in the parent directory of the unzipped data archive).
1. The feature descriptions are pulled from the 'features.txt' file into a data table called features.
1. The descriptions are stripped of the characters '(' and ')' and any hyphens are replaced with dots in order to make valid R variable names. This processed result is stored in a data table called pretty_features.
1. The activity labels are pulled from the 'activity_labels.txt' file and loaded into a data table called activities.
1. The program will then change into the train subdirectory in order to load the training data set.
1. The subjects that correspond to each measurement in the training data are pulled from the file 'subject_train.txt' into a data table called train.subject. Then, a row number ID (called id) is created for each row in the table and populated with the position in the table. And, that field is set to the table ID using setkey().
1. The activity codes that correspond to each measurement in the training data are pulled from the file 'y_train.txt' into a data table called train.activity. Then, a row number id (called id) is created for each row in the table and populated with the position in the table. And, that field is set to the table ID using setkey().
1. The actual training measurements will then be opened using the LaF package in order to read them more quickly. The data is formatted as a series of 561 fixed width columns of sixteen characters each and the use of this package greatly improves the time needed to load the data. The 'pretty_features' data table is used to create column headings in the table. The resulting data is stored in a data table called train.data.
1. The original features data table is then used to determine all of the columns in the data set that contain the text 'mean()' or 'std()' and only those columns are selected out using the select verb into a new data table called train.selected. A row identifier is created for each row of the table and it is set as the table id using setkey().
1. The three tables of training data are merged together based on the row ID (set previously for each) using the join_all function and the resulting data is stored in a table called training.
1. The program then changes into the test data subdirectory and follows the same set of processes on the corresponding test data eventually resulting in a data table called testing.
1. The two data tables (training and testing) are then combined using the rbind function and the resulting data table stored as full.data.
1. The combined measurement data then has its key set as the activity ID in preparation for merging against the activities data table.
1. 
1. The program will then change back to the originally stored directory location.

## Final output

The script will create two tables. One with the detailed combination of the training and testing data (a total of 10299 rows). And a second with the averaged values across each activity and subject (a total of 180 rows).

- tidy.output (detailed processed data)
- tidy.averages.output (summarized across each activity/subject)