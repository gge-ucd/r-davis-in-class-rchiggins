#Week_4_assignment_RCH.R

#step 1
read.csv("data/portal_data_joined.csv")

#step 2
surveys <- read.csv(file="data/portal_data_joined.csv")

#step 3
surveys[c(1:400), c(1,5:8)]
surveys_subset<- surveys[c(1:400), c(1,5:8)]

#step 4
surveys_subset["hindfoot_length"]
