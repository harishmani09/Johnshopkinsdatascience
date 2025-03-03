#the script run_analysis does the following things
# it pulls data from the given url and then reads the data using datatables
# it extracts only the mean and std from the measurements 
# it gives descriptive names to the fields for easier understanding 
# it merges the test and train dataset to create a new tidy data


library(dplyr)
library(data.table)
library(reshape2)
library(gsubfn)
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile = 'tidydata.zip',method='curl')

#extracting the files from zip folder to the 'UCI HAR ...' folder
if (!file.exists('UCI HAR Dataset')){
    unzip('tidydata.zip')
}

#load activity and features datatables
activityLabels <- fread('UCI HAR Dataset/activity_labels.txt', col.names = c('classLabels','activityNames'))
features <- fread('UCI HAR Dataset/features.txt',col.names = c('index','featureNames'))


#extracting mean and std from features
featuresNeeded <- grep("(mean|std)\\(\\)",features[,featureNames])
measurements <- features[featuresNeeded, featureNames]
measurements <- gsubfn("(^t|^f|Acc|Gyro|Mag|BodyBody|\\(\\))",list(
     "t"="Time",
     "f"="Frequency",
     "Acc"="Accelerometer",
     "Gyro"="Gyroscope",
     "Mag" = "Magnitude",
     "BodyBody"="Body",
     "()"=""
),measurements)

#loading training datasets
training_set <- fread('UCI HAR Dataset/train/X_train.txt')[,featuresNeeded,with=FALSE]
data.table::setnames(training_set,colnames(training_set),measurements) #change col names based on measurements
training_label <- fread('UCI HAR Dataset/train/y_train.txt',col.names = c("Activity"))
trainSubjects <- fread('UCI HAR Dataset/train/subject_train.txt',col.names = c("subjectNum"))
train <- cbind(training_label,trainSubjects,training_set)

#load test datasets
test_set <- fread('UCI HAR Dataset/test/X_test.txt')[,featuresNeeded,with=FALSE]
data.table::setnames(test_set,colnames(test_set),measurements)
test_label <- fread('UCI HAR Dataset/test/y_test.txt',col.names = c('Activity'))
testSubjects <- fread('UCI HAR Dataset/test/subject_test.txt',col.names = c("subjectNum"))
test <- cbind(test_label,testSubjects,test_set)

#merge datasets
combined <- rbind(train,test)

#factor activity columns based on activity labels, use factor() to set own levels and labels
combined[['Activity']] <-factor(combined[,Activity], levels = activityLabels[["classLabels"]],labels = activityLabels[["activityNames"]])
combined[['subjectNum']] <-as.factor(combined[,subjectNum])

#melt and recast data table to find mean 

combined <- melt.data.table(combined,id=c("subjectNum","Activity"))
combined <- dcast(data=combined,subjectNum+Activity ~ variable, fun.aggregate = mean)

#write final tidy data to a new file
data.table::fwrite(x=combined,file='tidyData.txt',quote = FALSE)