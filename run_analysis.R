# Load libraries/packages
library(data.table)


# Load all data

## Load and unzip data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = paste(trimws(getwd()), '/Week4AsmtData.zip', sep = ""))
unzip("Week4AsmtData.zip",exdir = "zip_file_data")    #unzip file

## Load common data
featuresData <- read.table("./zip_file_data/UCI HAR Dataset/features.txt")[,2]
activityLabelsData <- read.table("./zip_file_data/UCI HAR Dataset/activity_labels.txt")


### NROW(featuresData)
### [1] 561

## Load test data
xTestData <- read.table("./zip_file_data/UCI HAR Dataset/test/x_test.txt")
yTestData <- read.table("./zip_file_data/UCI HAR Dataset/test/y_test.txt")
ySubjectTestData <- read.table("./zip_file_data/UCI HAR Dataset/test/subject_test.txt")

### > NROW(xTestData)
### [1] 2947
### > NCOL(xTestData)
### [1] 561

### table(yTestData)
### yTestData
### 1   2   3   4   5   6 
### 496 471 420 491 532 537 
### table(ySubjectTestData)
### ySubjectTestData
### 2   4   9  10  12  13  18  20  24 
### 302 317 288 294 320 327 364 354 381

### The data has same # of rows
### > NROW(xTestData)
### [1] 2947
### > NROW(yTestData)
### [1] 2947
### > NROW(ySubjectTestData)
### [1] 2947

## Load training data
xTrainingData <- read.table("./zip_file_data/UCI HAR Dataset/train/x_train.txt")
yTrainingData <- read.table("./zip_file_data/UCI HAR Dataset/train/y_train.txt")
ySubjectTrainingData <- read.table("./zip_file_data/UCI HAR Dataset/train/subject_train.txt")


# Extract measurements with std dev and mean, using grep 

## Find features with std and mean
stdAndMeanFeatures <- grep("mean|std", featuresData)

## Name columns in test and training data using features
names(xTestData) <- featuresData
names(xTrainingData) <- featuresData

### > dim(xTestData)
### [1] 2947  561

## Get features with std and mean
xTestData <- xTestData[, stdAndMeanFeatures]
xTrainingData <- xTrainingData[, stdAndMeanFeatures]


### >dim(xTestData)
### [1] 2947   79
### >dim(xTrainingData)
### [1] 7352   79



# Merge training and test data

## name columns of test data
names(ySubjectTestData) = "Subject"
names(yTestData) = "Activity"

## name columns of training data
names(ySubjectTrainingData) = "Subject"
names(yTrainingData) = "Activity"



## merge columns of training and test data
mergedTestData <- cbind(xTestData, yTestData, ySubjectTestData)
mergedTrainingData <- cbind(xTrainingData, yTrainingData, ySubjectTrainingData)

### > dim(mergedTestData)
### [1] 2947   81

### > dim(mergedTrainingData)
### [1] 7352   81

## merge rows of training and test data
combinedData <- rbind(mergedTestData, mergedTrainingData) 

### > dim(combinedData)
### [1] 10299    81



# Appropriately label the data set with descriptive variable names

## Remove special characters from column names 
newNames <- gsub("[[:punct:]]", "", names(combinedData))

names(combinedData) <- newNames

## Add column for activity label
names(activityLabelsData) = c("Activity","ActivityLabel")


##  Populate the new column with activity label
combinedData <- merge(combinedData, activityLabelsData, by = "Activity")
##  Rename the new column descriptively 


# Create tidy data set 
##  Use mean of each activity and subject
finalData <- aggregate(x = combinedData, by = list(combinedData$Activity, combinedData$Subject), FUN = "mean")

### > dim(finalData)
### [1] 180  84



# Write tidy data set on a text file 
write.table(finalData, file = "./finalData.txt")
