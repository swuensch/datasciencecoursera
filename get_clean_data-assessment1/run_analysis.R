# 0) download and unzip data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              "FUCI_HAR_Dataset.zip", "curl")
unzip("FUCI_HAR_Dataset.zip")

# 1) Merges the training and the test sets to create one data set.
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_all <- rbind(X_train, X_test)

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_all <- rbind(y_train, y_test)

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_all <- rbind(subject_train, subject_test)[, 1]

# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
dict <- read.table("UCI HAR Dataset/features.txt")[, 2]
col_filter <- grepl("mean", dict) | grepl("std", dict)

data <- X_all[, col_filter]

# 3) Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("id", "activity_name")

activity_all <- activity_labels[y_all$V1, "activity_name"]

# 4) Appropriately labels the data set with descriptive variable names. 
X_col_names <- gsub("\\(\\)", "", gsub("-", "_", dict[col_filter]))
colnames(data) <- c(X_col_names)

# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

t <- aggregate(data, list(activity_all, subject_all), mean)
write.table(t, "aggregated_data.txt", quote = FALSE, row.names = FALSE)
write.table(dict[col_filter], "data_dict.txt", quote = FALSE, col.names = FALSE)

