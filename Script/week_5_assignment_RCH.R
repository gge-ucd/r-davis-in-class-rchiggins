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

#6 take surveys, remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination. Then get rid of all the columns except for species, sex, weight, and your new average weight column. Save this tibble as surveys_avg_weight.

surveys_avg_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species, sex) %>% 
  mutate(avg_weight = mean(weight)) %>% 
  select(species, sex, weight, avg_weight)

#7 Challenge: Take surveys_avg_weight and add a new column called above_average that contains logical values stating whether or not a row’s weight is above average for its species+sex combination (recall the new column we made for this tibble)

surveys_avg_weight <- surveys_avg_weight %>% 
  mutate(above_average = weight>avg_weight)

?scale

#8 Extra Challenge: Figure out what the scale function does, and add a column to surveys that has the scaled weight, by species. Then sort by this column and look at the relative biggest and smallest individuals. Do any of them stand out as particularly big or small?


surveys_scaled <- surveys %>% 
  group_by(species) %>% 
  mutate(scaled_weight = scale(weight)) %>% 
  arrange(scaled_weight)

surveys_scaled <- surveys %>% 
  group_by(species) %>% 
  mutate(scaled_weight = scale(weight)) %>% 
  filter(!is.na(scaled_weight)) %>% 
  arrange(scaled_weight) %>% 
  tail() #I did this to view the extreme end of the tail.  I could do the same for the head to see if any stand out.  I also removed NA values just so they wouldn't show up
