# read and prepare data
library(dplyr)

setwd("D:/Data Science Specialization/myR/cleaning/UCI HAR Dataset")
activity_labels = read.table("activity_labels.txt")
names(activity_labels) = c("activity_code", "activity_label")
list_of_all_features = read.table("features.txt", stringsAsFactors = FALSE)
names(list_of_all_features)=c("feature_code", "feature_label")

subjects_id_test = read.table("test/subject_test.txt")
names(subjects_id_test) = c("subject_id")
test_set = read.table("test/X_test.txt")
X_test = read.table("test/X_test.txt")
y_test = read.table("test/y_test.txt")
names(y_test)[1]="activity_code"
test_set = bind_cols(subjects_id_test, X_test, y_test)
test_set = mutate(test_set, category = "test")
subject_train = read.table("train/subject_train.txt")
names(subject_train)[1]="subject_id"
X_train = read.table("train/X_train.txt")
y_train = read.table("train/y_train.txt")
names(y_train)[1]="activity_code"
train_set = bind_cols(subject_train, X_train, y_train)
train_set = mutate(train_set, category = "train")
test_train_set = bind_rows(test_set, train_set)
if (!dir.exists("results"))
    dir.create("results")
functionalities = nrow(list_of_all_features)
tt = test_train_set
if (file.exists("results/test_train_set_raw_01.txt"))
    file.remove ("results/test_train_set_raw_01.txt")
file.create("results/test_train_set_raw_01.txt")
write.table(tt, "results/test_train_set_raw_01.txt")
coldropped = 0
length(coldropped) = 0
for(i in 1:functionalities)
{
    keep = grepl("mean", tolower(list_of_all_features[i,2])) || grepl("std", tolower(list_of_all_features[i,2]))
    if (keep)
        names(tt)[i+1] = gsub("[[:punct:]]", "_", list_of_all_features[i,2])
    else
    {
        length(coldropped) = length(coldropped) + 1
        coldropped[length(coldropped)] = paste("V", i, sep = "")
    }
}
if (file.exists("results/test_train_set_raw_02.txt"))
    file.remove ("results/test_train_set_raw_02.txt")
file.create("results/test_train_set_raw_02.txt")
write.table(tt, "results/test_train_set_raw_02.txt")
tt = tt [, ! names(tt) %in% coldropped, drop = F]
tt = merge(tt,activity_labels)
if (file.exists("results/test_train_set.txt"))
    file.remove ("results/test_train_set.txt")
file.create("results/test_train_set.txt")
write.table(tt, "results/test_train_set.txt", row.name=FALSE)
grouped_subject_activity = group_by(tt, subject_id, activity_label)
summary_table = summarise(grouped_subject_activity,
    mean(tBodyAcc_mean___X),mean(tBodyAcc_mean___Y),
    mean(tBodyAcc_mean___Z),mean(tBodyAcc_std___X),
    mean(tBodyAcc_std___Y),mean(tBodyAcc_std___Z),
    mean(tGravityAcc_mean___X),mean(tGravityAcc_mean___Y),
    mean(tGravityAcc_mean___Z),mean(tGravityAcc_std___X),
    mean(tGravityAcc_std___Y),mean(tGravityAcc_std___Z),
    mean(tBodyAccJerk_mean___X),mean(tBodyAccJerk_mean___Y),
    mean(tBodyAccJerk_mean___Z),mean(tBodyAccJerk_std___X),
    mean(tBodyAccJerk_std___Y),mean(tBodyAccJerk_std___Z),
    mean(tBodyGyro_mean___X),mean(tBodyGyro_mean___Y),
    mean(tBodyGyro_mean___Z),mean(tBodyGyro_std___X),
    mean(tBodyGyro_std___Y),mean(tBodyGyro_std___Z),
    mean(tBodyGyroJerk_mean___X),mean(tBodyGyroJerk_mean___Y),
    mean(tBodyGyroJerk_mean___Z),mean(tBodyGyroJerk_std___X),
    mean(tBodyGyroJerk_std___Y),mean(tBodyGyroJerk_std___Z),
    mean(tBodyAccMag_mean__),mean(tBodyAccMag_std__),
    mean(tGravityAccMag_mean__),mean(tGravityAccMag_std__),
    mean(tBodyAccJerkMag_mean__),mean(tBodyAccJerkMag_std__),
    mean(tBodyGyroMag_mean__),mean(tBodyGyroMag_std__),
    mean(tBodyGyroJerkMag_mean__),mean(tBodyGyroJerkMag_std__),
    mean(fBodyAcc_mean___X),mean(fBodyAcc_mean___Y),
    mean(fBodyAcc_mean___Z),mean(fBodyAcc_std___X),
    mean(fBodyAcc_std___Y),mean(fBodyAcc_std___Z),
    mean(fBodyAcc_meanFreq___X),mean(fBodyAcc_meanFreq___Y),
    mean(fBodyAcc_meanFreq___Z),mean(fBodyAccJerk_mean___X),
    mean(fBodyAccJerk_mean___Y),mean(fBodyAccJerk_mean___Z),
    mean(fBodyAccJerk_std___X),mean(fBodyAccJerk_std___Y),
    mean(fBodyAccJerk_std___Z),mean(fBodyAccJerk_meanFreq___X),
    mean(fBodyAccJerk_meanFreq___Y),mean(fBodyAccJerk_meanFreq___Z),
    mean(fBodyGyro_mean___X),mean(fBodyGyro_mean___Y),
    mean(fBodyGyro_mean___Z),mean(fBodyGyro_std___X),
    mean(fBodyGyro_std___Y),mean(fBodyGyro_std___Z),
    mean(fBodyGyro_meanFreq___X),mean(fBodyGyro_meanFreq___Y),
    mean(fBodyGyro_meanFreq___Z),mean(fBodyAccMag_mean__),
    mean(fBodyAccMag_std__),mean(fBodyAccMag_meanFreq__),
    mean(fBodyBodyAccJerkMag_mean__),mean(fBodyBodyAccJerkMag_std__),
    mean(fBodyBodyAccJerkMag_meanFreq__),mean(fBodyBodyGyroMag_mean__),
    mean(fBodyBodyGyroMag_std__),mean(fBodyBodyGyroMag_meanFreq__),
    mean(fBodyBodyGyroJerkMag_mean__),mean(fBodyBodyGyroJerkMag_std__),
    mean(fBodyBodyGyroJerkMag_meanFreq__),mean(angle_tBodyAccMean_gravity_),
    mean(angle_tBodyAccJerkMean__gravityMean_),mean(angle_tBodyGyroMean_gravityMean_),
    mean(angle_tBodyGyroJerkMean_gravityMean_),mean(angle_X_gravityMean_),
    mean(angle_Y_gravityMean_),mean(angle_Z_gravityMean_))
if (file.exists("results/summary_table.txt"))
    file.remove ("results/summary_table.txt")
file.create("results/summary_table.txt")
write.table(summary_table, "results/summary_table.txt")
