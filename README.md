getdata-course-project
======================

Coursera: Getting and Cleaning Data Course Project

### Data processing script

The run_analysis.R script works as follows:

1. If the dataset zip file does not exist, it is downloaded and unzipped.
1. All the input data is read to the corresponding separate data frames.
1. All the test data is merged into one data frame.
1. All the train data is merged into one data frame.
1. Test and train data is merged into one data frame.
1. The column names of the data frame are set.
1. All the columns except for the activity labels, subjects and the means and std measurements are discarded.
1. Activity labels ids are substituted with their respective names.
1. Column names are renames to become more readable.
1. The resulting data is groupped by the activities and subjects and summarized using the arithmetic means for these groups to form a new dplyr data frame.
1. The new data frame with mean values for the aforementioned groups is written to the means.txt file.

### Why the resulting data is tidy?

The data is tidy because it satisfies the following 4 principles of the tidy data (look at [CodeBook.md] and [means.txt]):
1. Each variable you measure should be in one column
1. Each different observation of that variable should be in a different row
1. There should be one table for each "kind" of variable
1. If you have multiple tables, they should include a column in the table that allows them to be linked
I have only one table.
