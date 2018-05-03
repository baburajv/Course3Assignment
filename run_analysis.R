    
    
    library(dplyr)
    
    # read training data file
    X_training <- read.table("./UCI HAR Dataset/train/X_train.txt")
    Y_training <- read.table("./UCI HAR Dataset/train/Y_train.txt")
    Subject_training <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    
    # read test data
    X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
    Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
    Subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    
    # read data description
    variable_names <- read.table("./UCI HAR Dataset/features.txt")
    
    # read activity labels
    activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
    
    # Merge the training and the test sets to create one data set.
    X_merged <- rbind(X_training, X_test)
    Y_merged <- rbind(Y_training, Y_test)
    Subject_merged <- rbind(Subject_training, Subject_test)
    
    # get only the variable indices that have mean() in the name
    mean_variables_index<-grep("mean\\(\\)",variable_names[,2])
    
    # get only the variable indices that have std() in the name
    std_variables_index<-grep("std\\(\\)",variable_names[,2])
    
    # combine the indeces of mean() variables and std() variables
    mean_and_std_variables_index <- append(mean_variables_index, std_variables_index)
    
    # Extracts only the measurements on the mean and standard deviation for each measurement.
    X_merged_mean_std <- X_merged[,mean_and_std_variables_index]
    
    # give descriptive column names to activity list
    colnames(Y_merged) <- "activity"
    
    # give the activity description to the activity id denoted by column named "activity"
    Y_merged$activitylabel <-factor(Y_merged$activity, labels = as.character(activity_labels[,2]))
    activitylabel<-Y_merged$activitylabel
    
    # 4. Appropriately labels the data set with descriptive variable names.
    colnames(X_merged_mean_std) <- variable_names[mean_and_std_variables_index,2]
    
    # 5. From the data set in step 4, creates a second, independent tidy data set with the average
    # of each variable for each activity and each subject.
    colnames(Subject_merged) <-"subject"
    
    merged_data <- cbind(X_merged_mean_std, activitylabel, Subject_merged)
    
    final_data <- merged_data %>% group_by(activitylabel, subject) %>% summarize_all(funs(mean))
    
    write.table(final_data, file = "./output.txt", row.names = FALSE, col.names = TRUE)
