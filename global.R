library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(googlesheets4)
library(tidyverse)
library(scales)
library(lubridate)
library(DT)
library(plotly)

budget_entries <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1sA8-2kawglPErj02UfJPuAWvtflzeU8LF1UDK8H1HZY/")
budget_entries <- budget_entries %>% 
  mutate(`Date of Purchase` = as.Date(`Date of Purchase`),
         Amount = as.numeric(`Purchase amount (approx)`),
         Description = `Description of Purchase (optional)`) %>%
  select(c(`Timestamp`,
           `Date of Purchase`,
           `Purchase Category`,
           `Description`,
           `Amount`))

categories <- unique(budget_entries$`Purchase Category`)



source("ui.R")
source("server.R")

shinyApp(ui, server)
