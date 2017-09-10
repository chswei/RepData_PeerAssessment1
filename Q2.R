# 1. Loading and preprocessing the data
if (!file.exists("./RepData_PeerAssessment1/figures")) {
  dir.create("./RepData_PeerAssessment1/figures")
}
unzip("./RepData_PeerAssessment1/activity.zip", exdir = "./RepData_PeerAssessment1/activity")
act <- read.csv("./RepData_PeerAssessment1/activity/activity.csv")
act$date <- as.Date(act$date, "%Y-%m-%d")

# 2. Histogram of the total number of steps taken each day
library(dplyr)
library(ggplot2)
sum <- act %>% group_by(date) %>% summarize(total = sum(steps, na.rm = F))
g <- ggplot(sum, aes(total)) + geom_histogram(binwidth = 2000, boundary = 0, na.rm = T)  # It's important to try different binwidths
g + labs(title = "Total Number of Steps Taken Each Day") + labs(x = "Total Number of Steps Taken Each Day", y = "Days")

# g + geom_vline(xintercept = mean(sum$total, na.rm = T)) + geom_vline(xintercept = median(sum$total, na.rm = T))  # They're too close to show simultaneously

dev.copy(png, file = "./RepData_PeerAssessment1/figures/Q2.png")
dev.off()