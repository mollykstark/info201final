library(ggplot2)
library(tidyverse)
library(gridExtra)

netflix_titles <- read.csv("data/netflix_titles.csv")
netflix_by_category <- netflix_titles %>%
  separate_rows(listed_in, sep = ", ") %>%
  filter(type == "Movie") %>%
  select(show_id, type, listed_in, date_added)

netflix_2019 <- netflix_by_category %>%
  filter(str_sub(date_added, -4) == 2019) %>%
  select(show_id, type, listed_in)

netflix_2015 <- netflix_by_category %>%
  filter(str_sub(date_added, -4) == 2015) %>%
  select(show_id, type, listed_in)

plot_2015 <- ggplot(data = netflix_2015,
       mapping = aes(x = listed_in)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "2015 Netflix Movie Categories", x = "2015 Categories",
       y = "Number of Movies") +
  theme(plot.title = element_text(hjust = 0.5))

plot_2019 <- ggplot(data = netflix_2019,
                        mapping = aes(x = listed_in)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "2019 Netflix Movie Categories", x = "2019 Categories",
       y = "Number of Movies") +
  theme(plot.title = element_text(hjust = 0.5))