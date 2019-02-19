#Week 7 class code

library(tidyverse)

#cowplots can be a good way to combine visuals/graphs

#how to install a package from GitHub

install.packages("devtools")

devtools::install_github("thomasp85/patchwork")  #doing it this way just pulls out a single function from devtools rather than downloading the whole thing

####---------------

#data import and export
library(tidyverse)

wide_data <- read_csv("Data/wide_eg.csv", skip = 2) #skip = 2 skips the first two rows of the table in the excel file.  We did this because it wasn't useful information to include in the table

#.rds and .rda are diff.  .rds must be a single R object (s is for single).  saving as an RDS can be good for saving a single model...you don't have to save the object as a CSV and then reconvert it.  It is only readable by R, however, not other programming languages


# loaded an RDA file that contained a single R object.  RDA files can contain one or mor R objects
load("data/mauna_loa_met_2001_minute.rda")


#write in an object as an RDS
saveRDS(wide_data, "data/wide_data.rds") #this is how you can save an object as an RDS

#remove wide_data
rm(wide_data)


wide_data_rds <- readRDS("data/wide_data.rds")

#saveRDS() and readRDS() for .rds files, and we use save() and load() for .rda files

#other packages: readxl, googlesheets, and googledrive, foreign, rio

#####------------

### Working with Dates and Times  ####

library(lubridate)

sample_dates1 <- c("2016-02-01", "2016-03-17", "2017-01-01")
#r reads these as characters, but we want it to read them as dates.  So, we can us as.Date

as.Date(sample_dates1)
#lookng for data that looks like YYYY MM DD

sample.date2 <- c("02-01-2001", "04-04-1991") #This is the American way, but as.Date can't really read it this way, so we have to format it

sample.date2<- as.Date(sample.date2, format = "%m-%d-%Y")

as.Date("2016/01/01", formate = "%Y/%m/%d")

#Jul 04, 2017

as.Date("Jul 04, 2017", format = "%b %d, %Y") #the %b is what you can use when it is written as an abbreviation.  b represents shortened month, B is full month name


#Date Calculations

dt1<- as.Date("2017-07-11")

dt2<- as.Date("2016-04-22")

dt1

print(dt1-dt2)

print(difftime(dt1, dt2, units = "week"))

six.weeks <- seq(dt1, length = 6, by ="week")  #this starts at date1 and then jumps by 1 week, six times

#create a sequence of 10 dates starting at dt1 with 2 week intervals

twenty.weeks <- seq(dt1, length = 10, by = "2 week")

#or

twenty.weeks <- seq(dt1, length = 10, by = 14)

ymd("2016/01/01") #this, and the next 2 are lubridate functions

dmy("04.04.91")

mdy("Feb 19, 2005")




