Getting and Cleaning Data Project
=

Project for week 4 of Coursera's Getting and Cleaning Data

The run_analysis.R script converts the test and train data from UCI HAR Dataset into a tidy dataset with exactly 180 rows and 68 columns. Refer to CodeBook.md for a description of the rows and columns.

Loading labels and column names
-

The script starts by extracting the feature (column) names from features.txt. I used strsplit to separate the string read from the file into the several column names, delimited by their respective column numbers. The same method is applied to activity_labels.txt to retrieve the name of the 6 types of activities.

Loading data and merging test and train
-

The next step is to process the test data. First the script loads subject_test.txt and y_test.txt to identify the subject and activity for each of the rows in the main data set file. Then it loads the X_test.txt file that contains the actual test data, with all the features (columns).

A variable vecUse is created selecting all columns that have names with mean() or std(). This variable is then applied to the data frame that was loaded, to filter out the unnecessary columns. 

The next step is to add the Subject and Activity columns to the data frame and replace the Activity numbers by the actual labels (using mutate from dplyr).

Finally the data frame is written out to a new csv file (using write.table)

All the steps above are repeated for the train dataset (i.e. using subject_train.txt, y_train.txt and X_train.txt). The data is appended to the same csv file as new rows. 

Reshaping the data frame
-

The merged csv file is reloaded into R for the final transformation. First the data frame is melted (library reshape2) using Subject and Activity as ids. Using dcast, the data is then reshaped to display 180 rows (one for each subject and for each activity) and the columns showing the means of the 66 selected variables.

A series of calls to gsub are made to relabel the columns and make them easier to read.

Exporting the tidy dataset
-

Finally, the data is written out to a new csv file called dfEntries.csv (using write.table)


> Written with [StackEdit](https://stackedit.io/).