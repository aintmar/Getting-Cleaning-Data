Identifiers
subject - The ID of the test subject
activity - The type of activity performed when the corresponding measurements were taken

#i.- I created a work directory, the if function was used in order to get a message in case it already exists.
Then I downloaded and unziped the data using the function download.file with the parameter exdir = "./project" ( my working directory)
then I listed the files with list.files

#ii.- In this part I use the function read.table to read the information stored in features, activity and subject, and the ubication of these files

#iii.- I used the function rbind to combine by rows the corresponding datasets of feature,subject an activity of train and test respectivily,
by doing this, 3 tables were created with all the information for subject, fetures and activity.
Then names were given to the variables using the names function.

#iv.- I combined the 3 merged datasets by columns to obtain one data set with all the info

#v.- I obtained the features about mean and standard desviation,I filtered the values of FeaturesNames$V2 using grep
I stored this result in a variable, and then I used this variable to select only the columns that are needed, using the subset function

#vi.- I changed the numbers in the activity columns, for its descriptive activity names

#vii.- I used the gsub function to replace all the prefixes for more appropietly descriptive variables names

#viii.- Finally, dplyr package is used to generate an independent data set, 
I used the aggregate function to combine using the mean all of the repeated results.