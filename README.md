Description
------------
Summarizes the [UCI Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and creates a tidy data set of averages of measures from the raw data.

Usage
------
The script runs in the unzipped folder downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

```
source('run_analysis.R')
```

This will:
* Merge the test set and the training set
* Extract 80 variables that are the mean and standard deviation for each measurement
* Group the experiments by human activity and volunteer
* Write to the file `tidy.csv`
