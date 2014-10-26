## Course project for Getting and Cleaning Data (getdata-008)

## The raw data must be unzipped to a folder named "data" in the working directory.
## File URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


# Requires the packages: dplyr, reshape2
library(dplyr)
library(reshape2)


## Read input data files
subject_train <- read.table("./data/train/subject_train.txt")
x_train <- read.table("./data/train/X_train.txt")
y_train <- read.table("./data/train/Y_train.txt")

subject_test <- read.table("./data/test/subject_test.txt")
x_test <- read.table("./data/test/X_test.txt")
y_test <- read.table("./data/test/Y_test.txt")

# Only second column is needed -- it contains the names of the features measured
features <- read.table("./data/features.txt", stringsAsFactors=FALSE)[,2]
# The activity labels dataframe is assigned column names for merging later on
activity_labels <- read.table("./data/activity_labels.txt", stringsAsFactors=FALSE, col.names=c("activity_id", "activity"))


## STEP 1: Join training and test datasets to form one dataset
train <- cbind(subject_train, x_train, y_train)
test <- cbind(subject_test, x_test, y_test)
data <- rbind(train, test)

 
## STEP 2: Extract only measurements on mean and standard deviation 
names(data) <- c("subject", features, "activity_id")
colNames <- names(data)
colNames <- colNames[(grepl("mean\\(\\)", colNames) | grepl("std", colNames) | grepl("subject", colNames) | grepl("activity", colNames)) == TRUE]
data <- data[, colNames]


## STEP 3: Add activity names to dataset by merging with activity_labels table
# Merge by activity_id
data <- merge(data, activity_labels, by="activity_id")
# Remove activity_id column as it is now redundant
data <- select(data, -activity_id)


## STEP 4: Make variable names more descriptive
# Make feature names easier to understand by spelling them out in full
colNames <- names(data)
# The prefix "t" denotes time domain
colNames <- gsub("^t", "time", colNames)
# The prefix "f" denotes frequency domain
colNames <- gsub("^f", "frequency", colNames)
# "Acc" denotes accelerometer
colNames <- gsub("Acc", "Accelerometer", colNames)
# "Gyro" denotes gyroscope
colNames <- gsub("Gyro", "Gyroscope", colNames)
# "Mag" denotes magnitude
colNames <- gsub("Mag", "Magnitude", colNames)
# Remove parentheses () from feature names
colNames <- gsub("\\(\\)", "", colNames)
# Replace names(data) with new descriptive names
names(data) <- colNames


## STEP 5: Create new dataset
# Melt, then cast the dataset to calculate the mean for each feature under each subject-activity combination 
data_melt <- melt(data, id=c("subject", "activity"))
data_cast <- dcast(data_melt, subject + activity ~ variable, mean)
data_final <- arrange(melt(data_cast, id=c("subject", "activity"), variable.name="feature", value.name="mean"), subject, activity, feature)


## Write dataset to file in working directory
write.table(data_final, file = "./data_tidy.txt", row.name=FALSE)
