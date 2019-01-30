#Week 4 live code

#first thing, remember to pull your repository from GitHub!

#Intro to Dataframes

download.file(url = "https://ndownloader.figshare.com/files/2292169", destfile = "data/portal_data_joined.csv")

surveys <- read.csv(file = "Data/portal_data_joined.csv")

surveys

head (surveys)

# let's look at structure 
str(surveys)

dim(surveys)
nrow(surveys)
ncol(surveys)

tail(surveys)

names(surveys)
rownames(surveys)

#another really useful one
summary(surveys)

# subsetting dataframes

#subsetting vectors by giving them a location index
animal_vec <- c("mouse", "rat", "cat")
animal_vec[2]

#dataframes are 2D!

surveys[1,1]
head(surveys)

surveys[2,1]

surveys[33000,1]

# whole first column as a VECTOR
surveys[,1]

# using a single number, with no comma, will give us a dataframe with one column
surveys[1]
head(surveys[1])


#pull out the first 3 values in the 6th column
surveys [1:3,6]


animal_vec[c(1,3)]
c(1,3)


# pull out a whole single observation
surveys[5,]

#negative sign to exclude indices
surveys[1:5, -1]


surveys[-c(1:34786),]

surveys[c(10,15,20),]
surveys[c(10,15,20,10),]

#more ways to subset
surveys["plot_id"]   #single column as data.frame
surveys[,"plot_id"]  #single column as vector
surveys[["plot_id"]]  #single column as vector, we'll come back to using double brackets with lists
surveys$year   #single column as vector

#challenge

surveys_200 <-surveys[200,]
nrow(surveys)
surveys[34786,]
tail(surveys)
surveys[nrow(surveys),]
surveys_last <-surveys[nrow(surveys),]

nrow(surveys)/2
surveys[nrow(surveys)/2,]
surveys_middle <-surveys[nrow(surveys)/2,]
surveys[7:nrow(surveys),]
surveys[-c(7:nrow(surveys)),]


#Finally, factors
surveys$sex

#creating our own factor
sex <-factor(c("male", "female", "female","male"))
sex
class(sex)
typeof(sex)


#levels gives back a character vector of the levels
levels(sex)
levels(surveys$genus)

nlevels(sex)

concentration <- factor(c("high", "medium", "high", "low"))
concentration  #this orders the levels alphabetically, but we want it to go from low-high

concentration <- factor(concentration, levels = c("low","medium","high"))
concentration                        


#let's try adding to a factor
concentration <- c(concentration, "very high")
concentration

#coerces to characters if you add a value that doesn't match a current level

#let's just make them characters
as.character(sex)

#factors with numeric levels
year_factor <- factor(c(1990, 1923, 1965, 2018))
as.numeric(year_factor)

as.character(year_factor)

#this will actually give us a numeric vector
as.numeric(as.character(year_factor))

#recommended way
as.numeric(levels(year_factor))[year_factor]

#why the heck all the factors
?read.csv
surveys_no_factors <- read.csv(file = "data/portal_data_joined.csv", stringsAsFactors=FALSE)

#renaming factors
sex <- surveys$sex
levels(sex)
levels(sex)[1] <- "undetermined"
levels(sex)


#working with dates
library(lubridate)

my_date <- ymd("2015-01-01")
my_date
str(my_date)

my_date <- ymd(paste("2015", "05", "17", sep = "-"))
my_date
paste(surveys$year, surveys$month, surveys$day, sep = "-")

surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))
surveys$date

surveys$date[is.na(surveys$date)]
