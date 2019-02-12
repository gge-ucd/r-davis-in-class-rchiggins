#w_5_assignment_rch.R

library(tidyverse)

#2 create object named surveys that reads the portal_data_joined.csv file

surveys<-read_csv("data/portal_data_joined.csv")

#3 subset to keep rows with weight b/n 30-60, & then print first 6 rows of tibble

filter(surveys, weight < 60, weight > 30)%>%
  head()

#4 create tibble showing max weight for each species & sex combo named biggest_critters. Arrange to view biggest and smallest

biggest_critters <- surveys %>% 
  group_by(species, sex) %>% 
  summarize(max_weight=max(weight)) 

biggest_critters%>% 
  arrange(max_weight) %>% 
  View()

#5 Try to figure out where the NA weights are concentrated in the data- is there a particular species, taxa, plot, or whatever, where there are lots of NA values? There isn’t necessarily a right or wrong answer here, but manipulate surveys a few different ways to explore this. Maybe use tally and arrange here.

surveys %>% 
  filter(is.na(sex)) %>% 
  group_by(species_id) %>% 
  tally() %>% 
  arrange()

surveys %>% 
  filter(is.na(sex)) %>% 
  group_by(plot_id) %>% 
  tally() %>% 
  arrange()

surveys %>% 
  filter(is.na(weight)) %>% 
  tally()

surveys %>% 
  filter(is.na(hindfoot_length)) %>% 
  tally()

surveys_avg_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species, sex) %>% 
  summarise(avg_weight =mean(weight))
