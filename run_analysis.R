#i
#First we have to get the data
if(!file.exists("./project")){dir.create("./project")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./project/Dataset.zip",method="curl")

#Let's unzip the files
unzip(zipfile="./project/Dataset.zip",exdir="./project")

#Let's see the files we have
patron <- file.path("./project" , "UCI HAR Dataset")
archivos<-list.files(patron, recursive=TRUE)
archivos

#ii
#Let's read the information into variables

#Training
ActivityTrain <- read.table(file.path(patron, "train", "Y_train.txt"),header = FALSE)
FeaturesTrain <- read.table(file.path(patron, "train", "X_train.txt"),header = FALSE)
SubjectTrain <- read.table(file.path(patron, "train", "subject_train.txt"),header = FALSE)

#Test
ActivityTest  <- read.table(file.path(patron, "test" , "Y_test.txt" ),header = FALSE)
FeaturesTest  <- read.table(file.path(patron, "test" , "X_test.txt" ),header = FALSE)
SubjectTest  <- read.table(file.path(patron, "test" , "subject_test.txt"),header = FALSE)

#####INTRUCTIONS

### 1.-Merges the training and the test sets to create one data set

#iii Combine by rows

Activity<- rbind(ActivityTrain,ActivityTest)
Features<- rbind(FeaturesTrain, FeaturesTest)
Subject <- rbind(SubjectTrain, SubjectTest)

#Naming the variables
names(Activity)<- c("activity")
names(Subject)<-c("subject")
FeaturesNames <- read.table(file.path(patron, "features.txt"),head=FALSE)
names(Features)<- FeaturesNames$V2

#iv Combining the columns to a dataframe
dcombine <- cbind(Subject, Activity)
data_frame <- cbind(Features, dcombine)

### 2.-Extracts only the measurements on the mean and standard deviation for each measurement

#v Obtaining the mean and standard deviation
subFeaturesNames<-FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
selectedNames<-c(as.character(subFeaturesNames), "subject", "activity" )
data_frame<-subset(data_frame,select=selectedNames)
str(data_frame)

### 3.-Uses descriptive activity names to name the activities in the data set

#vi
activityLabels <- read.table(file.path(patron, "activity_labels.txt"),header = FALSE)
head(data_frame$activity,15)

### 4.-Appropriately labels the data set with descriptive variable names

#vii
names(data_frame)<-gsub("Gyro", "Gyroscope", names(data_frame))
names(data_frame)<-gsub("Mag", "Magnitude", names(data_frame))
names(data_frame)<-gsub("BodyBody", "Body", names(data_frame))
names(data_frame)<-gsub("^t", "time", names(data_frame))
names(data_frame)<-gsub("^f", "frequency", names(data_frame))
names(data_frame)<-gsub("Acc", "Accelerometer", names(data_frame))


### 5.- From the data set in step 4, creates a second, 
### independent tidy data set with the average of each variable for each activity and each subject

library(plyr)
data_frame2<-aggregate(. ~subject + activity, data_frame, mean)
data_frame2<-data_frame2[order(data_frame2$subject,data_frame2$activity),]
write.table(data_frame2, file = "tidydata.txt",row.name=FALSE)