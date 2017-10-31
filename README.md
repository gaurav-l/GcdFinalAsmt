---
title: "README"
output: html_document
---


# This README explains how the project scripts work and how they are connected

- The goal of the project is to use files(described in CodeBook.md), and transform the data contained into files based on the instructions provided 
- Refer to CodeBook.md (in this repo) for a description of the variables, the data, and any transformations or work that was performed to clean up the data
- The script file "run_analysis.R" is documented. Results of selected analysis during transformation process have been provided, as appropriate
- The input files should be present in the directory "/zip_file_data/UCI HAR Dataset" within the working directory
- Final data is available in "finalData.txt"

#  Data transformation process
1. Load libraries/packages
2. Read test and training data
3. Do basic analysis of rows, columns of data 
- Provided results of selected analysis in the code file, as appropriate
4. Merge training and test data
5. Name columns using names from "features"
6. Extract only measurements with std and mean
7. Use descriptive activity names to name the activities in the data set
- Appropriately label the data set with descriptive variable names
8. Create tidy data set 
- Use mean of each activity and subject
9. Final datais in the data frame "finalData"