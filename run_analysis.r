# STEP 1

# Read activity labels and features

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
features<-read.table("features.txt")

# Read test data set files

# Read subjects file

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Read values file

x_test <- read.table("UCI HAR Dataset/test/x_test.txt")

# Read activities file

y_test <- read.table("UCI HAR Dataset/test/y_test.txt")


# Read train data set files

# Read subjects file

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Read values file

x_train <- read.table("UCI HAR Dataset/train/x_train.txt")

# Read activities file

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")


# This step will append train files below test files in order to have a single data set with data from both datasets

subject_total <- rbind(subject_test,subject_train)
x_total <- rbind(x_test,x_train)
y_total <- rbind(y_test,y_train)




# STEP 2


# Filter columns containing mean and std:
# First we get the columns filtered
# And then apply the filter to the complete data

colmeanstd <- grep ("mean|std",features[,2])
x_filtrado <- x_total[,colmeanstd]

# STEP 4

# This will set the names to all data

names(x_filtrado) <- features[colmeanstd,2]
names(y_total) <- c("activity_id")
names(subject_total) <- c("subject_id")
names(activities) <- c("activity_id","activity_description")

# STEP 3

# This will get the activity description for each activity code in the y files, from the activities file

y_merge <- merge(y_total,activities,by.x="activity_id",by.y="activity_id",sort="false")

#This will join the columns regarding subject, activity id and description and data

dataset1 <- cbind (subject_total, y_merge, x_filtrado)

# At this point we already have a full data set combining test and train data sets, filtered by mean and std

# STEP 5

# Export full dataset (just to check intermediate results)

#write.table(dataset1,file="dataset1.txt",sep=" ",row.name=FALSE)


# Last we calculate the mean for each column, by subject and activity

# First we create an empty data frame for data

dataset2 <- data.frame ()

# The first for loop will run as many times as different subjets are found in the data set. The result is sorted by number.
# The second loop will look for all the possible activities (1 to 6)

for (i in sort(unique(dataset1$subject_id))){

# This will filter all rows for this subject.

tmp <- dataset1[dataset1$subject_id == i,]

  for (j in 1:6) {

# This will filter all rows for this activity from the previuos filter (all activities for the subject)

    tmp2 <- tmp[tmp$activity_id == j,]
    if (length(tmp2[,1])>0)
    {

# If there are results for this subject/activity pair, we calculate the means for all numeric columns
# The result will be a single line containing the subject id (i), the activity id (j), and the description for that activity, and then all calculated means.
# This line will be appended at the bottom of the all the lines previously calculated.

      escribo <- cbind (i,j,as.character(activities[j,2]),t(colMeans(tmp2[,4:82],na.rm=TRUE)))
      dataset2 <- rbind (dataset2,escribo)
    }

  }

}

# Once we have all the data, we add the column names.

names(dataset2) <- c("subject_id","activity_id","activity_description",features[colmeanstd,2])

# And write the results to a file

write.table(dataset2,file="dataset2.txt",sep=" ",row.name=FALSE)




