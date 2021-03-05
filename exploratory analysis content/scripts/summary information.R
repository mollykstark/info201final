# Stores summary information in a list.

netflix_titles <- read.csv("../data/netflix_titles.csv")
library(tidyverse)

summary_info <- list()

summary_info$num_observations <- nrow(netflix_titles)

summary_info$num_movies <- netflix_titles %>%
  filter(type == "Movie") %>%
  nrow()

summary_info$num_tv_show <- netflix_titles %>%
  filter(type == "TV Show") %>%
  nrow()

summary_info$earliest_release_year <- netflix_titles %>%
  filter(release_year == min(release_year, na.rm = T)) %>%
  pull(release_year)

num_g_rated<- netflix_titles %>%
  filter(rating == "G") %>%
  nrow()
num_pg_rated<- netflix_titles %>%
  filter(rating == "PG") %>%
  nrow()
summary_info$num_kid_friendly <- num_g_rated + num_pg_rated

summary_info$num_mature_rated <- netflix_titles %>%
  filter(rating == "TV-MA") %>%
  nrow()

summary_info$num_old_releases <- netflix_titles %>%
  filter(release_year <= 1965) %>%
  nrow()

summary_info$num_new_releases <- netflix_titles %>%
  filter(release_year >= 2015) %>%
  nrow()

