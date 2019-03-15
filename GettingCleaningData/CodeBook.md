## CodeBook for Getting and Cleaning Data course project 

### Data and file structure
The files contained herein were generated as part of the course project for Coursera course "Getting and cleaning data". 
The presentation of these data and relevant analyses are solely for the purposes of this coursework, and implies no ownership or responsibility for their use. 

The data for this project comes from the open source "Human Activity Recognition Using Smartphones Dataset, Version 1.0" (see below for details and citation).

To download the data, load the "run_analysis.R" script. Of note, please change the file path on line 19 to your desired local working directory.

Running this script will download a .zip file and unzip these to the working directory specified. This will create a folder named "UCI HAR Dataset".
Inside this folder are the following folders/files:
- README.txt - contains details about the dataset, and how it was generated.
- features.txt - lists the 561 variables contained in the original data.
- features_info.txt - provides detail for what these variables represent.
- activity_labels.txt - lists the 6 different activities that were measured.
- test (folder) - contains 'test' portion of the data (9 of 30 participants)
- train (folder) - contains 'training' portion of the data (21 of 30 participants)

These data are related to the data in the subfolders as follows (same for each of test/train):
- the feature data corresponds to the statistics calculated off of the raw inertia (x/y/z-axis) data
- features.txt has the variable names (a single column with one variable name per row), dim 1x561 
- train/X_train.txt has the calculated statistics, with columns corresponding with the features and rows as observations, dim 561x2947
- train/Y_train.txt has the performed activity (1-6), with type corresponding to values in activity_labels.txt
- the folder "Inertial Signals" contains the raw X-, Y-, and Z- axis data that informed the calculated data above.

### Code description
The "run_analysis.R" script performs the following tasks:

Part 1:
- Reads in and merges the data from the files in the test/train folders.
- Label the variables with their features names.
- Combines the training and test data to a single dataset.

Part 2:
- Reduces the dataset to only the columns that contain mean or standard deviation measurements.
  NOTE: this includes only the columns for "Mean values", not the columns for "mean frequency";
        to include the latter, you can remove the '\\()' portion of the the grepl call (line 90).

Part 3: 
- Labels the data with activity names (instead of numeric codes).

Part 4: 
- (The coursera instructions were to add descriptive variable names, but this was already performed in Part 1 above).

Part 5: 
- Generate a dataset containing the mean value of each variable for each combination of participant and activity.
- Export this dataset to your working directory, named "Overall_means.txt"

## Citation for data

All rights remain with the original generator of these data, as follows: 

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.