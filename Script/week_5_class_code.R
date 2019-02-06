#week 5 class code
#Dplyer stuff today

install.packages("tidyverse")

#call tidyverse using library function
library(tidyverse)

surveys<- read_csv("data/portal_data_joined.csv")

str(surveys)

#select is used when we want to select columns in a data frame

select(surveys, plot_id, species_id, weight)

#filter is used for selecting rows

filter(surveys, year==1995)

surveys2<- filter(surveys, weight <5)

surveys_sml <- select(surveys2, species_id, sex, weight)

#pipes %>% on a PC control-shift-M, on a Mac cmd + shift + M. The pipe is a shorter way to do the same thing that we did to get to the surveys_sml.  You can think of the pipe as the word "then".  Do this, then that, then...  Using the pipe is like putting the word before the pipe first in the following parentheses after the pipe.

surveys %>%
  filter(weight<5) %>%
  select(species_id, sex, weight)

# challenge.  Subset surveys to include individuals collected before 1995 and retain only the columns year, sex, and weight

surveys %>%
  filter(year<1995) %>%
  select(year, sex, weight)

#mutate is used to create new columns.  

#The first thing in parentheses after mutate is what you want to name your new column. If you keep mutating, you can add more columns, but you must name the columns different things if you want different columns, otherwise they will just replace each other

surveys <- surveys %>%
  mutate(weight_kg = weight/1000) %>%
  mutate(weight_kg2 = weight_kg*2)

#if we want to get rid of NA values in weight column

surveys %>%
  filter(!is.na(weight)) %>%
  mutate(weight_kg = weight/1000) %>%
  summary()

#"complete cases" instead of "weight" to filter out all of the NAs

surveys[complete.cases(surveys),]


#Challenge

surveys%>%
  filter(!is.na(hindfoot_length)) %>%
  mutate(hindfoot_half = hindfoot_length / 2) %>%
  filter(hindfoot_half < 30) %>%
  select(species_id, hindfoot_half)

#group_by is good for split-apply-combine

#ex: we want the mean weight of the males and the mean weight of the females
#note: na.rm=TRUE is NA removed.  Summarize is the function we do to the groups that we grouped by

surveys %>%
  group_by(sex)%>%
  summarize(mean_weight = mean(weight,na.rm=TRUE))

surveys %>%
  group_by(sex)%>%
  mutate(mean_weight = mean(weight, na.rm = TRUE)) %>% View()

#summarize spits out a totally new data frame, summarize spits out a totally new data frame


# %>%view lets you just see your output as a tibble

surveys %>%
  filter(is.na(sex))%>%
  View  #this is a way to look at all the NAs in the data frame

surveys %>%
  group_by(species)%>%
  filter(is.na(sex))%>%
  tally() #tally tells us how many NAs there are and doing it with group_by tells us how many for each group


#you can group_by with multiple columns

surveys %>%
  filter(!is.na(weight))%>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight))%>%
  View()

#if you don't filter NAs first, you will get values that are NaN which means not a number.  It probably is when there is no male or female for a species and it is trying to figure out a mean with a denominator (# of indivuals) of zero

surveys %>%
  filter(!is.na(weight))%>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight), min_weight = min(weight))%>%
  View()  #for this one, I added two columns: mean_weight and min_weight using the summarize function

#tally function.  Tally() is the same as group_by(something) %>% summarize(new_column = n())

surveys %>%
  group_by(sex, species_id)%>%
  tally()%>%
  View()


#gathering and spreading

#spread 
# spread requires the data you want to spread, a key column variable (what you want to make into columns), and a value column variable (what you want to populate columns with)

surveys_gw <- surveys%>%
  filter(!is.na(weight))%>%
  group_by(genus, plot_id)%>%
  summarise(mean_weight=mean(weight))

surveys_spread<- surveys_gw %>%
  spread(key = genus, value = mean_weight)

surveys_gw%>%
  spread(genus, mean_weight, fill=0) %>%View() #this would replace NA values with zeros

#Gathering

#gathering requires the data, key, value, and one more thing. -plot_id tells it not to use the values from plot_id to populate the values

surveys_gather <- surveys_spread %>%
  gather(key = genus, value = mean_weight, -plot_id)
