#README

Hello,my friends! This is an introduction...

this repository include coursera course: Getting and cleaning data project.

#####The course project introduction

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

[Human activity recognition using smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here are the data for the project:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

You should create one R script called run_analysis.R that does the following.

##Problem Solution

1. Loading data by `read.table()`,merges the training and the test dataset separately using  `cbind()` and `rbind()` function.

2. Uses descriptive activity names to name each dataset column should use `names()` function,and by careful the first column and the last column name is not include in feature.txt. 

3. Extracts the mean and standard deviation for each measurements,you should use regular expression in `grep()` funciton.`grep()`function returns a Boolean vector.

4. Variables names have replicaton,so we need rename them, and let features are unique. `gsub(,,names())` function will help us to change column name.

5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject. We can use `dplyr` package solve the problem.%>% chain symbol simplify coding,The `group_by()` function organizes the dataset. calculating avarage of each variable by `summarize_each()` function.

I created one R secipt called run_analysis.R recorded my code information.				
CodeBook.md describes the variables, the data, and any transformations or work that I performed to clean up the data

Best wish!


    
