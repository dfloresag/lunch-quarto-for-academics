# Analysis of stocks
####

library(tidyverse, quietly = TRUE)
library(lubridate)
library(tidyquant)
library(xlsx)

get_what <- "stock.prices"
companies <- c("AAPL",
             "MSFT",
             "GOOG",
             "AMZN",
             "TSLA")

for(company in companies){
  stocks_data <- tq_get(company , get = get_what) %>% as.data.frame()
  write.xlsx(stocks_data,
             file="scripts/data/stocks_data.xlsx",
             sheetName = company,
             append = ifelse(company == "AAPL", FALSE, TRUE),
             row.names=FALSE)
}
