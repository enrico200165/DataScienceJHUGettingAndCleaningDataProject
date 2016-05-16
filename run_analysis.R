# You should create one R script called run_analysis.R that does the following.
#   Merges the training and the test sets to create one data set.
#   Extracts only the measurements on the mean and standard deviation for each measurement.
#   Uses descriptive activity names to name the activities in the data set
#   Appropriately labels the data set with descriptive variable names.
#   From the data set in step 4, creates a second, independent tidy data set with the
#   average of each variable for each activity and each subject.


setup <- function(working_dir) {
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
        datadir <- "./data"
        if (!file.exists(datadir)) {
                dir.create(datadir)
                if (!file.exists(datadir)) {
                        message(paste("existing, failed creation of",datadir,
                                "work dir:",getwd()))
                        stop()
                }
        }
        
        
        zipfname  <- "./data/raw.zip"
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
                
        # we may have modified it setting the defaul, so return it
        working_dir
}



working_dir <-
        "V:/data/pers_dev/sources/R/jhu/get_clean_data/project/DataScienceJHUGettingAndCleaningDataProject"


setup(working_dir)
print("----------- fine -----------------")