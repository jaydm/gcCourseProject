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

If you have copied the run_analysis.R file into the data directory and want the output to be created in that directory type:

- source("run_analysis.R")
- process(data_dir = ".")

## Processing (What steps are involved in tidying the data)

## Final output

The script will create two tables. One with the detailed combination of the training and testing data (a total of 10299 rows). And a second with the averaged values across each activity and subject (a total of 180 rows).

- tidy.output (detailed processed data)
- tidy.averages.output (summarized across each activity/subject)