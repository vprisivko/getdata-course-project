filePath = "./UCI HAR Dataset.zip"
dirPath = "./UCI HAR Dataset"

if (!file.exists(filePath)) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", filePath, mode = "wb")  
  unzip(filePath, exdir = dirPath)
}

activity_labels = read.table(file.path(dirPath, "activity_labels.txt"))
colnames(activity_labels) = c("id", "name")
activity_labels$name = tolower(activity_labels$name)

features = read.table(file.path(dirPath, "features.txt"), stringsAsFactors = FALSE)

subject_test = read.table(file.path(dirPath, "test", "subject_test.txt"))
set_test = read.table(file.path(dirPath, "test", "X_test.txt"))
activity_labels_test = read.table(file.path(dirPath, "test", "Y_test.txt"))

subject_train = read.table(file.path(dirPath, "train", "subject_train.txt"))
set_train = read.table(file.path(dirPath, "train", "X_train.txt"))
activity_labels_train = read.table(file.path(dirPath, "train", "Y_train.txt")) 

test = cbind(activity_labels_test, subject_test, set_test)
train = cbind(activity_labels_train, subject_train, set_train)

merged = rbind(train, test)

colnames(merged) <- c("activity_label", "subject", features[, 2])

nVariables = nrow(features)
merged = merged[, c(TRUE, TRUE, grepl("mean|std", colnames(merged)[-(1:2)]))]

merged$activity_label = activity_labels$name[merged$activity_label]

colnames(merged) = gsub("^t", "time", colnames(merged))
colnames(merged) = gsub("^f", "frequency", colnames(merged))
colnames(merged) = gsub("-", "_", colnames(merged))
colnames(merged) = gsub("\\(\\)", "", colnames(merged))

library(dplyr)
merged = tbl_df(merged)
means = merged %>% group_by(activity_label, subject) %>% summarise_each(funs(mean))

write.table(means, file = "means.txt", row.names = FALSE)
