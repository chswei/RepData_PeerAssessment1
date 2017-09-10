# 1. Loading and preprocessing the data
if (!file.exists("./RepData_PeerAssessment1/figures")) {
  dir.create("./RepData_PeerAssessment1/figures")
}
unzip("./RepData_PeerAssessment1/activity.zip", exdir = "./RepData_PeerAssessment1/activity")
act <- read.csv("./RepData_PeerAssessment1/activity/activity.csv")
act$date <- as.Date(act$date, "%Y-%m-%d")

# 4. Time series plot of the average number of steps taken
library(dplyr)
library(ggplot2)
avg <- act %>% group_by(interval) %>% summarize(avg = mean(steps, na.rm = T))
g <- ggplot(avg, aes(interval, avg, group = 1)) + geom_line(na.rm = T)
g + labs(title = "Average Daily Activity Pattern") + labs(x = "5-Minute Interval", y = "Average Number of Steps Taken")
dev.copy(png, file = "./RepData_PeerAssessment1/figures/Q4.png")
dev.off()