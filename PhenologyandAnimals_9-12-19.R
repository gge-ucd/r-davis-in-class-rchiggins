library(tidyverse)
library(lubridate)

Phenodata <- read.csv(file = "~/2018-2020 Masters Thesis/Greenland data/Kanger phenology Julian Dates 93-17 SPSS from Eric 9.11.19.csv")

View(Phenodata)

Animaldata <- read.csv(file = "~/2018-2020 Masters Thesis/Greenland data/Kanger Caribou and Muskox counts WITH GENDER AND CALVES 1993 - 2019 Conor 7.29.19 version.csv")

View(Animaldata)

nrow(Animaldata)
ncol(Animaldata)
summary(Phenodata)
