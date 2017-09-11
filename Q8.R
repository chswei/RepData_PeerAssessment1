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
avg <- act %>% group_by(interval) %>% summarize(avg = mean(steps, na.rm = T))
act.na <- act[is.na(act$steps), ]
act[is.na(act$steps), 1] <- avg[avg$interval %in% as.character(act.na[, 3]), 2]

# 8. Panel plot comparing the average number of steps taken per 5-minute 
# interval across weekdays and weekends
day <- vector()
for (i in 1:length(act$date)) {
  weekdays <-  weekdays(act$date[i])
  if (weekdays %in% c("Saturday", "Sunday")) {
    day <- append(day, "weekend")
  } else {
    day <- append(day, "weekday")
  }
}
day <- factor(day)
act <- mutate(act, day = day)
# Split the data frame
split <- split(act, f = act$day)
avg.weekday <- split$weekday %>% group_by(interval) %>% 
  summarize(avg = mean(steps, na.rm = T))
avg.weekend <- split$weekend %>% group_by(interval) %>% 
  summarize(avg = mean(steps, na.rm = T))
df <- rbind(avg.weekday, avg.weekend)
df <- mutate(df, day = rep(c("weekday", "weekend"), each = 288))
df$day <- factor(df$day)
# Plotting
g <- ggplot(df, aes(interval, avg)) + geom_line(color = "steelblue") + 
  facet_grid(day ~ .)
g + labs(title = "Average Daily Activity Pattern") + labs(x = "5-Minute Interval", y = "Average Number of Steps Taken")
dev.copy(png, file = "./RepData_PeerAssessment1/figures/Q8.png")
dev.off()