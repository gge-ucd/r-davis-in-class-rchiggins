# Week 8 Assignment

library(lubridate)
library(tidyverse)

am_riv <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFA_solinst_08_05.csv", skip = 13)


#1) Make a datetime column by using paste to combine the date and time columns; remember to convert it to a datetime!

am_riv$datetime <- paste(am_riv$Date, " ", am_riv$Time, sep = "")

am_riv$datetime <- ymd_hms(am_riv$datetime)  
#Why do I need to do this step?  I didn't do it the first time, and it looked like it worked in making a column

#2) Calculate the weekly mean, max, and min water temperatures and plot as a point plot (all on the same graph)


am_riv <-am_riv %>% 
  mutate(wk = week(datetime))
  
am_riv2 <-am_riv %>% 
  group_by(wk) %>% 
  summarise(min_wk = min(Temperature), max_wk = max(Temperature), mean_wk = mean(Temperature))

am_riv2 %>% 
  ggplot() +
  geom_point(aes(x=wk, y = min_wk), size = 3, color = "blue")+
  geom_point(aes(x=wk, y = max_wk), size = 3, color = "red")+
  geom_point(aes(x=wk, y = mean_wk), size = 3, color ="black")+
  xlab("Week Number")+ ylab("Temperature")
  

#3) Calculate the hourly mean Level for April through June and make a line plot (y axis should be the hourly mean level, x axis should be datetime)

am_riv3 <-am_riv %>% 
  mutate(hr = hour(datetime)) 

am_riv3 <- am_riv3 %>% 
  mutate(mth = month(datetime))

am_riv_hrmth <- am_riv3 %>% 
  filter(mth == 4 | mth == 5 | mth == 6) %>% 
  group_by(hr, mth, datetime) %>% 
  summarise(mean_level = mean(Level))

am_riv_hrmth %>% 
  ggplot() +
  geom_point(aes(x=datetime, y = mean_level), size = .25, color = "blue")+
  xlab("Date/Time")+ ylab("Hourly Mean Level")


#Use the mloa_2001 data set (if you don’t have it, download the .rda file from the resources tab on the website). Remeber to remove the NAs (-99 and -999) and to create a datetime column (we did this in class).

load("Data/mauna_loa_met_2001_minute.rda")

mloa2 <- mloa_2001 %>% 
  filter(rel_humid != -99, rel_humid != -999) %>% 
  filter(temp_C_2m != -99, temp_C_2m != -999) %>%
  filter(windSpeed_m_s != -99, windSpeed_m_s != -999)

summary(mloa2)

mloa2$datetime <- paste0(mloa2$year, "-", mloa2$month, "-", mloa2$day, " ", mloa2$hour24, ":", mloa2$min)

mloa2$datetime<- ymd_hm(mloa2$datetime)  #Again, I'm still not understanding Why I need to do this step?

#Then, write a function called plot_temp that returns a graph of the temp_C_2m for a single month. The x-axis of the graph should be pulled from a datetime column (so if your data set does not already have a datetime column, you’ll need to create one!)


plot_temp <- function(monthtoinput, dat = mloa2){
  df <- filter(dat, month == monthtoinput)
  plot <- df %>% 
    ggplot()+ geom_line(aes(x=datetime, y = temp_C_2m), color = "blue")
  return(plot)
}
  
plot_temp(4)  


#monthtoinput doesn't exist outside of the function.  We created it later in the function, but we could still use it
#dat tells it to use the whole dataframe mloa2.  It will look in our environment for it
#df creates a new dataframe, but it is in the function