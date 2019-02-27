# Week 8 class code

library(lubridate)
library(tidyverse)

load("Data/mauna_loa_met_2001_minute.rda")

as.Date("02-01-1998", format = "%m-%d-%Y")

mdy("02-01-1998")

tm1 <- as.POSIXct("2016-07-24 23:55:26 PDT")
tm1

tm2 <- as.POSIXct("25072016 8:32:07", format= "%d%m%Y %H:%M:%S")
tm2

tm3 <- as.POSIXct("2010-12-01 11:42:03", tz = "GMT")
tm3

#specifiying timezone and date format in the same call
tm4 <- as.POSIXct(strptime("2016/04/04 14:47", format = "%Y/%m/%d %H:%M"), tz = "America/Los_Angeles")

tz(tm4)

Sys.timezone() #this is how to check what my computer's default timezone is

#Do the same thing with lubridate

ymd_hm("2016/04/04 14:47", tz= "America/Los_Angeles")


#using lubridate on a dataframe

nfy1 <-read.csv("Data/2015_NFY_solinst.csv", skip = 12)
nfy1

nfy2<- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFY_solinst.csv", skip =12, col_types = "ccidd")


glimpse(nfy2)

#This next thing here is a tangent

nfy2<- read_csv("Data/2015_NFY_solinst.csv", skip =12, col_types = cols(Date = col_date())) #read everything as normal, but just read the column Date as a different thing

# back to the instruction

nfy2$datetime <- paste(nfy2$Date, " ", nfy2$Time, sep = "")

glimpse(nfy2)

nfy2$datetime <- ymd_hms(nfy2$datetime, tz = "America/Los_Angeles")

glimpse(nfy2)

tz(nfy2$datetime_test)

summary(mloa_2001)

mloa_2001$datetime <- paste0(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, " ", mloa_2001$hour24, ":", mloa_2001$min)

glimpse(mloa_2001)

mloa_2001$datetime<- ymd_hm(mloa_2001$datetime)

#these next 2 lines were to fix a problem I was having
write_csv(nfy2, "data/2015_NFY_solinst.csv")

test <- read_csv("Data/2015_NFY_solinst.csv", col_types = "ccidd")

#challenge

mloa2 <- mloa_2001 %>% 
  filter(rel_humid != -99, rel_humid != -999) %>% 
  filter(temp_C_2m != -99, temp_C_2m != -999) %>%
  filter(windSpeed_m_s != -99, windSpeed_m_s != -999)


mloa3 <- mloa2 %>% 
  mutate(which_month = month(datetime, label = TRUE)) 
glimpse(mloa3)  #In this step we made a column called which_month that took the month from the datetime column

mloa3 <- mloa2 %>% 
  mutate(which_month = month(datetime, label = TRUE)) %>% 
  group_by(which_month) %>% 
  summarise(avg_temp = mean(temp_C_2m))

mloa3 %>% 
  ggplot() +
  geom_point(aes(x=which_month, y= avg_temp), size = 3, color = "blue")+
  geom_line(aes(x=which_month, y = avg_temp, group =1))  #the group =1 adds the line


##### Functions #####

# A function can be anything you want to run more than once.  The output of the function is the return value...it can be a plot, a dataframe, a matrix, a number, etc.  It depends what you feed it

my_sum <- function(a=1, b=2) {
  the_sum <- a + b
  return(the_sum)
}

my_sum()

my_sum(a=5, b=8) #doing it this way overwrites the defaults of 1 and 2 which were in the original function.  If I didn't have defaults, I would have to have just a, b inside the parentheses after function

#create a function that converts the temp in K to the temp in C (subtract 273.15)

CtoK <- function (C) {
  Kvalue <- C - 273.15
  return(Kvalue)
}

CtoK(300)


##### Iterations ######

x <- 1:10
log(x)

# for loops

for (i in 1:10) {
  print(i)
}                    #this is: for each variable i in vector 1:10. It would be the same thing as me running print(1), then print(2), etc.

for (i in 1:10) {
  print(i)
  print(i^2)
}

letters [1]

# we can use the "i" value as an index

for(i in 1:10) {
  print(letters[i])
  print(mtcars$wt[i])    
}   #you don't have to use i, you could call it whaterver you want


# make a results vector ahead of time

results <- rep(NA, 10)

for(i in 1:10) {
  results[i] <- letters [i]
}

results
