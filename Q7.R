# 1. Loading and preprocessing the data
if (!file.exists("./RepData_PeerAssessment1/figures")) {
  dir.create("./RepData_PeerAssessment1/figures")
}
unzip("./RepData_PeerAssessment1/activity.zip", 
      exdir = "./RepData_PeerAssessment1/activity")
act <- read.csv("./RepData_PeerAssessment1/activity/activity.csv")
act$date <- as.Date(act$date, "%Y-%m-%d")

# 6. Code to describe and show a strategy for imputing missing data
library(dplyr)
library(ggplot2)
avg <- act %>% group_by(interval) %>% summarize(avg = mean(steps, na.rm = T))
act.na <- act[is.na(act$steps), ]
act[is.na(act$steps), 1] <- avg[avg$interval %in% as.character(act.na[, 3]), 2]

# 7. Histogram of the total number of steps taken each day 
# after missing values are imputed
sum <- act %>% group_by(date) %>% summarize(total = sum(steps))
g <- ggplot(sum, aes(total)) + 
  geom_histogram(binwidth = 2000, boundary = 0, na.rm = T)  
g + labs(title = "Total Number of Steps Taken Each Day") + 
  labs(x = "Total Number of Steps Taken Each Day", y = "Days")
dev.copy(png, file = "./RepData_PeerAssessment1/figures/Q7.png")
dev.off()