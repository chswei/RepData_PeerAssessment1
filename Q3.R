# 1. Loading and preprocessing the data
library(dplyr)
library(ggplot2)
if (!file.exists("./RepData_PeerAssessment1/figures")) {
  dir.create("./RepData_PeerAssessment1/figures")
}
unzip("./RepData_PeerAssessment1/activity.zip", exdir = "./RepData_PeerAssessment1/activity")
act <- read.csv("./RepData_PeerAssessment1/activity/activity.csv")
act$date <- as.Date(act$date, "%Y%m%d")

# 3. Mean and median number of steps taken each day
sum <- act %>% group_by(date) %>% summarize(total = sum(steps, na.rm = F))
mean(sum$total, na.rm = T)
median(sum$total, na.rm = T)