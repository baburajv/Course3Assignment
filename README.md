# Course3Assignment
Getting and Cleaning Data Course Assignment
----------------------------------------

The repo contains scripts, output, codebook and readme for the Assignment

The input data for script, run_analysis.R is available in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Download and extract the contents of the file mentioned above to "UCI HAR Dataset" folder in R working directory. The run_analysis.R in the repo
also should be downloaded to the R woking directory. The output of run_analysis.R is output.txt, (the tidy dataset as per the assignment req), will
be generated in R working directory.

input data:
-----------
The input has training and test data. Data X has sensor data collected from waist-mounted smartphones of 30 individuals and data Y shows the 
activity performed by the individuals during the monitoring.
 
requirement:
------------
combine training and testing data into one data set and extract the data corresponding to mean and standard deviation for each measurement. 
The new dataset should  have descriptive column names and activity names. Create a tidy data set with the average of each variable for each
activity and each subject.

script:
--------

a) load X,Y and subject data for training and test into separate data sets
b) load feature and activity sets into separate data sets.
c) use rbind() to merge X,Y and subject data for training and test data sets. 

d) from variable_names data set, find the indices of variables that has naming pattern mean() and store it in mean_variables_index. (grep command is used)
e) from variable_names data set, find the indices of variables that has naming pattern std() and store it in std_variables_index (grep command is used)
e) combine the two variables, mean_variables_index and std_variables_index into one. This variable, mean_and_std_variables_index, 
   will have all the indices corresponding to variables named mean() and std().(append command is used)
   
f) from the merged X data set, extract only the measurements correspondint to mean()and standard deviation of measurements. store the result in mean_std data set.
g) give column name to activity list (merged Y data). colnames() is used here.
h) extract the activity descriptions corresponding to the activity labels, and add as a new column. factor() is used for the same.
i) name the column names in mean_std appropriately from variable_names list, by extracting the descriptions corresponding to mean_and_std_variables_index
 
j) give descriptive column name to merged subject list. colnames() is used here.
k) using cbind, combine mean_std, activity_label and subject data sets and store the result in merged_data
l) create a final, tidy data set from merged_data, by piping the data to group_by and summarize_all (mean) in the dplyr package.
l) write the resulting tidy data into output.txt


