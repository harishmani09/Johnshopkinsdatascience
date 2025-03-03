---
title: "CodeBook"
author: "Harish Mani"
date: "2025-03-03"
output: html_document
---


data Source: ["https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones"](UCI Machine Learning Repository)

this codebook was written with aim to give information about the variables in the data, transformation done on the data to make it 'tidy' data

##Data Set Information(from the website)
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment. 

####The precleaned data includes the following;
- activity_labels.txt
- features_info.txt
- features.txt
- README.txt
- train/X_train.txt
- train/y_train.txt
- train/subject_train.txt 
- train/Intertial Signals
- test/subject_test.txt
- test/X_test.txt
- test/y_test.txt 
- test/Intertial Signals


##Task
1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#### Brief walkthrough the process
The data was downloaded from the given url using *download.file* function and read using data.table *fread*. To accomplish the merge task we had to fist filter out mean and std with *grep*. To do that we had to load activity and features file. We also had to create measurements variable which contained variable names to be labelled in test and train data and tidying the name with *gsub*. This helped us to load train and test files. We also used setnames function to rename the variables, which enabled us to merge the files using rbind function. 
With merged dataset we were in a position to create a new dataset with with average of each variable for each activity and each subject. To do this we had to convert the variables in the activity and subject no into factors. Then we used melt and dcast functions to get mean. Then we were able to use fwrite to get the clean and tidy data in a new file

### the following labels were used 
"t"="Time"
"f"="Frequency"
"Acc"="Accelerometer"
"Gyro"="Gyroscope"
"Mag" = "Magnitude"
"BodyBody"="Body"
"()"=""


