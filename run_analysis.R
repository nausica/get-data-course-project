#' ---
#' title: "Human Activity Recognition Using Smartphones Data Set Cleaning"
#' output: tidy.txt
#' ---

library(plyr)

# Check if the data folder is there already, otherwise download the zip file
if("data"%in%dir()==FALSE) {
  fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile = "./dataset.zip", method="curl")
  unzip("./dataset.zip", exdir = "./data")
}

# Data files are under ./data/UCI HAR Dataset/
data_dir <- "./data/UCI HAR Dataset/" 
features_path <- paste(data_dir, "features.txt", sep = "")
activity_labels_path <- paste(data_dir, "activity_labels.txt", sep = "")
train_set_path <- paste(data_dir, "train/X_train.txt", sep = "")
train_labels_path <- paste(data_dir, "train/y_train.txt", sep = "")
train_subject_path <- paste(data_dir, "train/subject_train.txt", sep = "")
test_set_path <- paste(data_dir, "test/X_test.txt", sep = "")
test_labels_path <- paste(data_dir, "test/y_test.txt", sep = "")
test_subject_path <- paste(data_dir, "test/subject_test.txt", sep = "")

# Load data into corresponding variables
features <- read.table(features_path)[,2]
activity_labels <- read.table(activity_labels_path)

train_set <- read.table(train_set_path, col.names=features)
train_labels <- read.table(train_labels_path)
train_subjects <- read.table(train_subject_path)

test_set <- read.table(test_set_path, col.names=features)
test_labels <- read.table(test_labels_path)
test_subjects <- read.table(test_subject_path)

# Append labels and subjects data for both train and test sets
train_set$Activity.Label <- train_labels[,1]
train_set$Subject.Number <- train_subjects[,1]

test_set$Activity.Label <- test_labels[,1]
test_set$Subject.Number <- test_subjects[,1]

# Merge the training and the test sets
combined_set <- merge(train_set, test_set, all=TRUE)

# Select mean and standard deviation only
selected <- combined_set[,grep("\\.mean\\.|\\.std\\.|Activity.Label|Subject.Number", names(combined_set), value=TRUE)]

# Add descriptive activity names using activity labels
selected$Activity.Label <- factor(selected$Activity.Label)
levels(selected$Activity.Label) <- activity_labels[,2]

# Create a new data frame with averages
summary_data <- ddply(selected,c("Activity.Label", "Subject.Number"), colwise(mean))

# Save results in tidy.txt file
write.table(summary_data, "tidy.txt", row.name=FALSE )
