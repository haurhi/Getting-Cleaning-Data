library(dplyr)

## Read filepaths and variable names
test_path <- 'UCI HAR Dataset/test'
train_path <- 'UCI HAR Dataset/train'
test_set <- list.files(test_path)
train_set <- list.files(train_path)
feature <- read.table('UCI HAR Dataset/features.txt', stringsAsFactors = F)

## Test datasets
subject_test <- read.table(paste(test_path, '/', test_set[2], sep = ''))
X_test <- read.table(paste(test_path, '/', test_set[3], sep = ''))
y_test <- read.table(paste(test_path, '/', test_set[4], sep = ''))
test_all <- cbind(subject_test, y_test, X_test)
names(test_all) <- c('subject', 'activity', feature[, 2])

## Train datasets
subject_train <- read.table(paste(train_path, '/', train_set[2], sep = ''))
X_train <- read.table(paste(train_path, '/', train_set[3], sep = ''))
y_train <- read.table(paste(train_path, '/', train_set[4], sep = ''))
train_all <- cbind(subject_train, y_train, X_train)
names(train_all) <- c('subject', 'activity', feature[, 2])

## Merges the training and the test sets
dataset <- rbind(train_all, test_all)

## Extracts mean & std
locations <- grep('mean\\(\\)|std\\(\\)', names(dataset))
subdataset <- dataset[, c(1, 2, locations)]

## Read activity names
act_lab <- read.table('UCI HAR Dataset/activity_labels.txt', stringsAsFactors = F)
subdataset[, 2] <- as.factor(subdataset[, 2])
levels(subdataset[, 2]) <- act_lab[, 2]

## Correct column names
names(subdataset) <- gsub('(-|\\(\\))', '', names(subdataset))
names(subdataset) <- gsub('^t', 'time', names(subdataset))
names(subdataset) <- gsub('^f', 'frequency', names(subdataset))

## Summarize the average of each variable grouped by subject and activity
attach(subdataset)
tidy_set <- aggregate(subdataset, by = list(subject, activity), mean)
tidy_set <- tidy_set[, -c(3, 4)]
names(tidy_set)[1:2] <- c('subject', 'activity')
## Alternative
## group_by(subdataset, subject, activity) %>% summarise_each(funs(mean))

## Save as .txt file
write.table(tidy_set, 'tidy_set.txt', row.name = F)