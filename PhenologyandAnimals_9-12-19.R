#This script is just practicing to reassociate myself with R.  I'm practicing viewing specific data and removing certain data

library(tidyverse)
library(lubridate)

Phenodata <- read.csv(file = "~/2018-2020 Masters Thesis/Greenland data/Kanger phenology Julian Dates 93-17 SPSS from Eric 9.11.19.csv")

View(Phenodata)

Animaldata <- read.csv(file = "~/2018-2020 Masters Thesis/Greenland data/Kanger Caribou and Muskox counts WITH GENDER AND CALVES 1993 - 2019 Conor 7.29.19 version.csv")

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
