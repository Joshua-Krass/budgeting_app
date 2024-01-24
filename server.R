server <- function(input, output, session) {
  budget <- eventReactive(c(input$select_category, input$input_month_range), {
    budget <- budget_entries
    if(length(input$select_category) > 0)
    {
      budget <- budget %>% 
        filter(`Purchase Category` %in% input$select_category)
    }
    # if(length(input$input_month_range) > 0) {
     
      # budget <- budget %>%
      #   filter(year(`Date of Purchase`) == year(input$input_month)
      #          & month(`Date of Purchase`) == month(input$input_month))
      budget <- budget %>%
        filter(`Date of Purchase` >= input$input_month_range[1] &
                 `Date of Purchase` <= input$input_month_range[2])
    # }
    return(budget)
  })
  output$budget_table <- renderDataTable(
    datatable(budget()) %>%
      DT::formatCurrency(columns = 'Amount'),
    options = list(searching = FALSE))
  
#### Expense Trend Chart ####
  output$expense_trends <- renderPlotly({
    budget <- budget()
    
    plot <- plot_ly()
  })
  
##### INFOBOXES #####
  output$total_spend <-renderInfoBox(
    infoBox(
      #paste0("Spending for ", month.name[month(input$input_month)]), 
      paste0("Spending: ", input$input_month_range[1], 
             " to ", input$input_month_range[2]),
      budget() %>% 
        summarise(total = sum(Amount)) %>%
        mutate(total = dollar(total)), 
      icon = icon("list"),
      color = "green"
    )
  )
  output$top_category <-renderInfoBox(
    infoBox(
      "Top Category", 
      budget() %>% 
        group_by(`Purchase Category`) %>%
        summarise(total = sum(Amount)) %>%
        arrange(desc(total)) %>%
        select(`Purchase Category`) %>%
        summarise(top_group = first(`Purchase Category`)), 
      icon = icon("list"),
      color = "green",
      fill = TRUE
    )
  )
  output$top_category_spend <-renderInfoBox(
    infoBox(
      "Total Spending", 
      budget_entries %>% 
        summarise(total = sum(Amount)) %>%
        mutate(total = dollar(total)),
      icon = icon("list"),
      color = "green"
    )
  )
}