#Read in features list
features <- read.table("./features.txt")
names(features) <- c("id", "name")

#Get subset of columns
ext_features <- sapply(features$name, function(x) grepl("mean|std", x))

#Read in test set
test_set <- read.table("./test//X_test.txt")
names(test_set) <- features$name
reduced_test_set <- test_set[,ext_features]
test_labels <- read.table("./test/y_test.txt")
names(test_labels) <- c("activity_labels")
reduced_test_set <- cbind(reduced_test_set, test_labels)
test_subjects <- read.table("./test/subject_test.txt")
names(test_subjects) <- c("subjects")
reduced_test_set <- cbind(reduced_test_set, test_subjects)
row.names(reduced_test_set) <- 1:nrow(reduced_test_set)

#Read in training set
train_set <- read.table("./train//X_train.txt")
names(train_set) <- features$name
reduced_train_set <- train_set[,ext_features]
train_labels <- read.table("./train/y_train.txt")
names(train_labels) <- c("activity_labels")
reduced_train_set <- cbind(reduced_train_set, train_labels)
train_subjects <- read.table("./train/subject_train.txt")
names(train_subjects) <- c("subjects")
reduced_train_set <- cbind(reduced_train_set, train_subjects)
row.names(reduced_train_set) <- 1:nrow(reduced_train_set) + nrow(reduced_test_set)

#Merge the data simply using rbind
mergedData <- rbind(reduced_test_set, reduced_train_set)

#Replace labels with descriptive labels
activity_labels <- read.table("./activity_labels.txt")
names(activity_labels) <- c("id", "activity")
activities <- lapply(mergedData$activity_labels, function(x) activity_labels[x,]$activity)
names(activities) <- c("activity")
mergedData$activity <- activities

#Create average for each subject and activity
library(reshape)
melted <- melt(mergedData[c(-82)], id=c("activity_labels", "subjects"))
tidy <- cast(activity_labels + subjects ~ variable, data=melted, fun = mean)
activities <- lapply(tidy$activity_labels, function(x) activity_labels[x,]$activity)
activity <- unlist(activities)
tidy <- cbind(tidy, activity)

#Write to a file
write.csv(tidy, "tidy.csv", row.names = F)
