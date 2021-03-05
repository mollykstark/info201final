# Chart 1

library(tidyverse)
library(ggplot2)

netflix_titles <- read.csv("https://raw.githubusercontent.com/info201b-au20/info-project/gh-pages/data/netflix_titles.csv?token=ARIC7JWHVE2THFSG3MQJTJ27W5MOE")

ggplot(data = netflix_titles, mapping = aes(x = release_year)) + 
  geom_histogram()


