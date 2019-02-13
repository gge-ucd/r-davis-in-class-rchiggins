#week 6 class code

library(tidyverse)  #always start by pulling and loading your package

#### finishing up dplyr =============

surveys <- read_csv("data/portal_data_joined.csv")

#we want to create a data frame with no NA's and remove observation of rare species (seen less than 50 times)

#take all NA's out of weight, hindfoot_length, and sex column

surveys_complete <- surveys %>% 
  filter(!is.na(weight), !is.na(hindfoot_length), !is.na(sex))

species_counts <- surveys_complete %>% 
  group_by(species_id) %>% 
  tally() %>% 
  filter(n >= 50)

surveys_complete <- surveys_complete %>% 
  filter(species_id %in% species_counts$species_id)  #the $ calls a column from a data frame
#the %in% asks: is the entry to the left in the entry to the right of the %in%


#writing your dataframe to .csv

write_csv(surveys_complete, path = "Data_Output/surveys_complete.csv")


#using four # signs, a note, and then a bunch of equal signs makes a different section
#type the letters "ts" then hit tab and you can add a timestamp to your work
# Tue Feb 12 14:32:13 2019 ------------------------------


#### ggplot ===================


#ggplot(data = DATA, mapping = aes(MAPPINGS)) +
# geom_function()

ggplot(data = surveys_complete) #if I run this, I get a blank plot--a gray box

#define a mapping

ggplot(data = surveys_complete, mapping=aes(x = weight, y= hindfoot_length)) #this will give a graph, with nothing filled in but the axes and their scales.  It is like setting up the canvas, and then everything after the + is like what we apply

ggplot(data = surveys_complete, mapping=aes(x = weight, y= hindfoot_length)) +
  geom_point() #this shows all the points on the graph

#saving a plot object
surveys_plot<- ggplot(data = surveys_complete, mapping=aes(x = weight, y= hindfoot_length))

surveys_plot + geom_point()

# try making a hexbin plot

install.packages("hexbin")

surveys_plot + 
  geom_hex()   #this tells you about how many points are in certain hexagons so I can see density

#we're going to build plots from the ground up

ggplot(data = surveys_complete, mapping = aes(x=weight, y=hindfoot_length))

surveys_complete %>% 
  ggplot(aes(x=weight, y = hindfoot_length))  #this does the same thing as the last line

#modifying whole geom appearances
surveys_complete %>% 
  ggplot(aes(x=weight, y = hindfoot_length)) + 
  geom_point(alpha = 0.1)  # everything put in the geom will be a modifcation to everything in that geom.  Alpha is the transparency

surveys_complete %>% 
  ggplot(aes(x=weight, y = hindfoot_length)) + 
  geom_point(alpha = 0.1, color = "tomato")

#using data in a geom
surveys_complete %>% 
  ggplot(aes(x=weight, y=hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color= species_id))

#putting color as a global aesthetic
surveys_complete %>% 
  ggplot(aes(x=weight, y=hindfoot_length, color= species_id)) +
  geom_point(alpha = 0.1)

# using a little jitter.  Using this will give a litle bit of noise around each point to prevent points from sitting on top of each other
surveys_complete %>% 
  ggplot(aes(x=weight, y=hindfoot_length, color= species_id)) +
  geom_jitter(alpha = 0.1)

#move on to boxplots
surveys_complete %>% 
  ggplot(aes(x =species_id, y = weight)) +
  geom_boxplot()

# adding point to boxplot
surveys_complete %>% 
  ggplot(aes(x =species_id, y = weight)) +
  geom_jitter(alpha=0.01, color = "tomato") +
  geom_boxplot(alpha = 0)  #whatever is the last geom you add is the one that is on top.  If you make alpha=0, the fill will be gone, but you will still see the lines


#plotting time series
yearly_counts<-surveys_complete %>%
  count(year, species_id)  #this is like group_by year, species_id and then doing tally


yearly_counts %>% 
  ggplot(aes(x=year, y=n, group = species_id)) +
  geom_line()  #without group=species_id, it didn't include any info about species id, it just had the number of species.  But we can't tell which species is which, so we should add color: see below

yearly_counts %>% 
  ggplot(aes(x=year, y=n, group = species_id, color = species_id)) +
  geom_line() 

#facetting.  By doing this, we can see each of the lines on their own mini graph

yearly_counts %>% 
  ggplot(aes(x=year, y=n, color = species_id)) +
  geom_line() + 
  facet_wrap(~species_id)

# including sex into our facet

yearly_sex_counts <-surveys_complete %>% 
  count(year, species_id, sex)

yearly_sex_counts %>% 
  ggplot(aes(x=year, y=n, color=sex)) +
  geom_line() +
  facet_wrap(~species_id) +   #adding a theme changes how graph looks
  theme_bw() + 
  theme(panel.grid = element_blank()) #this gets rid of grid lines

#I could save the basic plot first as an object, then alter afterward how I like
 ysx_plot<-yearly_sex_counts %>% 
   ggplot(aes(x=year, y=n, color=sex)) +
   geom_line() +
   facet_wrap(~species_id)

 ysx_plot + theme_classic()

 # a little more facetting
 
 yearly_sex_weight <-surveys_complete %>% 
   group_by(year, sex, species_id) %>% 
   summarise(avg_weight=mean(weight))

 yearly_sex_weight %>% 
   ggplot(aes(x=year, y=avg_weight, color=species_id))+
   geom_line()+
   facet_grid(sex~ .)  #what is to the left of the tilda will be the rows, what is on the right is the columns.  If I switch the period and tilda, my graph will be vertical rather than horizontal
 
 #adding labels and stuff
 yearly_sex_counts %>% 
   ggplot(aes(x=year, y=n, color=sex)) +
   geom_line() +
   facet_wrap(~species_id) +  
   theme_bw() + 
   theme(panel.grid = element_blank())+
   labs(title="observed species through time", x = "year of observation", y= "number of species") + 
   theme(text = element_text(size = 16)) +
   theme (axis.text.x = element_text(color = "grey20", size=12, angle=90, hjust = 0.5, vjust = 0.5)) #hjust is a horizontal adjustment (shift) and vjust is verticle just, angle turned the x axis label to be written vertically
 
 ggsave("figures/my_test_facet_plot.jpeg", height = 8, width = 8)
 
 
 #you can use source ("../../ and then a theme or something that you have saved like a theme) Alternatively, you can just copy and paste from a script somewhere