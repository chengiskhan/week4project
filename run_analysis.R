library(dplyr)
features<-read.table("UCI HAR Dataset/features.txt")
testdata<-read.table("UCI HAR Dataset/test/X_test.txt")
testsubjects<-read.table("UCI HAR Dataset/test/subject_test.txt")
testactivities<-read.table("UCI HAR Dataset/test/y_test.txt")
traindata<-read.table("UCI HAR Dataset/train/X_train.txt")
trainsubjects<-read.table("UCI HAR Dataset/train/subject_train.txt")
trainactivities<-read.table("UCI HAR Dataset/train/y_train.txt")

#creates the data set as an empty data frame
testtraindata<-data.frame(matrix(ncol=563,nrow=0))

#takes the features data, adds the subject and activity labels, and 
#uses the data to set the variable names for the data frame
features<-features[,2]
features<-c("subject","activity",as.character(features))
names(testtraindata)<-features

#combines the subject and activity data to the test data
testdata<-cbind(testsubjects,testactivities,testdata)
names(testdata)<-names(testtraindata)

#combines the subject and activity data to the train data
traindata<-cbind(trainsubjects,trainactivities,traindata)
names(traindata)<-names(testtraindata)

#combines the test and train data into data frame
testtraindata<-rbind(testtraindata,testdata,traindata)

#subsets the data frame keeping the mean and std columns only
savecols<-c(1,2,3,grep("mean\\(\\)|std\\(\\)",names(testtraindata)))
testtraindata<-testtraindata[,savecols]

#changes the activity values to descriptive names
testtraindata$activity<-sub("1","walk",testtraindata$activity)
testtraindata$activity<-sub("2","walkupstrs",testtraindata$activity)
testtraindata$activity<-sub("3","walkdownstrs",testtraindata$activity)
testtraindata$activity<-sub("4","sit",testtraindata$activity)
testtraindata$activity<-sub("5","stand",testtraindata$activity)
testtraindata$activity<-sub("6","lay",testtraindata$activity)

#removes the parentheses from the variable names
names(testtraindata)<-sub("\\(\\)","",names(testtraindata))

#creates a new data set with the means of all variables by activity
groupactivity<-group_by(testtraindata,activity)
activitydf<-summarize_each(groupactivity, funs(mean))

#creates a new data set with the means of all variables by subject
groupsubject<-group_by(testtraindata,subject)
subjectdf<-summarize_each(groupsubject, funs(mean))

#combines the new data sets into one
cleanset<-rbind(activitydf,subjectdf)
cleanset[1:6,2]<-rep(NA,6)
