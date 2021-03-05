#final app server

# Load libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(plotly)

# Load data
streaming_ratings <- read_csv("data/MoviesOnStreamingPlatforms_updated.csv")
netflix_titles <- read_csv("data/netflix_titles.csv")

pretty_label <- c("IMDb Ratings", "Rotten Tomatoes Ratings")

ugly_label <- c("imdb", "rotten_tomatoes")

label_names <- data.frame(pretty_label, ugly_label)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$chart1 <- renderPlotly({
    
    netflix_ratings <- streaming_ratings %>%
      filter(netflix == "1")
    
    fixed_label <- label_names %>%
      filter(ugly_label == input$x_input) %>%
      pull(pretty_label)
  
    plot1 <- ggplot(data = netflix_ratings) + 
      geom_histogram(mapping = aes_string(x = input$x_input),
                 fill = input$color_input
                 ) +
      labs(title = paste0(fixed_label, " Distribution of Netflix Titles"),
           x = fixed_label,
           y = "Count")

    ggplotly(plot1)
    
  })
  
  output$chart2 <- renderPlotly({
    netflix_by_category <- netflix_titles %>%
      separate_rows(listed_in, sep = ", ") %>%
      filter(type == input$type_category) %>%
      mutate(year_added = str_sub(date_added, -4)) %>%
      select(show_id, type, listed_in, year_added)
    
    category_in_year <- netflix_by_category %>%
      filter(year_added == input$year_input)
    
    year_title <- paste0(input$year_input, " Netflix ",input$type_category,
                         " Categories")
    
    x_label <- paste0("Netflix ",input$type_category," Categories in ", input$year_input)
    
    plot_in_year <- ggplot(data = category_in_year,
                        mapping = aes(x = listed_in)) +
      geom_bar() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
      labs(title = year_title, x = x_label,
           y = paste0("Number of ",input$type_category, "s per Category")) +
      theme(plot.title = element_text(hjust = 0.5))
    
    ggplotly(plot_in_year)
  })
  
  output$chart3 <- renderPlotly({
    netflix_date_added <- netflix_titles %>%
      mutate(year_added = str_sub(date_added, -4)) %>%
      group_by(year_added, type) %>%
      summarize(num_added = n()) %>%
      select(num_added, year_added, type)
    
    year_added_plot_data <- netflix_date_added %>%
      filter(type == input$type_input)
    
    y_label <- paste0("Number of ", input$type_input, "s")
    
    year_added_plot <- ggplot(data = year_added_plot_data,
                              mapping = aes(x = year_added, y = num_added,
                                            group = input$type_input,
                                            color = type)) +
      geom_line(size = input$size_input) +
      labs(title = "Netflix Titles Added Per Year", x = "Year",
           y = y_label, color = "Type of Title") +
      theme(plot.title = element_text(hjust = 0.5))

    ggplotly(year_added_plot)
  })
  
}
