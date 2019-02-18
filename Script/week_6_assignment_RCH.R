#Week 6 assignment

library(tidyverse)

gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

#1A Modify the following code to make a figure that shows how life expectancy has changed over time:

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point()

ggplot(gapminder, aes(x = year, y = lifeExp, color = continent)) + 
  geom_point()

#1B Look at the following code. What do you think the scale_x_log10() line is doing? What do you think the geom_smooth() line is doing?

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) +
  scale_x_log10() +
  geom_smooth(method = "lm", color = 'black', linetype = 'dashed') +
  theme_bw()

#Including the scale_x_log10() makes the x axis a log scale so the points are spread out rather than clumped in one region
#The geom_smooth() line puts a line of best fit through the data points


#1C Challenge: Modify the above code to size the points in proportion to the population of the county. Hint: Are you translating data to a visual feature of the plot?

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop)) +
  scale_x_log10() +
  geom_smooth(method = "lm", color = 'black', linetype = 'dashed') +
  theme_bw()

