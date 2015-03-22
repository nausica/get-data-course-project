
# CodeBook
This document describes the variables, the data, and any transformations or work that I have performed to clean up the data for the Human Activity Recognition Using Smartphones Data Set.

## Getting Started

### Step 1. Dowload data
Check if the data folder is there already, otherwise it downloads the zip file and unzip it under the /data folder.

### Step 2. Create path variables
Data files are under ./data/UCI HAR Dataset/. During this step I store in variables the paths of the files I'll be using.

### Step 3. Load data
Load data into the corresponding variables: *train_set*, *train_labels*, *train_subjects*, *test_set*, *test_labels*, *test_subjects*

### Step 4. Add activity labels and subject numbers
Add two new columns: activity labels and subjects number for both train and test sets.

### Step 5. Merge data sets
 Merge the training and the test sets and store in *combined_set* variable.

### Step 6. Select columns
Select mean and standard deviation columns and store it in *selected* variable. All columns containing .mean. or .std. in their names, plus the added columns in step 4.

### Step 7. Replace activity number by textual name
Add descriptive activity names using the activity labels contained in the file activity_labels.txt

### Step 8. Summarize
Create a new data frame with averages of each column per activity and subject using ddply with the colwise option and store it in the variable *summary_data*

### Step 9. Save results
Save results in tidy.txt file

A full description of the columns in the output file is available at the site where the data was obtained. Refer to data documentation at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

