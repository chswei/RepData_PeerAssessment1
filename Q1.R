# Loading and preprocessing the data
library(dplyr)
library(ggplot2)
if (!file.exists("./RepData_PeerAssessment1/figures")) {
  dir.create("./RepData_PeerAssessment1/figures")
}
unzip("./RepData_PeerAssessment1/activity.zip", exdir = "./RepData_PeerAssessment1/activity")
act <- read.csv("./RepData_PeerAssessment1/activity/activity.csv")
act$date <- as.Date(act$date, "%Y%m%d")