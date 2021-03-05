#final app

# Load libraries
library(shiny)
library(tidyverse)
library(plotly)

# Use source() to execute the 'app_ui.R' and 'app_server.R' files. These will
# define the UI value and server function respectively
source("app_ui.R")
source("app_server.R")

# Create a new 'ShinyApp()'
shinyApp(ui = ui, server = server)
