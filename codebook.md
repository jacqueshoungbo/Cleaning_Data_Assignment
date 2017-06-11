Data for this project have been downloaded from:
 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzipping the downloaded file creates the following
UCI HAR Dataset
	|
	\train
		|
		\Inertial Signals
		subject_train.txt
		X_train.txt
		y_train.txt
	\test
		|
		\Inertial Signals
		subject_test.txt
		X_test.txt
		y_test.txt
	README.txt
	features_info.txt
	features.txt
	activity_labels.txt

A test set has been created by binding (column wise) the 3 set subject_test.txt,  X_test.txt and y_test.txt. A new variable labelled “category” has been added, with value “test” for all records.

A train set has been created by binding (column wise) the 3 set subject_train.txt,  X_ train.txt and y_train.txt. A new variable labelled “category” has been added, with value “train” for all records.
Those two set are now bound (row wise). 

The core business of the script is now to set the names of the variables of this set according to the records in the features.txt. For the sake of easy manipulation, that data set has been read with parameter “stringsAsFactors = FALSE”. Walking through that data set, the variables whose names contain “mean” or “std” are kept and their special characters are removed. Other variables are dropped, this leads to the tidy data set “test_train_set.txt”. This data set has 10299 observations of 90 variables.

A summary table is finally created with the average of each variable for each activity and each subject.
