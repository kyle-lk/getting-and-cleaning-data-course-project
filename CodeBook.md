#CodeBook

This is a part of getting and cleaning data course project, descript my coding information.

This dataset has total 563 variables and 10,299 observations. and have been separeted to two part:train dataset and test dataset. we need merge two dataset to full dataset. rearrange,clean and rename data.

As course project declared:
  1. we need merge dataset to one dataset(include suject information,activity information and all measurement);
  2. extracts specific variables column;
  3. Rename acticity column each observation by activty names;
  4. because the features names have replication,miss the X/Y/Z description,so we need rename some variables;
  5. lastly, we want summarize measurement data by `group_by()` function and `dplyr` packages 

###The Brief Introduction

####1. loading and merge data
first, we need to load necessary packages `dplyr`:

	if (!suppressWarnings(require(dplyr)))
	{

	   install.packages("dplyr")

	   require(dplyr)
	}
these code format can help you can help you automatically check whether the package is installed, if it is installed to load it.

Then ,we need download our dataset and unzip the dataset to our determined directory

	if (!dir.exists("ProjectData"))
	{
	    dir.create("./ProjectData")
	}
create a specific directory stored dataset and coding information

	data_url_1 <- "https://d396qusza40orc.cloudfront.net/"
	data_url_2 <- "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(paste(data_url_1,data_url_2,sep=""),destfile="./Dataset.zip")
In order to clean the code, the address can be stored separately

	unzip("./Dataset.zip",exdir="./ProjectData")
	setwd("./ProjectData/UCI HAR Dataset")
`read.table()` can help you load `.txt` dataset files

	      train_x <- read.table("./train/X_train.txt")
		  train_y <- read.table("./train/y_train.txt")
	train_subject <- read.table("./train/subject_train.txt")

	      test_x  <- read.table("./test/X_test.txt")
		  test_y  <- read.table("./test/y_test.txt")
	test_subject  <- read.table("./test/subject_test.txt")
`cbind()`,`rbind()` function can merge data by column or row

	train_all <- cbind(train_subject,train_y,train_x)
	test_all  <- cbind(test_subject,test_y,test_x)
	data_full <- rbind(train_all,test_all)
Now, we finished the first task. but `data_full` stored data are not ordered,we should rank `subject` variable:

####2.Rename and extract subset data

	data_full <- data_full[order(data_full[,1]),] 
Names `data_full` each variables by `names()` function and `features.txt`description:

	        features <- read.table("./features.txt")		 
	        features <- as.character(features[,2])
	names(data_full) <- c("subject_ID","activity_ID",features)
Extracts subset data by `grep()`function:
         mean_sd <- grep(("mean\\(\\)|std\\(\\)"),names(data_full))
         mean_sd <- data_full[,mean_sd]
 
####3.Cleaning data
If you used `unique()`function to view dataset,you may have noticed duplicate data,this duplicate is due to the wrong name of varibles.We can track the location of the variable name where the error occurred,and rename variables by X,Y,Z respectively,`gsub()`function and regular expression used to replace variable names

	names(data_full)[305:318] <- gsub("\\(\\)-","\\(\\)-X,",names(data_full)[305:318])
	names(data_full)[319:332] <- gsub("\\(\\)-","\\(\\)-Y,",names(data_full)[319:332])
	names(data_full)[333:346] <- gsub("\\(\\)-","\\(\\)-Z,",names(data_full)[333:346])
	names(data_full)[384:397] <- gsub("\\(\\)-","\\(\\)-X,",names(data_full)[384:397])
	names(data_full)[398:411] <- gsub("\\(\\)-","\\(\\)-Y,",names(data_full)[398:411])
	names(data_full)[412:425] <- gsub("\\(\\)-","\\(\\)-Z,",names(data_full)[412:425])
	names(data_full)[463:476] <- gsub("\\(\\)-","\\(\\)-X,",names(data_full)[463:476])
	names(data_full)[477:490] <- gsub("\\(\\)-","\\(\\)-Y,",names(data_full)[477:490])
	names(data_full)[491:504] <- gsub("\\(\\)-","\\(\\)-Z,",names(data_full)[491:504])

####4.Descript activity names
subject desctiption infromation stored at `activity_lables.txt`,In order to facilitate the back of the analysis,we change subject and activity variables to `factor`
          activity_labels <- read.table("./activity_labels.txt")
	data_full$subject_ID  <- as.factor(data_full$subject_ID)	
	data_full$activity_ID <- factor(data_full$activity_ID,levels=activity_labels[,1],
                                labels=activity_labels[,2])
####5. summary data by `mean`
we used `dplyr`package function `summarize_all()`,`group_by` to finish this task

	sub_data <- data_full %>%
            group_by(subject_ID,activity_ID)%>%
			summarize_all(mean)
			
	write.table(sub_data,"./sub_data.txt",row.names=FALSE)



