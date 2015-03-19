#Project: Cleaning and Organizing Data from a Raw Dataset

## Original Dataset Information:

### Title:
**Human Activity Recognition Using Smartphones Dataset
 Version 1.0**
	
### Authors:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universita degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
	
### Experimental setup:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
For more information please refer to the original dataset (link below). 

	

### Raw Data:
	
The original files, as well as complete information about the measured variables, that compose this dataset can be obtained from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
	
## Tidy version of dataset:
	
The tidy version of this dataset contains the averages of readings for each variable per individual, per activity; making a total of 180 observations (30 individuals, 6 activities each).

Each observation (Individual + Activity) was assigned a 66-element vector with the means and standard deviations of the variables in the original dataset. Please refer to the Code Book for detailed information on the variables.
	
	
### Components:
	
- get_tidy.R: Script used to organize and clean up the data
- README.md 
- CodeBook.md: Explanation of the data and variables.


## Cleaning and Organization of the dataset

#####The script get_tidy.R was written to obtain a reduced, tidy dataset as follows:

The original dataset was divided into two parts: the data used to train the model (75% of observations) and the data used to test it (25% of observations).

Data for features (a.k.a. variables), activities and test subjects were provided in separate text files.

First, each subset was separately constructed by putting together the data with the corresponding subject and activity information. Proper names were assigned to columns to identify each variable.

Both training and test sets were then combined into a full dataset.

This full dataset was subset to keep only means and standard deviations for each of the variables, as well as the activity and subjectID columns.

The variable names were kept similar to the originals for convenience and ease of read. Extra characters were removed, and dashes replaced with underscores.

The activity column was originally number-coded. Those numbers were replaced by their corresponding activities.

Finally, the data was summarized by taking the average of each variable for each activity and each subject.

The output is a file called "tidy_data.txt".