# Week 5 assignment 

# load tidyverse

library(tidyverse)

# read csv

surveys <- read_csv("data/portal_data_joined.csv")

# keep all rows where weight is between 30 and 60

surveys %>% 
  filter(weight > 30) %>% 
  filter(weight < 60) %>%  head()

# make tibble with max weigsurveys <- read_csv("data/portal_data_joined.csv")ht for each species+sex combination

biggest_critters <- surveys %>%
  group_by(species, sex) %>% 
  filter(weight == max(weight)) %>%
  arrange(weight)

# where are the NA weights concentrated in the data?

surveys %>% 
  group_by(species, sex) %>% 
  filter(is.na(weight)) %>%
  tally()
# NA weights are concentrated around specific species. It does not seem to depend on sex. 


# take surveys and remove rows where weight is NA, then add column that contains the average weight of each species+sex combination. Remove all columns except for species, sex, weight, and average weight. 

surveys_avg_weight <- surveys %>%
  filter(!is.na(weight)) %>% 
  mutate(mean_weight = mean(weight)) %>%
  group_by(species, sex) %>% 
  select(species, sex, weight, mean_weight) %>% View

# take surveys_avg_weight and add new column called above_average that contains logical values stating whether or not a row's weight is above average for its species + sex combination

surveys_avg_weight %>% 
  mutate(above_average = (weight == mean_weight)) %>% View

# figure out what the scale() function does and add a column to surveys that has the scaled weight, by species. Then sort by this column. Look at the relative biggest and smallest individuals. DO any of them stand out as particularly big or small?

?scale # centers and/or scales the columns, allows us to compare relative values 


surveys %>% 
  mutate(weight_scale = as.numeric(scale(weight))) %>% arrange(desc(weight_scale)) %>% View
  
# I tried using !is.na(weight) to filter out the NAs but got an error. Any idea why I would get this?

#I was also gettting this error "Error in arrange_impl(.data, dots) Argument 1 is of unsupported type matrix" before I added the as.numeric...I don't know why this happened either 
  
         