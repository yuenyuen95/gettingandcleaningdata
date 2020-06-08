## load necessary packages
library(dplyr)

## download dataset
filename <- "Coursera_DS3_Final.zip"

if(!file.exists(filename)){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, filename, method = "curl")
}

if(!file.exists("UCI HAR Dataset")){
        unzip(filename)
}

## assign data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "Functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("Code", "Activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$Functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "Code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$Functions) 
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "Code")

## combine training and test sets
set <- rbind(x_train, x_test)
label <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

## select feature columns with 'mean' or 'std' 
selected_col <- grep("-(mean|std)", as.character(features[,2]))
set <- set[selected_col]

## replace labels with descriptive activity names 
label$Code <- activity_labels[label$Code, 2]
colnames(label) <- "Activity"

## rename column names to make things more beautiful
new_colnames <- features[selected_col, 2]
new_colnames <- gsub("-mean()", "Mean", new_colnames, ignore.case = TRUE)
new_colnames <- gsub("-std()", "Std", new_colnames, ignore.case = TRUE)
new_colnames <- gsub("[-()]", "", new_colnames)
colnames(set) <- new_colnames

## put everything together
merged_data <- cbind(subject, label, set)

## convert variables Activity and Subject into factor
merged_data$Activity <- as.factor(merged_data$Activity)
merged_data$Subject <- as.factor(merged_data$Subject)

## create a second, independent tidy data set with the average of each variable for each activity and each subject
final <- merged_data %>%
        group_by(Subject, Activity) %>%
        summarise_all(funs(mean))
write.table(final, "final.txt", row.name=FALSE)