# Get-and-clean-data-Coursera-Exercise


# Getting and Cleaning Data - Coursera Project Week 4

## Source file is located in run_analysis.R. The following describes the script steps. 

###Step 1: 
###Create folder and download file 

For the project local files, Create folder /UCI where all data will be stored and retrived
If the Samsung fitness activity file needs to be downloaded, the zip file will downloaded and stored in /UCI foler and unzipped. If a local version of the file is found, no download will take place. 
Verify the downloaded file and folder information. Exit if files are not found or not valid.  

###Step 2
####Read the Activity,Subject and Features testing and training files into data frames. 
Combine the training and the test rows for the Activity,Subject and Features data frames. 

The following files were used:

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all 561 features.

- 'activity_labels.txt': Links the 6 class labels with their activity name.

From the Test or Train Folder
- 'test/train/X_train.txt': Test/Training set with 1029 observations in the combined data frames for 30 subject IDs.  

- 'test/train/y_train.txt': Test/Training labels.

- 'train/subject_train.txt': Each row identifies the 30 subject IDs (1-30) who performed the activity for each window sample. 

###Step 3
###Create one combined data frame
Combine Activity,Subject and Features columns to form one data frame. 
Filter and select the mean and standard deviation by selecting columns with mean or std labels. 

Subset Name of Features by measurements on the mean and standard deviation.
###Step 4 Apply corrected feature names
Subset the data frame Data by selected names of Features.

Correctly label the data frame names. 

Calculate the mean of each variable for each subject and activity pair.
###Step 5
###Output of new file
Final output file is comma-separated file: tidydata.txt in folder /UCI. Fields are documented in the code book. 

