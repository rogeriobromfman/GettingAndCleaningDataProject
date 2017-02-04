## Set the working directory and load required libraries
setwd("C:/Users/Rogerio/Dropbox (Personal)/Coursera Project Week 3")
library(readr)
library(dplyr)
library(reshape2)

## Extract the labels from features.txt and activity_labels.txt
strFeatures <- read_file("UCI HAR Dataset/features.txt")
vecFeatures <- strsplit(strFeatures,"[0-9]+ ")
strFeatures <- NULL
vecFeatures <- gsub("\n","",vecFeatures[[1]][-(1:1)])
vecUse <- grepl("mean\\()|std\\()",vecFeatures,ignore.case = TRUE)
strActivities <- read_file("UCI HAR Dataset/activity_labels.txt")
vecActivities <- strsplit(strActivities,"[0-9] ")
strActivities <- NULL
vecActivities <- gsub("\n","",vecActivities[[1]][-(1:1)])

## First do all steps for test data

## Read subject_test.txt 
## (the subject identifier for each row)
strSubject <- read_file("UCI HAR Dataset/test/subject_test.txt")
vecSubject <- strsplit(strSubject, "\n")[[1]]
strSubject <- NULL

## Read y_test.txt
## (the activity identifier for each row)
strActivity <- read_file("UCI HAR Dataset/test/y_test.txt")
vecActivity <- strsplit(strActivity, "\n")[[1]]
strActivity <- NULL

## Read all columns from X_test.txt 
## (fixed-width values in sets of 561)
## filter only wanted columns
## append columns for subject and activity
## replace activity number with label
## save data frame to csv file
dfEntries <- read_table("UCI HAR Dataset/test/X_test.txt", col_names=vecFeatures)
dfEntries <- dfEntries[,vecUse]
dfEntries <- cbind(Subject=vecSubject, Activity=vecActivity, dfEntries)
dfEntries <- mutate(dfEntries,Activity=vecActivities[Activity])
vecActivity <- NULL
vecSubject <- NULL
write.table(dfEntries, file="dfEntries.csv", sep=",", row.names = FALSE)

## Repeat same steps to train data

## Read subject_train.txt 
## (the subject identifier for each row)
strSubject <- read_file("UCI HAR Dataset/train/subject_train.txt")
vecSubject <- strsplit(strSubject, "\n")[[1]]
strSubject <- NULL

## Read y_train.txt
## (the activity identifier for each row)
strActivity <- read_file("UCI HAR Dataset/train/y_train.txt")
vecActivity <- strsplit(strActivity, "\n")[[1]]
strActivity <- NULL

## Read all columns from X_train.txt 
## (fixed-width values in sets of 561)
## filter only wanted columns
## append columns for subject and activity
## replace activity number with label
## append data frame to csv file
dfEntries <- read_table("UCI HAR Dataset/train/X_train.txt", col_names=vecFeatures)
dfEntries <- dfEntries[,vecUse]
dfEntries <- cbind(Subject=vecSubject, Activity=vecActivity, dfEntries)
dfEntries <- mutate(dfEntries,Activity=vecActivities[Activity])
vecActivity <- NULL
vecSubject <- NULL
write.table(dfEntries, file="dfEntries.csv", sep=",", col.names=FALSE, row.names=FALSE, append = TRUE)

## reload dfEntries from the merged csv file
dfEntries <- read.table("dfEntries.csv", header=TRUE, sep=",", check.names = FALSE)

## melt and reshape dfEntries to get the mean of each variable 
## for every subject and every activity. The resulting data frame
## is 180 rows, i.e. 30 subjects x 6 activities.
dfEntriesMelt <- melt(dfEntries,id=c("Subject","Activity"))
dfEntriesTidy <- dcast(dfEntriesMelt, Subject + Activity ~ variable, mean)

## Make column names nicer to read
names(dfEntriesTidy) <- gsub("^t","time", names(dfEntriesTidy))
names(dfEntriesTidy) <- gsub("^f","frequency", names(dfEntriesTidy))
names(dfEntriesTidy) <- gsub("\\(\\)","", names(dfEntriesTidy)) ## removes parenthesis
names(dfEntriesTidy) <- gsub("Acc-","Acceleration-", names(dfEntriesTidy))
names(dfEntriesTidy) <- gsub("AccJerk-","AccelerationJerk-", names(dfEntriesTidy))
names(dfEntriesTidy) <- gsub("AccMag-","AccelerationMagnitude-", names(dfEntriesTidy))
names(dfEntriesTidy) <- gsub("Mag-","Magnitude-", names(dfEntriesTidy))

## Outputs the tidy data frame
write.table(dfEntriesTidy, file="dfEntriesTidy.csv", sep=",", row.names = FALSE)