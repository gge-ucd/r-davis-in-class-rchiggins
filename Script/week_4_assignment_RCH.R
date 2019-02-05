#Week_4_assignment_RCH.R

#step 2 read the file
read.csv("data/portal_data_joined.csv")

#step 2 create a data.frame from the file
surveys <- read.csv(file="data/portal_data_joined.csv")

#step 3 pull out columns 1 and 5-8 and rows 1-400 and create a data.frame for it
surveys[c(1:400), c(1,5:8)]
surveys_subset<- surveys[c(1:400), c(1,5:8)]

#step 4 Challenge. see next note
surveys_subset["hindfoot_length"]
surveys_subset[surveys_subset$"hindfoot_length">32,]

#This is the values for hindfoot length greater than 32 with NA's ommitted.  If na.omit is not included, NA's will be included
surveys_long_feet<-na.omit(surveys_subset[surveys_subset$"hindfoot_length">32,])
surveys_long_feet

#plotting the hindfoot_length row in a histogram plot.  I changed the 5th column, hindfoot_length, from the data.frame into a numerical vector and plotted that in a histogram. See below
surveys_long_feet[,5]
hindfoot_length<-surveys_long_feet[,5]
hindfoot_length
hist(hindfoot_length)

#step 6 changing hindfoot_length to a character vector

hindfoot_length<-as.character(hindfoot_length)
hindfoot_length

#attempt to plot new character vector of hindfoot_length in a histogram.  It doesn't work because it is no longer numeric

hist(hindfoot_length)
