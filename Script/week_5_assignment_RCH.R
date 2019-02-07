#w_5_assignment_rch.R

library(tidyverse)

#2 create object named surveys that reads the portal_data_joined.csv file

surveys<-read_csv("data/portal_data_joined.csv")

#3 

filter(surveys, weight < 60, weight > 30)%>%
  print(surveys)

#4

biggest_critters <- filter(surveys, weight < 60, weight > 30) %>% 
  group_by(species, sex) %>% 
  summarize(max_weight=max(weight)) %>% 
  arrange(max_weight) %>% 
  View()

#5