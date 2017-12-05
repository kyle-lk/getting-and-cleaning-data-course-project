##Getting and cleaning data  week4 --course project


## require nessary packages dplyr to workspace

if(!suppressWarnings(require(dplyr)))
{
   install.packages("dplyr")
   require(dplyr)
}

## Download and extract data from compressed zip file
if (!dir.exists("ProjectData"))
{
    dir.create("./ProjectData")
}

data_url_1 <- "https://d396qusza40orc.cloudfront.net/"
data_url_2 <- "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(paste(data_url_1,data_url_2,sep=""),destfile="./Dataset.zip")
unzip("./Dataset.zip",exdir="./ProjectData")
setwd("./ProjectData/UCI HAR Dataset")

## loading and glimpse datasets

      train_x <- read.table("./train/X_train.txt")
      train_y <- read.table("./train/y_train.txt")
train_subject <- read.table("./train/subject_train.txt")

      test_x  <- read.table("./test/X_test.txt")
	  test_y  <- read.table("./test/y_test.txt")
test_subject  <- read.table("./test/subject_test.txt")


## merges the training and the test sets 

train_all <- cbind(train_subject,train_y,train_x)
test_all  <- cbind(test_subject,test_y,test_x)
data_full <- rbind(train_all,test_all)

## we need ordering the train and the test data by subject number

data_full <- data_full[order(data_full[,1]),] 


## Extracts subdata on the mean and standard deviation for
## each measurement
## Be careful the difference between "mean()" and "meanFreq()"
 
        features <- read.table("./features.txt")		 
        features <- as.character(features[,2])
names(data_full) <- c("subject_ID","activity_ID",features)
         mean_sd <- grep(("mean\\(\\)|std\\(\\)"),names(data_full))
         mean_sd <- data_full[,mean_sd]
		 
## descript dataset column(avalible) by names,be careful column
## 303-344,382-423,461-502 are replicated.
## we need rename this column add x,y or z 
names(data_full)[305:318] <- gsub("\\(\\)-","\\(\\)-X,",names(data_full)[305:318])
names(data_full)[319:332] <- gsub("\\(\\)-","\\(\\)-Y,",names(data_full)[319:332])
names(data_full)[333:346] <- gsub("\\(\\)-","\\(\\)-Z,",names(data_full)[333:346])
names(data_full)[384:397] <- gsub("\\(\\)-","\\(\\)-X,",names(data_full)[384:397])
names(data_full)[398:411] <- gsub("\\(\\)-","\\(\\)-Y,",names(data_full)[398:411])
names(data_full)[412:425] <- gsub("\\(\\)-","\\(\\)-Z,",names(data_full)[412:425])
names(data_full)[463:476] <- gsub("\\(\\)-","\\(\\)-X,",names(data_full)[463:476])
names(data_full)[477:490] <- gsub("\\(\\)-","\\(\\)-Y,",names(data_full)[477:490])
names(data_full)[491:504] <- gsub("\\(\\)-","\\(\\)-Z,",names(data_full)[491:504])
 
## change the first column and the last column data class by as.factor

      activity_labels <- read.table("./activity_labels.txt")
data_full$subject_ID  <- as.factor(data_full$subject_ID)
data_full$activity_ID <- factor(data_full$activity_ID,levels=activity_labels[,1],
                                labels=activity_labels[,2])

								
## From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject								

sub_data <- data_full %>%
            group_by(subject_ID,activity_ID)%>%
			summarize_all(mean)
			
write.table(sub_data,"./sub_data.txt",row.names=FALSE)



































