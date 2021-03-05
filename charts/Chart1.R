# Chart 1

library(tidyverse)
library(ggplot2)

netflix_titles <- read.csv("data/netflix_titles.csv")

count_release_year_plot <- ggplot(data = netflix_titles) + 
  geom_histogram(mapping = aes(x = release_year, fill = type)) +
  labs(title = "Number of Shows Released Each Year",
       x = "Release Year",
       y = "Number of Shows",
       fill = "Type of Show") +
  scale_x_continuous(limits = c(1925, 2025))



