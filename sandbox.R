## app.R ##
library(shiny)
library(shinyBS)
library(shinydashboard)

ui <- dashboardPage(
  
  dashboardHeader(),
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard"))
    )
  ),
  
  ## Body content
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              actionButton("showTable", "Show Table", icon = icon("table")),
              bsModal("modalExample", "Data Table", "showTable", size = "large",
                      dataTableOutput("tbl"))
      )
    )
  )
)

server <- function(input, output) { 
  output$tbl = renderDataTable( iris, options = list(lengthChange = FALSE))
}

shinyApp(ui, server)