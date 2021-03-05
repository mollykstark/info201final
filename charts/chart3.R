library(ggplot2)
library(tidyverse)

netflix_titles <- read.csv("data/netflix_titles.csv")
netflix_date_added <- netflix_titles %>%
  mutate(year_added = str_sub(date_added, -4)) %>%
  group_by(year_added, type) %>%
  summarize(num_added = n()) %>%
  select(num_added, year_added, type)

year_added_plot <- ggplot(data = netflix_date_added,
       mapping = aes(x = year_added, y = num_added, group = type,
                     color = type)) +
  geom_line() +
  labs(title = "Netflix Added by Year", x = "Year",
       y = "Number of Shows", color = "Type of Netflix") +
  theme(plot.title = element_text(hjust = 0.5))

year_added_plot