# Week 9 class code

###### More iteration work ######


library(tidyverse)
library(dplyr)

#first argument is the data/thing you want to iterate ACROSS, and the second argument is the function you want to APPLY to each thing

sapply(1:10, sqrt)
sqrt(1:10)

#for loop first

result <- rep(NA, 10)

for(i in 1:10) {
  result[i] <- sqrt(i)/2
}

# now to use sapply - a little bit cleaner
result_apply <- sapply(1:10, function(x) sqrt(x)/2)
result_apply

# additional arguments in apply

mtcars_na <- mtcars
mtcars_na [1, 1:4] <- NA  #this makes the first four columns NA

sapply(mtcars_na, mean)
sapply(mtcars_na, mean, na.rm = T)

#doing this is like doing mean(mtcars_na$mpg, na.rm = T) for each of the first four columns

# back to the tidyverse (how to do the same thing in tidyverse)

mtcars %>%
  map(mean)

mtcars %>% 
  map_dbl(mean)   #this does the same thing as the last line, but in a numeric (dbl/double) vector form

mtcars %>% 
  map_chr(mean)  #this does the same thing, but in a character form

# map_2 for two sets of inputs

map2_chr(rownames(mtcars), mtcars$mpg, function(x,y) paste(x, "gets", y, "miles per gallon"))


# complete workflow

# we are going to rescale some values in the mtcars dataset.  So we will scale weights from 0-1, 0 being the lightest, 1 the heaviest

(mtcars$wt[1] - min(mtcars$wt)) / (max(mtcars$wt) - min(mtcars$wt))   

#here we are taking the first weight value and then subtracting it from the smallest weight value


#generalize

(x - min(x)) / (max(x)-min(x))

# next, we can make this general piece of code into a function

rescale_01 <- function(x) {
  (x - min(x)) / (max(x)-min(x))
}

#we didn't have to put in return because a function, by default, returns the last thing that we put in (in this case, x)

rescale_01(mtcars$wt)

#iterating this

map_df(mtcars, rescale_01)  

#map_df gives a dataframe back with every column on a 0-1 scale









