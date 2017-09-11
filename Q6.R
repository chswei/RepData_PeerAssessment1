# 1. Loading and preprocessing the data
library(dplyr)
library(ggplot2)
if (!file.exists("./RepData_PeerAssessment1/figures")) {
  dir.create("./RepData_PeerAssessment1/figures")
}
unzip("./RepData_PeerAssessment1/activity.zip", 
      exdir = "./RepData_PeerAssessment1/activity")
act <- read.csv("./RepData_PeerAssessment1/activity/activity.csv")
act$date <- as.Date(act$date, "%Y%m%d")

# 6. Code to describe and show a strategy for imputing missing data
# 6.1 Calculate and report the total number of missing values in the dataset
# (i.e. the total number of rows with NAs)
sum(is.na(act$steps))
# 6.2 Devise a strategy for filling in all of the missing values in the dataset
avg <- act %>% group_by(interval) %>% summarize(avg = mean(steps, na.rm = T))
act.na <- act[is.na(act$steps), ]
act[is.na(act$steps), 1] <- avg[avg$interval %in% as.character(act.na[, 3]), 2]
# 6.3 Create a new dataset that is equal to the original dataset but 
# with the missing data filled in.
write.csv(act, file = "./RepData_PeerAssessment1/imputedna.csv")