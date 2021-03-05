library(ggplot2)
library(tidyverse)

netflix_titles <- read.csv("../data/netflix_titles.csv")
netflix_by_type <- netflix_titles %>%
  group_by(type) %>%
  summarise(num = round((sum(show_id) / sum(netflix_titles$show_id)) * 100),
            .groups = "drop") %>%
  select(type, num)

ggplot(data = netflix_by_type, mapping = aes(x = "", y = num, fill = type)) +
  geom_bar(stat = "identity") +
  coord_polar("y") +
  ggtitle("Types of Netflix") +
  theme_void() +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_text(aes(x = 1, y = num / 1.3, label = paste0(num, "%")))