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
allRawData

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
        ensure.package("dplyr")
        # ensure.package("xlsx") just to test it


        # we may have modified it setting the defaul, so return it
        working_dir
}



if (is.null(allRawData)) {
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
rawDataSubSet  <- allRawData[, colsOfinterestidx]
# print(head(str(rawDataSubSet)))

# --- get the activities and add them to data
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

# make variable names more user friendly
names(rawDataSubSet) <- gsub("^t", "Time", names(rawDataSubSet))
names(rawDataSubSet) <- gsub("^f", "Frequency", names(rawDataSubSet))
names(rawDataSubSet) <- gsub("-mean\\(\\)", "Mean", names(rawDataSubSet))
names(rawDataSubSet) <- gsub("-std\\(\\)", "StdDev", names(rawDataSubSet))
names(rawDataSubSet) <- gsub("-", "", names(rawDataSubSet))
names(rawDataSubSet) <- gsub("BodyBody", "Body", names(rawDataSubSet))
print(names(rawDataSubSet))

## 
# Assumptions:
# setup() has been performed 
performanalysis <- function(allRawData) {
        
        ### move loading of data in here
}













#setup(working_dir)

# remove("allRawData")
#allRawData <- NULL
performanalysis()

# quick&dirty development tests
# readFileFromDataDir("train/X_train.txt")

print("----------- normal termination -----------")



