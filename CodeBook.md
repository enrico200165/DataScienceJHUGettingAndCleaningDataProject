# Code Book

## Entities
**Subject**: the people involved in the experiment, they carried a smartphone collecting data
identified via numeric ID  
**Activity**: The six activities performed by the subjects, they were:

  + Walking
  + Walking Upstairs
  + Walking Downstairs
  + Sitting
  + Standing
  + Laying


## The Raw Data
The originary data for the untidy data set and descriptions of the data are available at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

the data actually used for this task are available at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Raw Data Codebook
A description of the data is available, along with the data themselves, at the address provided above, so it will not be replicated here

### Raw Data Complementary Info
The data are spread in several files. An info about the raw data that is not explicit in the original documentation is that very often the corrispondence/join between the data spread across files is given by the position of the rows in the files, ie. observation at row N in one file should be joined to observation N in another file.


## Transformations Performed To Produce The New (Tidy) Data Set
All transformations performed "in memory" except when otherwise specified

* Downloaded and unzipped originary data from within R script, URL provided in previous sections
* Joined the two originary data sets into one data frame
* Added variable names from file features.txt
* Subsetted, leaving only columns containing means and standard deviations, identified by 
substrings mean() and std() in variable names
* Read activities into memory from files "test/y_test.txt" and "train/y_train.txt"
  * replaced activity IDs  with readable activity names from file activity_labels.txt
* Changed names of variables of main data set into new more readable names via simple text substitutions
* Read subjects in memory, into a single object, from files "test/subject_test.txt" and "train/subject_train.txt"
* Joined Subjects, Activities and subsetted measures data frame, via cbind() given that the originary data frame implemented join implictly, by line position (number)
* Calculated the means and produced final tidy dataframe
* Wrote data frame to file <work dir>/data/HumanActivityRecognitionUsingSmartphonesDataSet_tidy.txt

## The Tidy Data
The tidy data set contains **means**, by Subject and Activity, of the variables of the standard data set that contained means and standard deviations.  
The variables are 68;  
* the first two variables are dimensions (subject and activity)  
* the other 66 are the means, for the combination of subject and activity contained in the first two variables, of the variables subsetted from the originary data set.


### Detailed List of Measure Variables in The Tidy Data

