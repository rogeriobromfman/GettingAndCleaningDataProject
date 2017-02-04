Codebook for the Getting and Cleaning Data Project Data Frame
=

The variables present in dfEntriesTidy are derived from the original variables in the UCI HAR Dataset. The descriptions of the original variables can be found in features_info.txt.

The first two columns in the data set identify the subject (1 to 30) and the activity (walking, walking upstairs, walking downstairs, sitting, standing and laying).

Only mean and standard deviation variables were required, so all variables that did not end in mean() or std() were discarded. Some changes were made to the other variable names to make them more descriptive. The resulting data set contains 66 variables as follows:

 - timeBodyAcceleration (mean and std, XYZ axis)
 - timeGravityAcceleration (mean and std, XYZ axis)
 - timeBodyAccelerationJerk (mean and std, XYZ axis)
 - timeBodyGyro (mean and std, XYZ axis)
 - timeBodyGyroJerk (mean and std, XYZ axis)

 - timeBodyAccelerationMagnitude (mean and std)
 - timeGravityAccelerationMagnitude (mean and std)
 - timeBodyAccelerationJerkMagnitude (mean and std)
 - timeBodyGyroMagnitude (mean and std)
 - timeBodyGyroJerkMagnitude (mean and std)

 - frequencyBodyAcceleration (mean and std, XYZ axis)
 - frequencyBodyAccelerationJerk (mean and std, XYZ axis)
 - frequencyBodyGyro (mean and std, XYZ axis)

 - frequencyBodyAccelerationMagnitude (mean and std)
 - frequencyBodyBodyAccelerationJerkMagnitude (mean and std)
 - frequencyBodyBodyGyroMagnitude (mean and std)
 - frequencyBodyBodyGyroJerkMagnitude (mean and std)

The data set contains 180 rows, i.e. one for each of the 30 subjects and each of the 6 activities. The values are the means of all observations for each variable for each of the 180 pairs.

> Written with [StackEdit](https://stackedit.io/).