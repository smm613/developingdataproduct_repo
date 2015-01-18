## Application:  Return on Allocation
##
## This application will calculate how much $1000 would have increased/decreased between
## any two years between 1970 and 2014. The user can allocation betwen 0 and 100 percent
## to equities (S&P 500 index) and/or bonds (10-year Treasury Bills).

shinyUI(fluidPage(
  headerPanel("Return on Allocation"),
  
  sidebarPanel(
    numericInput("equityAlloc",label=h4("Equity allocation (0 - 100)"),value=0),
    numericInput("begYr",
                 label=h4("Beginning year (1970 - 2014)"),
                 value=1970),
    numericInput("endYr",
                 label=h4("Ending year (1970 - 2014)"),
                 value=2014),  
    submitButton('Submit')
  ),
  fluidRow(
    column(1),
    column(3,
           h3("Documentation", style = "color:blue"),
           helpText("This app calculates the value of $1000 invested in equities or",
             "the stock market (S&P 500) and/or the bond market (10-year T-Bonds)",
             "between any two years from 1970 through 2014. Specify the percentage",
             "to be allocated to stocks and the remainder will be allocated to bonds.")
          )
  ),
  mainPanel(
    h3('Results of allocation'),
    h4('Equities'),
    verbatimTextOutput("inputValue"),
    h4('Bonds'),
    verbatimTextOutput("allocation"),
    h4('From'),
    verbatimTextOutput("begYr"),
    h4('To'),
    verbatimTextOutput("endYr"),
    h4('Results'),
    verbatimTextOutput("sum")
  )
  ))