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
surveys_subset[surveys_subset$"hindfoot_length">32,]

#This is the values for hindfoot length greater than 32 with NA's ommitted.  If na.omit is not included, NA's will be included
surveys_long_feet<-na.omit(surveys_subset[surveys_subset$"hindfoot_length">32,])
surveys_long_feet
