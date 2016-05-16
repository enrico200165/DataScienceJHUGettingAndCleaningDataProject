## 
# You should create one R script called run_analysis.R that does the following.
#   Merges the training and the test sets to create one data set.
#   Extracts only the measurements on the mean and standard deviation for each measurement.
#   Uses descriptive activity names to name the activities in the data set
#   Appropriately labels the data set with descriptive variable names.
#   From the data set in step 4, creates a second, independent tidy data set with the
#   average of each variable for each activity and each subject.
#
#
## Main tidy data goals
## 1. each variable should be in one column
## 2. each observation of that variable should be in a diferent row
## ...

## === PSEUDO CONSTANTS ========================================================
#  --- ( data used in more than one function )
datadir <- "./data"
tidyfname <- "HumanActivityRecognitionUsingSmartphonesDataSet_tidy.txt"

# ------------------------------------------------------------------------------


## === UTILITY FUNCTIONS =======================================================

## install and load a package if needed
ensure.package <- function(pkgname) {
        if (!(pkgname %in% rownames(installed.packages()))) {
                print(paste("installing missing package",pkgname))
                install.packages(pkgname)
        }
        library(pkgname,character.only=TRUE)
}

## shorthand to read relative from dir: <datadir>/UCI HAR Dataset/
# params
# fpath: subpath and filename
readFileFromDataDir <- function(fpath) {
        fullpath <- file.path(datadir,"UCI HAR Dataset",fpath)
        #print(paste("reading", fullpath))
        read.table(fullpath)
}



## performs all needed set ups:
# - download and unpack raw data if not present
# - install packages if needed
setup <- function(working_dir) {

        working_dir <-
                "V:/data/pers_dev/sources/R/jhu/get_clean_data/project/DataScienceJHUGettingAndCleaningDataProject"
        zipfname  <- "./data/raw.zip"
        
        
        if (missing(working_dir)) {
                # validate parameters, if not provided, set drive independent default
                warning("working dir not provided, setting default")
                working_dir <- "/getcleandata"
        }
        
        if (!file.exists(working_dir)) {
                warning(paste(
                        "working dir does not exist, trying to create it:",
                        working_dir
                ))
                dir.create(working_dir)
                if (!file.exists(working_dir)) {
                        warning(
                                paste(
                                        "Exiting, unable to create non existing working dir:",
                                        working_dir,
                                        "\ncurrent working dir:",
                                        getwd()
                                )
                        )
                        stop()
                }
        }
        
        # here we are sure (well reasonably sure :-) we have a wd
        setwd(working_dir)
        print(paste("working dir:", getwd()))
        
        # let's manage data dir and raw data, it's an exercise so let's skip 
        # some paranoid checks  ex. successful dir creation etc.
        if (!file.exists(datadir)) {
                dir.create(datadir)
                if (!file.exists(datadir)) {
                        message(paste("existing, failed creation of",datadir,
                                "work dir:",getwd()))
                        stop()
                }
        }
        
        if (!file.exists(zipfname)) {
                url <-
                        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(url, destfile = zipfname, method = "curl")
        } else {
                print(paste("no download, already exists zip file: ",zipfname))
        }
        
        if (!file.exists("./data/UCI HAR Dataset")) {
                print(paste("unzipping",getwd()))
                unzip(zipfile=zipfname,exdir="./data")
        } else {
                print(paste("not unzipping, unzipped data seem to exist"))
        }
      
        
        # --- packages ---
        # ensure.package("xlsx") just to test it
        ensure.package("plyr")
        ensure.package("dplyr")
        ensure.package("knitr") # not sure if I will use it from here or at all

        # we may have modified it setting the defaul, so return it
        working_dir
}


## ============================= MAIN CODE ====================================
# global because I am in a hurry, one day late

setup()

if (!exists("allRawData")) {
        print(paste("loading raw data"))
        allRawData <- rbind(readFileFromDataDir("test/X_test.txt")
                           ,readFileFromDataDir("train/X_train.txt"))
        # print(paste(nrow(allRawData)))
}

if (nrow(allRawData) != 10299) {
        warn(paste(nrow(allRawData),"unexpected nr of rows in raw data, expected",10299))
        stop()
}


rawVariableNames <- readFileFromDataDir("features.txt")[, 2]
#print(head(rawVariableNames))

# set raw variables names on raw data
names(allRawData) <- rawVariableNames
# print(head(allRawData))


# subset columns to those containing mean and standard deviations
#   get indexes of means and stds
colsOfinterestidx <- grep("(mean|std)\\(\\)", names(allRawData))
# print(colsOfinterestidx)
# subset to mean and stds columns
rawDataColSubSet  <- allRawData[, colsOfinterestidx]
# print(head(str(rawDataColSubSet)))

# --- process activities
# Use descriptive activity names to name the activities in the data set.
# Get the activity data and map to nicer names:
activities <- rbind(readFileFromDataDir("test/y_test.txt"),
        readFileFromDataDir("train/y_train.txt"))
#print(nrow(activities))
activities <- activities[, 1]
activityNames <-
        c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")
activities <- activityNames[activities]
# print(activities)

# --- make variable names more user friendly ---
names(rawDataColSubSet) <- gsub("^t", "Time", names(rawDataColSubSet))
names(rawDataColSubSet) <- gsub("^f", "Frequency", names(rawDataColSubSet))
names(rawDataColSubSet) <- gsub("-mean\\(\\)", "Mean", names(rawDataColSubSet))
names(rawDataColSubSet) <- gsub("-std\\(\\)", "StdDev", names(rawDataColSubSet))
names(rawDataColSubSet) <- gsub("-", "", names(rawDataColSubSet))
names(rawDataColSubSet) <- gsub("BodyBody", "Body", names(rawDataColSubSet))
# print(names(rawDataColSubSet))


# --- process subjects ---
subjects <-  rbind(readFileFromDataDir("test/subject_test.txt"),
                   readFileFromDataDir("train/subject_train.txt"))
subjects <- subjects[, 1]
# print(length(subjects))

partlyTidy <- cbind(Subject = subjects, Activity = activities, rawDataColSubSet)
# print(head(partlyTidy)[1:3])

# --- finally build tidy data set
mymeans <- function(df) { colMeans(df[,-c(1,2)]) }
tidy <- ddply(partlyTidy, .(Subject, Activity), mymeans)
# print(tidy[1:5])
# prepend Mean to var names, except first 2, Subject, Activity
names(tidy)[-c(1,2)] <- paste0("Mean", names(tidy)[-c(1,2)])
#print(head(tidy[1:5]))


# --- write it ---
write.table(tidy,file.path(datadir,tidyfname), row.names = FALSE)

print("----------- normal termination -----------")

# return tidy df
tidy


