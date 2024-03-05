# {tidyverse} packages:

# {readxl} to import data
library(readxl)

# {dplyr} and {tidyr} to clean and tidy data
library(dplyr)
library(tidyr)

# {ggplot2} to visualise data
library(ggplot2)

# specialised packages:

library(stringr)   # string manipulation
library(lubridate) # time manipulation
library(tsibble)
library(hrbrthemes)


company_tickers <- c(
  "AAPL", "MSFT", "GOOG", "AMZN", "TSLA") 
company_names <- c(
  "AAPL" = "Apple",
  "MSFT" = "Microsoft", 
  "GOOG" = "Alphabet (Google)", 
  "AMZN" = "Amazon",
  "TSLA"= "Tesla")
company_colors <-  c(
  "AAPL" = "#555555", 
  "MSFT" = "#7FBA00", 
  "GOOG" ="#4285F4" , 
  "AMZN" = "#FF9900",
  "TSLA" = "#cc0000"
)
company_logos <- c(
  "AAPL" = "../img/logos/apple.svg", 
  "MSFT" = "../img/logos/microsoft.svg",
  "GOOG" ="../img/logos/alphabet.svg", 
  "AMZN" ="../img/logos/amazon.svg",
  "TSLA" ="../img/logos/tesla.svg"
)

library(lubridate)
library(tidyquant)
library(purrr)

get_what <- "stock.prices"
companies <- c("Apple" = "AAPL", 
               "Microsoft" = "MSFT", 
               "Alphabet" = "GOOG", 
               "Amazon" = "AMZN", 
               "Tesla" = "TSLA") 

update_company_data <- function(get_what, companies){
  
  companies %>% 
    purrr::map_df(tq_get, get = get_what) %>% 
    mutate(daily_log_returns = log(close)-log(lag(close)))
}

get_company_logo <- function(company_ticker){
  company_logos[company_ticker]
}

# get_company_data <- function(company_ticker, start_date = ymd("2020-03-11")){
#   company_data <- 
#     read_xlsx("data/stocks_data.xlsx", sheet = company_ticker) %>% 
#     filter(date > start_date) 
#   company_data
# }


plot_company_data <- function(company_ticker, start_date){
  
  company_data <- get_company_data(company_ticker, start_date = start_date)
  
  company_data %>% 
    ggplot(aes(x = date))+
    geom_line(aes(y = close),
              color = company_colors[company_ticker]) +
    labs(
      title = str_glue("Daily price for {company_ticker}"), 
      subtitle = str_glue("Close stock prices since {start_date %>% format('%d %B, %Y')}"),
      x = "Date",
      y = "Close Price"
    ) + 
    theme_minimal()+
    scale_color_manual(values = company_colors)
}



