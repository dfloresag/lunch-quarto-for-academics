library(shiny)
library(DT)
source("4-helpers.R")

company_data <- update_company_data(
  get_what = "stock.prices", 
  companies = companies)

# company_data %>% pull(date) %>% min()
# table analysis
# integration of tabs
# reporting and downloading data


ui <- fluidPage(
  navbarPage(
    "Stock Analysis",
    sidebarLayout(
      sidebarPanel(
        selectInput(inputId = "company",
                    label = "Select the company",
                    choices = companies), 
        sliderInput(inputId = "start_date",
                       label = "Select the date range",
                       min = company_data %>% pull(date) %>% min(),
                       max = company_data %>% pull(date) %>% max(), 
                    value = c(ymd("2020-03-11"),company_data %>% pull(date) %>% max()))
        ),
      mainPanel(
        tabsetPanel(
          tabPanel(
            "Single company analysis",
            plotOutput("plot_stocks"),
        #     DTOutput("table_assoc")
          ),
          tabPanel(
            "Multiple company Analysis",
        #     plotOutput("plot_player"),
        #     DTOutput("table_player")
          )
        )
      )
    )
  )
)

server <- function(input, output, session, data = company_data, colors=company_colors) {
  
    
    data_base_plot <- reactive({
      data %>%
        filter(date>ymd(input$start_date[1]))
    })
    
    data_filtered <-reactive({
      data_base_plot() %>% 
        filter(symbol==input$company)
      
    }) 
      
  
  output$plot_stocks <- renderPlot({
    # req(data_base_plot(), data_filtered())
    data_base_plot() %>% 
      ggplot(
        aes(x = date, y = close))+
      geom_line(aes(group = symbol), 
                color = "lightgrey", 
                alpha = 0.5) +
      geom_line(data= data_filtered(),
                color = colors[input$company], 
                linewidth = 1.2)+
      geom_vline(xintercept = ymd("2020-03-11"), color = "red", linetype = 2)+
      theme_ipsum_rc() + 
      labs(
        title = str_glue("Daily price for {names(input$company)}"),
        subtitle = str_glue("Close stock prices since {input$start_date[1] %>% format('%d %B, %Y')}"),
        x = "Date",
        y = "Close Price"
      )
  })

}

shinyApp(ui, server)



