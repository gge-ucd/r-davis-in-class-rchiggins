#This script is just practicing to reassociate myself with R.  I'm practicing viewing specific data and removing certain data

library(tidyverse)
library(lubridate)
library(scales)

Phenodata <- read.csv(file = "~/2018-2020 Masters Thesis/Greenland data/Kanger phenology Julian Dates 93-17 SPSS from Eric 9.11.19.csv.csv")

View(Phenodata)

Animaldata <- read.csv(file = "~/2018-2020 Masters Thesis/Greenland data/Kanger Caribou and Muskox counts WITH GENDER AND CALVES 1993 - 2019 Conor 7.29.19 version.csv.csv")

View(Animaldata)

nrow(Animaldata)
ncol(Animaldata)
summary(Phenodata)

BetulaEmerge <- Phenodata[,11]
View(BetulaEmerge)
Phenodata[,5]
BetulaLB <-Phenodata$B.nana.LB
View(BetulaLB)
#Both of the above functions pull out just the B. nana leaf bud data

str(Phenodata)
select(Phenodata, Year, Site, E.G, B.nana.LB)

filter(Phenodata, E.G=="E")

PhenoExclosed <- filter(Phenodata, E.G == "E")
View(PhenoExclosed)  
#this is all the data for exclosed plots

BNexclosedLBO <- PhenoExclosed$B.nana.LBO
View(BNexclosedLBO)
#this is all the LBO data for B. nana in exclosed plots


#Betula leaf bud open dates from Exclosed plots excluding NA values.  All other data is still included
BNE <- PhenoExclosed %>% 
  filter(!is.na(B.nana.LBO))

View(BNE)

#This step removes all other data and all that is left is B.nana LB julian dates
BNE<- BNE$B.nana.LBO
View(BNE)

summary(BNE)

Animaldata_jd<-Animaldata %>% 
  group_by(Year) %>% 
  mutate(jd_year = as.Date(paste(Year, Julian.Date, sep="-"),"%Y-%j"))

#attempt to plot data
ggplot(data = Animaldata, aes(x = Julian.Date, y= Muskox.daily.total)) +  geom_point() + facet_wrap(~Year)

ggplot(data = Animaldata_jd, aes(x = jd_year, y= Muskox.daily.total)) +  geom_point()

ggplot(data = Animaldata_jd) +geom_bar(aes(x = Julian.Date, y= Muskox.daily.total), stat= "identity")

#attempt to make x axis Year and Julian Date
ggplot(data = Animaldata, aes(x = Julian.Date, y = Muskox.daily.total, fill=Year)) + 
  geom_bar(stat = "identity", width = 1) +
  facet_grid(~Year, switch = "x", scales = "free_x", space = "free_x") +
  theme(panel.spacing = unit(0, "lines"), 
        strip.background = element_blank(),
        strip.placement = "outside") + 
  xlab("Year") + theme(text = element_text(size = 8)) +
  theme (axis.text.x = element_text(color = "grey20", size=5, angle=90, hjust = 0.5, vjust = 0.5))+ 
  coord_cartesian(xlim = c(115, 190), expand = FALSE, clip = "off") 
#Note that Julian Days between 115-190 are the only ones included
#If I don't want the color gradient, get rid of the fill=Year
