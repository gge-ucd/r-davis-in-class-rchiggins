#Week 4 Assignment
surveys <- read.csv("data/portal_data_joined.csv")

#Subset to just first column and columns 5 through 8
surveys_subset <- surveys[c(1:400),-c(2:4,9:13)]
surveys_subset

#Select all rows that have hindfoot_length > 32
surveys_long_feet <- surveys[surveys$hindfoot_length > 32, 8]
surveys_long_feet

#Histogram of all hindfoot_length > 32
hist(surveys_long_feet)

#Convert hindfoot_length column into character vector
as.character(surveys$hindfoot_length)

#Histogram of hindfoot_length character vector (error message)
hist(surveys$hindfoot_lengths)
