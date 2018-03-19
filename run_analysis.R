## Coursera week 4 getting and cleaning data project

#library(downloader)
#library(plyr); library(dplyr)
#library(knitr)

# Set filenames and folders
fname_zip <- "HAR_projectfile.zip"
fname <- "HAR_projectfile"
folder_path <- file.path("./UCI")
path_name <- file.path(folder_path,"UCI HAR Dataset")

if(!file.exists(folder_path)){dir.create(folder_path)}


Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# Download file if required
if(!file.exists(file.path(folder_path,fname_zip))) {
 rc <- download.file(Url,destfile=file.path(folder_path,fname_zip),mode = "curl")
if (rc == 0) message("Download Complete") else { 
    message("Download failed",rc) 
    return() }                      
     }
# Unzip if needed
if(!file.exists(file.path(folder_path,fname))){    
    unzip(zipfile=file.path(folder_path,fname_zip),exdir=folder_path)
                        }


file_list<-list.files(path_name, recursive=TRUE)

if (length(file_list) == 0) { message("Folder ",folder_path," file count = 0 no files to process"); 
                            return() }

# read and combine rows for activity, subject, set names then create combined data frame
Activity <- rbind(read.table(file.path(path_name, "train/", "y_train.txt"),header = FALSE),
+                 read.table(file.path(path_name, "test/" , "y_test.txt" ),header = FALSE))
names(Activity)<- c("activity")

Subject <- rbind(read.table(file.path(path_name, "train/", "subject_train.txt"),header = FALSE),
+                read.table(file.path(path_name, "test/" , "subject_test.txt"),header = FALSE))
names(Subject)<-c("subject_ID")

# Combine  Subject/Activity columns

# Get features, combine rows, set names
Features <- rbind(read.table(file.path(path_name, "train", "X_train.txt"),header = FALSE),
+                 read.table(file.path(path_name, "test" , "X_test.txt" ),header = FALSE))
Feature_names <- read.table(file.path(path_name, "features.txt"),head=FALSE)[,2]
names(Features)<- Feature_names
#message(str(Activity),str(Subject),str(Features))
# create a single data frame with all subject,activity and features
data_comb <- cbind(Subject,Activity,Features)

## search for mean() and std()

Feature_name_list <- grepl("mean\\(\\) | std\\(\\)",Feature_names)


selectedNames<-c(as.character(Feature_name_list), "subject", "activity" )
data_comb<-subset(data_comb,select=selectedNames)

#message("combined data frame ",str(data_comb))

# read activity labels and 
act_label <- read.table(file.path(path_name, "activity_labels.txt"),header = FALSE)[,2]
data_comb$activity<-factor(data_comb$activity,labels=act_label)

# correct names
names(data_comb)<-gsub("^t", "Time", names(data_comb))
names(data_comb)<-gsub("^f", "Frequency", names(data_comb))
names(data_comb)<-gsub("BodyBody", "Body", names(data_comb))


data_final<-aggregate(. ~subject + activity, data_comb, mean)
data_final<-data_final[order(data_final$subject,data_final$activity),]
write.table(data_final, file = file.path(folder_path,"tidydata.txt"),row.name=FALSE, sep = ',')

