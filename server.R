## Application:  Return on Allocation
##
## The bondAlloc function will calculate the allocation to bonds given the user's 
## equity allocation input
##
## The results function will calculate the annual growth in the equity portion and
## bond portion separately using the annual returns from the following website:
## http://pages.stern.nyu.edu/~adamodar/New_Home_Page/datafile/histretSP.html

library(shiny)

bondAlloc <- function(equityAlloc) 100 - equityAlloc
results <- function(equityAlloc,bondAlloc,begYr,endYr) {
  
  year <- rep(NA, 45)
  for (i in 1:45) {
    year[i] <- c(i+1969)
  }
  eGrowth <- c(   3.56, 14.22, 18.76,-14.31,-25.90, 37.00, 23.83, -6.98,  6.51, 18.52,
                 31.74, -4.70, 20.42, 22.34,  6.15, 31.24, 18.49,  5.81, 16.54, 31.48,
                 -3.06, 30.23,  7.49,  9.97,  1.33, 37.20, 22.68, 33.10, 28.34, 20.89,
                 -9.03,-11.85,-21.97, 28.36, 10.74,  4.83, 15.61,  5.48,-36.55, 25.94,
                 14.82,  2.10, 15.89, 32.15, 13.48)
  bGrowth <- c( 16.75,  9.79,  2.82,  3.66,  1.99,  3.61, 15.98,  1.29, -0.78,  0.67,
                -2.99,  8.20, 32.81,  3.20, 13.73, 25.71, 24.28, -4.96,  8.22, 17.69,
                 6.24, 15.00,  9.36, 14.21, -8.04, 23.48,  1.43,  9.94, 14.92, -8.25,
                16.66,  5.57, 15.12,  0.38,  4.49,  2.87,  1.96, 10.21, 20.10,-11.12,
                 8.46, 16.04,  2.97, -9.10, 10.75)
  yrGrowth <- data.frame(year,eGrowth,bGrowth)
  
#  test parameters: begYr = 1970, endYr = 1972, equityAlloc = 50
  idx = begYr - 1969
  nyrs <- endYr - begYr + 1

  bondAlloc = 100 - equityAlloc
  eamt = 1000 * (equityAlloc/100)
  
  for (i in idx:nyrs) {
    esub <- eamt + eamt * yrGrowth[i,2]/100
    eamt <- esub
  }
  bamt = 1000*(bondAlloc/100)
  for (i in idx:nyrs) {
    bsub <- bamt + bamt * yrGrowth[i,3]/100
    bamt <- bsub
  }
  
  return(esub + bsub)
  
}  

# Define server logic to output parameters and results
shinyServer(function(input, output) {
  output$inputValue <- renderPrint({input$equityAlloc})
  output$allocation <- renderPrint({bondAlloc(input$equityAlloc)})
  output$begYr <- renderPrint({input$begYr})
  output$endYr <- renderPrint({input$endYr})
  output$sum <- renderPrint({results(input$equityAlloc,
                                     bondAlloc(input$equityAlloc),
                                     input$begYr,
                                     input$endYr)})
})