All the variables are means hence they are all prefixed with "Mean"" in the variable name. 
The values are floating point numbers.

 - Time domain body acceleration mean along X, Y, and Z:
  - MeanTimeBodyAccMeanX
  - MeanTimeBodyAccMeanY
  - MeanTimeBodyAccMeanZ
 - Time domain body acceleration standard deviation along X, Y, and Z:
  - MeanTimeBodyAccStdDevX
  - MeanTimeBodyAccStdDevY
  - MeanTimeBodyAccStdDevZ
 - Time domain gravity acceleration mean along X, Y, and Z:
  - MeanTimeGravityAccMeanX
  - MeanTimeGravityAccMeanY
  - MeanTimeGravityAccMeanZ
 - Time domain gravity acceleration standard deviation along X, Y, and Z:
  - MeanTimeGravityAccStdDevX
  - MeanTimeGravityAccStdDevY
  - MeanTimeGravityAccStdDevZ
 - Time domain body jerk mean along X, Y, and Z:
  - MeanTimeBodyAccJerkMeanX
  - MeanTimeBodyAccJerkMeanY
  - MeanTimeBodyAccJerkMeanZ
 - Time domain body jerk standard deviation along X, Y, and Z:
  - MeanTimeBodyAccJerkStdDevX
  - MeanTimeBodyAccJerkStdDevY
  - MeanTimeBodyAccJerkStdDevZ
 - Time domain gyroscope mean along X, Y, and Z:
  - MeanTimeBodyGyroMeanX
  - MeanTimeBodyGyroMeanY
  - MeanTimeBodyGyroMeanZ
 - Time domain gyroscope standard deviation along X, Y, and Z:
  - MeanTimeBodyGyroStdDevX
  - MeanTimeBodyGyroStdDevY
  - MeanTimeBodyGyroStdDevZ
 - Time domain gyroscope jerk mean along X, Y, and Z:
  - MeanTimeBodyGyroJerkMeanX
  - MeanTimeBodyGyroJerkMeanY
  - MeanTimeBodyGyroJerkMeanZ
 - Time domain gyroscope jerk standard deviation along X, Y, and Z:
  - MeanTimeBodyGyroJerkStdDevX
  - MeanTimeBodyGyroJerkStdDevY
  - MeanTimeBodyGyroJerkStdDevZ
 - Time domain body acceleration magnitude mean:
  - MeanTimeBodyAccMagMean
 - Time domain body acceleration magnitude standard deviation:
  - MeanTimeBodyAccMagStdDev
 - Time domain gravity acceleration magnitude mean:
  - MeanTimeGravityAccMagMean
 - Time domain gravity acceleration magnitude standard deviation:
  - MeanTimeGravityAccMagStdDev
 - Time domain body jerk magnitude mean:
  - MeanTimeBodyAccJerkMagMean
 - Time domain body jerk magnitude standard deviation:
  - MeanTimeBodyAccJerkMagStdDev
 - Time domain gyroscope magnitude mean:
  - MeanTimeBodyGyroMagMean
 - Time domain gyroscope magnitude standard deviation:
  - MeanTimeBodyGyroMagStdDev
 - Time domain gyroscope jerk magnitude mean:
  - MeanTimeBodyGyroJerkMagMean
 - Time domain gyroscope jerk magnitude standard deviation:
  - MeanTimeBodyGyroJerkMagStdDev
 - Frequency domain body acceleration mean along X, Y, and Z:
  - MeanFrequencyBodyAccMeanX
  - MeanFrequencyBodyAccMeanY
  - MeanFrequencyBodyAccMeanZ
 - Frequency domain body acceleration standard deviation along X, Y, and Z:
  - MeanFrequencyBodyAccStdDevX
  - MeanFrequencyBodyAccStdDevY
  - MeanFrequencyBodyAccStdDevZ
 - Frequency domain body jerk mean along X, Y, and Z:
  - MeanFrequencyBodyAccJerkMeanX
  - MeanFrequencyBodyAccJerkMeanY
  - MeanFrequencyBodyAccJerkMeanZ
 - Frequency domain body jerk standard deviation along X, Y, and Z:
  - MeanFrequencyBodyAccJerkStdDevX
  - MeanFrequencyBodyAccJerkStdDevY
  - MeanFrequencyBodyAccJerkStdDevZ
 - Frequency domain gyroscope mean along X, Y, and Z:
  - MeanFrequencyBodyGyroMeanX
  - MeanFrequencyBodyGyroMeanY
  - MeanFrequencyBodyGyroMeanZ
 - Frequency domain gyroscope standard deviation along X, Y, and Z:
  - MeanFrequencyBodyGyroStdDevX
  - MeanFrequencyBodyGyroStdDevY
  - MeanFrequencyBodyGyroStdDevZ
 - Frequency domain body acceleration magnitude mean:
  - MeanFrequencyBodyAccMagMean
 - Frequency domain body acceleration magnitude standard deviation:
  - MeanFrequencyBodyAccMagStdDev
 - Frequency domain body jerk magnitude mean:
  - MeanFrequencyBodyAccJerkMagMean
 - Frequency domain body jerk magnitude standard deviation:
  - MeanFrequencyBodyAccJerkMagStdDev
 - Frequency domain gyroscope magnitude mean:
  - MeanFrequencyBodyGyroMagMean
 - Frequency domain gyroscope magnitude standard deviation:
  - MeanFrequencyBodyGyroMagStdDev
 - Frequency domain gyroscope jerk magnitude mean:
  - MeanFrequencyBodyGyroJerkMagMean
 - Frequency domain gyroscope jerk magnitude standard deviation:
  - MeanFrequencyBodyGyroJerkMagStdDev
