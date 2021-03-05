#The second file you should save in your scripts/ directory should create a table of aggregate information about it. 
netflix_titles <- read.csv("data/netflix_titles.csv")
library(tidyverse)
library(ggplot2)
library(dplyr)
library(gridExtra)
#It must perform a groupby operation to show a dimension of the data set as grouped by a particular feature (column). 
#We expect the included table to:
#Have well formatted (i.e., human readable) column names (so you'll probably have to change them)
#Only contain relevant information (i.e., only select some columns of interest)
#Be intentionally sorted in a meaningful way
#Round any quantitative values so they are displayed in a manner that isn't distracting
#When you display the table in your index.Rmd file, you must also describe why you included the table, and what information it reveals.

#Grouping netflix data by rated R content (only showing type, title, country, rating)
netflix_rating_R <- netflix_titles %>%
  group_by(release_year) %>%
  select(release_year, rating) %>%
  filter(rating == "R")

#Make table of dataframe and save:
aggregate_table <- tableGrob(netflix_rating_R)

#Explanation for index.Rmd file
#I included this table because this allows us to specifically identify movies that have the rating of "R" in comparison to "TV-MA" and " 
#Utilizing this, we can then compare the total R rated movies on netflix directly with number of tv shows rated R. 
#Obviously, a great deal more movies are on netflix that are rated R than tv shows rated R.
#If we were to make another plot with a different rating, we could compare the amount of content on netflix by rating specifically: 
#Is there more G rated or R rated content?
#This dataset and the resulting comparisons we can make can allow us to ask questions about netflix content's gearing based on the rating of their content. 
