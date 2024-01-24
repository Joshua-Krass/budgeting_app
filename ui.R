ui <- shinydashboard::dashboardPage(
  shinydashboard::dashboardHeader(
    title = "Expense Application"
  ),
  shinydashboard::dashboardSidebar(
    shinyWidgets::pickerInput("select_category",
                "Select Category",
                choices = categories,
                selected = "",
                multiple = TRUE,
                options = list(`actions-box` = TRUE,
                               `deselect-all-text` = "Deselect All",
                               `select-all-text` = "Select All",
                               `none-selected-text` = "Showing All"),
                choicesOpt = list(
                  style = rep(("color: black; background: lightgrey; font-weight: bold;"),length(categories)))
                ),
    # airDatepickerInput("input_month",
    #                    label = "Select Month",
    #                    value = Sys.Date(),
    #                    maxDate = Sys.Date(),
    #                    minDate = "2022-11-01",
    #                    range = FALSE,
    #                    view = "months", #editing what the popup calendar shows when it opens
    #                    minView = "months", #making it not possible to go down to a "days" view and pick the wrong date
    #                    dateFormat = "MMMM yyyy"
    # )
    dateRangeInput("input_month_range",
                   label = "Select Range",
                   start = "2023-04-21",
                   end = "2023-05-05"
                   )
  ),
  shinydashboard::dashboardBody(
    fluidRow(
      column(
        4,
        infoBoxOutput("total_spend",
                      "Total Spending")
      ),
      column(
        4,
        infoBoxOutput("top_category",
                      "Top Cateogry")
      ),
      column(
        4,
        infoBoxOutput("top_category_spend",
                      "Total Spent in Top Category")
      )
    ),
    fluidRow(
      plotlyOutput("expense_trends")
    ),
    fluidRow(
      dataTableOutput("budget_table")
    )
  )
)