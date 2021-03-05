netflix_titles <- read.csv("../data/netflix_titles.csv")
library(tidyverse)

#library(data.table)
#Grouping netflix data by rated R content (only showing type, title, country, rating)
netflix_rating_R <- netflix_titles %>%
  select(type, title, rating) %>%
  filter(rating == c("R", "TV-MA", "NR")) %>%
 group_by(type)




