rmarkdown::render(
  input = "scripts/3-parametrised-report.Rmd")

rmarkdown::render(
  input = "scripts/3-parametrised-report.Rmd",
  params = list(ticker = "AAPL"))

rmarkdown::render(
  input = "scripts/3-parametrised-report.Rmd",
  params = list(ticker = "TSLA"))

rmarkdown::render(
  input = "scripts/3-parametrised-report.Rmd",
  params = list(ticker = "GOOG"))
