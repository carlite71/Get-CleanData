## Course Project Script for "Getting and Cleaning Data", March 2015

library(dplyr)

if(!file.exists("data")){dir.create("data")}
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/dataset.zip")

unzip("./data/dataset.zip")

file.rename("UCI HAR Dataset", "dataset")

data_test = read.table("dataset/test/X_test.txt")    #reads the data used to tests the model

data_train = read.table("dataset/train/X_train.txt")   #reads the data used to train the model


activity_test = read.table("dataset/test/y_test.txt")    #reads the test labels

activity_train = read.table("dataset/train/y_train.txt")   #reads the train labels


subject_test = read.table("dataset/test/subject_test.txt")   #reads the test subject ID labels

subject_train = read.table("dataset/train/subject_train.txt")  #reads the train subject ID labels


# act_labels = read.table("dataset/activity_labels.txt", stringsAsFactors = FALSE)


features = read.table("dataset/features.txt", stringsAsFactors = FALSE)   # reads features into a dataframe

variables = features[,2]   # creates a character vector with all the variable names


colnames(data_test) = colnames(data_train) = variables  # assigns the variable names to both datasets

colnames(activity_test) = colnames(activity_train) = "activity"  # assigns the variable name to activity column

colnames(subject_test) = colnames(subject_train) = "subjectID"   # assigns the variable name to subject column



full_test = cbind(subject_test, activity_test, data_test)       #binds test dataset

full_train = cbind(subject_train, activity_train, data_train)    #binds train dataset


full_set = rbind(full_train, full_test)  # combines train and test data



toMatch = c("mean", "std", "activity", "subject")  #patterns of the variables I need: mean and std


keep_var = unique (grep(paste(toMatch,collapse="|"),colnames(full_set), value=TRUE))  # returns a vector with only the means and std for all measures, 
# but it also includes meanFreq which I don't want

keep_var = keep_var[-grep("Freq", keep_var)]            # so I substract meanFreq from the original vector, now I only have mean() and std()

reduced_set = full_set[, which(names(full_set) %in% keep_var)]    # subsets the full dataset to keep only the means and stds




names(reduced_set) = gsub("\\()","", names(reduced_set))    # removes the parentheses in the variable names

names(reduced_set) = gsub("-","_", names(reduced_set))      # replaces - for _ in the variable names

reduced_set$activity = as.character(reduced_set$activity)   # in order to put adequate labels for activities, we need to convert to characters


reduced_set$activity[reduced_set$activity == "1"]  <- "walking"                        # adds  descriptive names to activities

reduced_set$activity[reduced_set$activity == "2"]  <- "walking_upstairs"              

reduced_set$activity[reduced_set$activity == "3"]  <- "walking_downstairs"

reduced_set$activity[reduced_set$activity == "4"]  <- "sitting"                        

reduced_set$activity[reduced_set$activity == "5"]  <- "standing"

reduced_set$activity[reduced_set$activity == "6"]  <- "laying"


# creates the independent tidy dataset that summarizes the means and std for each individual and activity

tidy_data  <-       
  
  reduced_set %>%
  group_by(subjectID, activity)%>%
  summarise_each(funs(mean)) 

# writes the tidy set into a text file as specified in instructions

write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)