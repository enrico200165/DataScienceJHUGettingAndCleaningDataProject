# Objectives
To demonstrate your ability to collect, work with, and clean a data set by producing a tidy data set starting from an untidy data set.

The originary data for the untidy data set and descriptions of the data are available at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

the data actually used for this task are available at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Deliverables
As requested by the assignment the deliverables are:

* a **tidy data set**  
available in file: [HumanActivityRecognitionUsingSmartphonesDataSet_tidy.txt](https://github.com/enrico200165/DataScienceJHUGettingAndCleaningDataProject/blob/master/data/HumanActivityRecognitionUsingSmartphonesDataSet_tidy.txt)  
read it inside R with read.table("HumanActivityRecognitionUsingSmartphonesDataSet_tidy.txt", header = TRUE)
* **a code book** called **[CodeBook.md](https://github.com/enrico200165/DataScienceJHUGettingAndCleaningDataProject/blob/master/CodeBook.md)**  
that describes the variables, the data, and any transformations or work that you performed to clean up the data
* this **README.md** file
* one **R script** called **[run_analysis.R](https://github.com/enrico200165/DataScienceJHUGettingAndCleaningDataProject/blob/master/run_analysis.R)** that does the following:

    - Merges the training and the test sets to create one data set.
    - Extracts only the measurements on the mean and standard deviation for each measurement.
    - Uses descriptive activity names to name the activities in the data set
    - Appropriately labels the data set with descriptive variable names.
    - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

 






