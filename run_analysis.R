rm(list=ls())

#setting working directory
setwd("/Users/abasu/Documents/GettingCleaningData/UCI HAR Dataset")

#reading in data
features <- read.table("features.txt", header = FALSE)
activity <- read.table("activity_labels.txt", header = FALSE)
colnames(activity) <- c("activityID", "activityType")

#reading in the test data
X_test <- read.table("test/X_test.txt", header = FALSE)
colnames(X_test) <- features[,2]
Y_test <- read.table("test/y_test.txt", header = FALSE)
colnames(Y_test) <-"activityID"
subject_test <- read.table("test/subject_test.txt", header = FALSE)
colnames(subject_test) <- "subjectID"

#reading in the training data
X_train <- read.table("train/X_train.txt", header = FALSE)
colnames(X_train) <- features[,2]
Y_train <- read.table("train/y_train.txt", header = FALSE)
colnames(Y_train) <-"activityID"
subject_train <- read.table("train/subject_train.txt", header = FALSE)
colnames(subject_train) <- "subjectID"

#combining the data to create one data set
testdata <- cbind(Y_test, subject_test, X_test)
traindata <- cbind(Y_train, subject_train, X_train)
finaldata <- rbind(testdata, traindata)
colNames <- colnames(finaldata)

#extracting measurements for mean and standard deviation
#creating a logical vector
logicalVector <- (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames))
finaldata <- finaldata[logicalVector==TRUE]

#cleaning up the variable names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}

#reassigning the names to the final data set
colnames(finaldata) <- colNames

#creating a tidy data set

finaldataNoActivityType  <- finaldata[,names(finaldata) != 'activityType']
tidyData <- aggregate(finaldataNoActivityType[,names(finaldataNoActivityType) != c('activityID','subjectID')],by=list(activityID=finaldataNoActivityType$activityID,subjectID = finaldataNoActivityType$subjectID),mean)
tidyData <- merge(tidyData, activity, by='activityID',all.x=TRUE)
write.table(tidyData, 'tidyData.txt', row.names=FALSE, sep='\t')
