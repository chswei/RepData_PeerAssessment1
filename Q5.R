# 1. Loading and preprocessing the data
library(dplyr)
library(ggplot2)
if (!file.exists("./RepData_PeerAssessment1/figures")) {
  dir.create("./RepData_PeerAssessment1/figures")
}
unzip("./RepData_PeerAssessment1/activity.zip", exdir = "./RepData_PeerAssessment1/activity")
act <- read.csv("./RepData_PeerAssessment1/activity/activity.csv")
act$date <- as.Date(act$date, "%Y-%m-%d")

# 5. The 5-minute interval that, on average, contains the maximum number of steps
avg <- act %>% group_by(interval) %>% summarize(avg = mean(steps, na.rm = T))
avg[which.max(avg$avg), 1]