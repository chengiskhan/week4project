# week4project

The run_analysis.R file runs the scripts that create the "testtraindata" data set, which is the combined test and train data from the Human Activity Recognition Using Smartphones Dataset, as well as the "cleanset", which is the summary data containing the average of each variable for each activity and each subject.

The methodology for creating the "testraindata" and "cleanset" tables was as follows:
1. Read all tables
2. Create an empty data frame
3. Use the features.txt file to set the variable names for the data frame
4. Combine the subject and activity data to the test data
5. Combine the subject and activity data to the train data
6. Combine the test and train data
7. Subset the data frame keeping the mean and std columns only
8. Change the activity values to descriptive names
9. Create the new data set with the means of all the variables
