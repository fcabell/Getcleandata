Getcleandata
============

Getting and Cleaning Data course project

The script works following these steps:

1.- Read all files from train and test data sets into variables
2.- Append both files (train and test) for each file type (subject, x, y) together
3.- Getting the columns containing mean and std and filtering these from x file
4.- Merge y file with activities file to get the activity descriptions for each line
5.- Put together the column with the subject, the activity info from y, and the filtered data from x
6.- A double loop will filter the data for each subject/activity combination and calculate the mean for each numeric column
7.- The info regarding subject and activity is included in each result, and appended to the output file
8.- Export data to txt file using write.table
