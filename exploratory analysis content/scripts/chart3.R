library(ggplot2)
library(tidyverse)

netflix_titles <- read.csv("../data/netflix_titles.csv")
netflix_in_us <- netflix_titles %>%
  filter(str_detect(.$country, "United States")) %>%
  select(show_id, rating)

ggplot(data = netflix_in_us, mapping = aes(x = rating)) +
  geom_bar() +
  ggtitle("Netflix Ratings in America") +
  theme(plot.title = element_text(hjust = 0.5))