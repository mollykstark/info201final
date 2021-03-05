#final app ui

# Load libraries
library(shiny)
library(tidyverse)
library(ggplot2)
library(RColorBrewer)
library(plotly)

##### Load data & calculations for input widgets #####
streaming_ratings <- read.csv("data/MoviesOnStreamingPlatforms_updated.csv")
netflix_titles <- read.csv("data/netflix_titles.csv")

netflix_ratings <- streaming_ratings %>%
  filter(netflix == "1")

years_added <- netflix_titles %>%
  mutate(year_added = as.integer(str_sub(date_added, -4))) %>%
  select(year_added) %>%
  arrange(desc(year_added)) %>%
  pull(year_added)
years <- unique(years_added)

types_duplicates <- netflix_titles %>%
  pull(type)
  
types <- unique(types_duplicates)

##### Make introduction panel #####

# Make page to be displayed on intro panel
introduction_page <- fluidPage(theme = "style.css",
  tags$img(src = 'http://cloudfront.bernews.com/wp-content/uploads/2014/08/netflix-logo.png', height = 170, width = 255),
  tags$article(
      tags$h3("For our group's final project, we decided to analyze trends across Netflix content."),
      tags$p("All four of us are avid content consumers, and all identified Netflix as a shared entertainment source,
      especially over the continued quarantine. Analysing data in the entertainment industry isn't something
      most people (or data scientists) think about typically- however the business of marketing entertainment
      requires a great deal of data analytics and skill. In the highly competitive market of streamable entertainment, 
      Netflix competes directly with Disney+, Amazon Prime, Hulu, HBOMax, and others. Netflix continues to hold users
      even in this highly competitive environment, and this dataset may illustrate part of the reason why."),
      ),
  tags$article(
    tags$h3("In our analysis, we decided to focus on answering the following questions:"),
      tags$ol(
        tags$li("How does Netflix choose its content?"),
        tags$li("How has Netflix content changed over time?"),
        tags$li("Why does Netflix prioritize the content it does?")
        ),
      tags$p("In order to answer these questions, we chose to pull from two datasets:
        the Netflix Titles data set, and the Movies on Streaming Platforms dataset.
        Through analysing the following datasets and building charts to answer our questions,
        we were able to learn more about the business side of Netflix,
               and why it includes the content that it does.")
    )
)

# Combine to create full intro page
introduction_panel <- tabPanel(theme = "style.css",
  "Introduction",
  titlePanel("Introduction"),
  introduction_page
)

##### Make chart 1 panel #####

# Create chart 1 data
chart1_data <- netflix_ratings %>%
  select(imdb, rotten_tomatoes)

col_names <- colnames(chart1_data)

# Make chart 1 sidebar
chart1_sidebar_content <- sidebarPanel(theme = "style.css",
  selectInput(
    inputId = "x_input",
    label = "Choose a variable to examine:",
    choices = list(
      "IMDb Ratings" = "imdb",
      "Rotten Tomatoes Ratings" = "rotten_tomatoes"
    )
  ),
  selectInput(
    inputId = "color_input",
    label = "Choose a color:",
    choices = c("red", "orange", "green", "blue", "purple")
  ))
  
# Make chart 1 main panel
chart1_main_content <- mainPanel(theme = "style.css",
  plotlyOutput("chart1"),
)

# Combine panels to create chart 1 page
chart1_panel <- tabPanel(theme = "style.css",
  "By Rating",
  titlePanel("Count of Netflix Titles by Rating"),
  sidebarLayout(
    chart1_sidebar_content,
    chart1_main_content
  ),
  fluidPage(theme = "style.css",
    tags$article(
      tags$h3("Analysis"),
      tags$p("We decided to focus on analyzing the IMDb and Rotten Tomatoes
    ratings of the Netflix movies in our first chart. Looking at these 
    distributions, we can answer questions relating to trends and popularity of
    Netflix programming: For instance, we can see that in the IMDb chart, most
    movies are rated above a 5, on a scale of 1 to 10. We can also see that the
    mode is a 6.3, with 399 movies rated at that value. In the Rotten Tomatoes
    chart, we can see that lots of movies are rated above a 75. The most
    surprising thing is that the mode is 100 (on a scale of 0 to 100), with 137
    movies rated at that value, meaning that there were many positive reviews on
    these movies. This information can provide insights on what the viewers think
    about the movies and help us come to some conclusions about the quality of
    movies on the platform.")
    )
  )
)

##### Make chart 2 panel #####

# Make chart 2 sidebar
chart2_sidebar_content <- sidebarPanel(theme = "style.css",
  selectInput(
    inputId = "year_input",
    label = "Choose a year to examine:",
    choices = years,
    selected = 2020
  ),
  radioButtons(
    inputId = "type_category",
    label = "Choose a type of title to examine:",
    choices = types
  )
)

# Make chart 2 main panel
chart2_main_content <- mainPanel(theme = "style.css",
  plotlyOutput("chart2")
)

# Combine panels to create chart 2 page
chart2_panel <- tabPanel(theme = "style.css",
  "By Category",
  titlePanel("Yearly Netflix Categories"),
  sidebarLayout(
    chart2_sidebar_content,
    chart2_main_content
  ),
  fluidPage(theme = "style.css",
    tags$article(     
      tags$h3("Analysis"),
      tags$p("This second chart shows Netflix category for a given year and type. 
    It is clearly shown that in the past few years (2018,2019,2020) the portfolio 
    of movies on Netflix has been extremely diversified in genre, whereas in some 
    of the earliest years we see data for(2008), the variety of genres 
    for both movies and tv shows available on Netflix is extremely limited. 
    For a time, tv shows didn't even have any data relating to the category. This
    may also help us answer our second question: How has Netflic content changed
    over time? We can see the diversification of Netflix both as a growing
    pattern, as well as to accommodate competition: People will be more likely 
    to choose Netflix as their platform of choice if there is a higher 
    variety of categories for both movies and tv shows available.")
    ) 
  )
)

##### Make chart 3 panel #####

# Make chart 3 sidebar
chart3_sidebar_content <- sidebarPanel(theme = "style.css",
  selectInput(
    inputId = "type_input",
    label = "Choose a type of title to examine:",
    choices = types,
    selected = 'Movie'
  ),
  radioButtons(
    inputId = "size_input",
    label = "Choose a size for the line",
    choices = c(1, 2, 3, 4)
  )
)

# Make chart 3 main panel
chart3_main_content <- mainPanel(theme = "style.css",
  plotlyOutput("chart3"),
)

# Combine panels to create chart 3 page
chart3_panel <- tabPanel(theme = "style.css",
  "By Type",
  titlePanel("Release by Type per Year"),
  sidebarLayout(
    chart3_sidebar_content,
    chart3_main_content
  ),
  fluidPage(theme = "style.css",
    tags$article(             
      tags$h3("Analysis"),
      tags$p("This third chart analyses the types of released content on Netflix 
            by the year it was released, comparing Movies and TV shows. This 
            graph relates to our question of whether Netflix prioritizes new or 
            old content. These graphs show Netflix has more new (released between 
            2015 and 2019) content cumulatively than content between the years of 
            2008 and 2015. This shows that Netflix prioritizes newer TV shows and 
            Movies on its site, perhaps to appeal to a millennial demographic, or 
            as Netflix caters more with its original shows and movies. 
            Regardless, this data can help us understand Netflix's specific role 
            and appeal as a streaming service that constantly supplies users with 
            new content.")
      )
    )
)


##### Make summary takeaway panel #####

# Make page to be displayed on intro panel
summary_page <- fluidPage(theme = "style.css",
    tags$article(
    tags$h3("Summary and Final Conclusions"),
    tags$p("Through this project, we were able to truly delve into the world on 
            business analytics and streaming. Like most people, we had not thought
            much about how content is determined to be kept or let go (especially Netflix's 
            sometimes controversial decisions to drop popular shows such as The Office 
            or Parks and Rec), but our investigation gave us valuable insight into Netflix's
            content strategy and competitive process."),
    ),
    tags$article(
    tags$h3("In our analysis, we decided to focus on answering the following questions:"),
    tags$h5(tags$em(" 1. How does Netflix choose its content?")),
    tags$p("This question was answered through looking at all 3 of the charts we made,
    but specifically the first chart (By Rating):
            The first chart specifically relates IMDB ratings, runtime, and year, to the amount of
            content (shows and movies.) The chart clearly shows the average IMDb and Rotten Tomatoes
            ratings of Netflix content, showing extremely high counts of programming with high Rotten Tomatoes
            scores. The Rotten Tomatoes data, paired with relatively medium IMDB scores, can demonstrate 
            how ratings of programming goes into what content Netflix chooses to show. Higher rated content
            is definitely seen from this data to be prioritized, meaning Netflix is a competitive streaming service
            with highly ranked content available."),
    tags$h5(tags$em(" 2. How has Netflix content changed over time?")),
    tags$p("This question can be answered using our second chart (By Category.)
            The chart looks at movies and tv shows available by genre for different years. As the 
            year becomes more recent, the available content on Netflix is diversified.
            This makes sense for a multitude of reasons, but namely relates again to the 
            content creator's decisions of what content is necessary. In an ever competitive field,
            Netflix has to stay publicly relevant in order to continue to resonate with the public
            and keep a solid consumer base, especially as more and more studios and media companies
            are beginning their own entertainment services and only having their movies and shows available
            (an example of this is HBO and HBOgo/Max.) In order to stay competitive, Netflix has also begun creating its own
            content in the form of 'Netflix Originals', as well as catered toward more genres of content to stream."),
    tags$h5(tags$em(" 3. Why does Netflix prioritze the content it does?")),
    tags$p(" This question can be answered using our third chart (By Type.) 
    This chart directly compares the amount of movies and tv shows added per year.
    In both movies and tv shows, we can see that there was an exponential increase in content added
    between 2015 and 2019. This data coincides directly with an increase in the amount of new movies
    and shows produced by Netflix itself, called 'Netflix Orignials.' 
    In order to stay competitive and draw interest,
    Netflix began releasing original or self-made content in 2013, 
    and has seen growing popularity as a result.
    2015 was a large year for new releases in both shows and movies, 
    and we can see this reflected in this chart. We believe that if the Coronavirus pandemic had not occurred,
    the original exponential growth trend of increasing new content from Netflix would have continued to grow,
    however, the data is not complete for this year and COVID-19 ceased and canceled many entertainment projects.")
    ),
    tags$article(
    tags$h3("Final thoughts and Takeaways"),
    tags$p("Over the course of the data analysis of this project,
            we all learned a great deal about where our content comes from.
            The many strategic decision behind the scenes of Netflix lead to some of our favorite shows,
            as well as some disappointment with canceled shows or Netflix removals overtime.
            It was extremely enlightening to learn about content in this way, and truly analyse what makes
            Netflix such a popular and competitive streaming service when there are hundreds of competitors.
            The process of data analytics was extremely interesting as well, and gave us the challenge and opportunity
            of working with datasets that are not continuious or as easily graphed compared to our in-class experience.")
    )
)


# Combine to create full intro page
summary_panel <- tabPanel(
  "Summary",
  titlePanel("Summary Page"),
  summary_page
)



##### defines the UI #####
ui <- navbarPage(theme = "style.css",
  "Netflix Exploration",
  introduction_panel,
  chart1_panel,
  chart2_panel,
  chart3_panel,
  summary_panel
)



