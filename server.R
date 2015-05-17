library(shiny)
library(quantmod)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
    dataInput <- reactive({
      vStock <- switch(input$stock, 
                       "Viacom Inc (VIAB)" = "VIAB",
                       "The Walt Disney Co (DIS)" = "DIS",
                       "Time Warner (TWX)" = "TWX",
                       "Twenty First Century Fox (FOXA)" = "FOXA",
                       "General Electric (GE)" = "GE",
                       "United Parcel Service (UPS)" = "UPS",
                       "Genting Singapore (G13.SI)" ="G13.SI",
                       "Fraser Centerpoint Limited (TQ5.SI)" ="TQ5.SI"
                       )
      
      getSymbols(vStock, src = "yahoo", 
                 from = input$dates[1],
                 to = input$dates[2],
                 auto.assign = FALSE)
    })
    
    output$plot <- renderPlot({   
      data <- dataInput()     
      
      if (length(input$TACheckGroup)==0){
        chartSeries(data,
                    name = input$stock,                                     
                    type = input$chart_type,
                    theme = chartTheme("black"),
                    up.col = "lightblue",
                    dn.col = "red",
                    TA=NULL                  
                    )
      } else { #if (length(input$TACheckGroup)!=0)
        
        chartSeries(data,
                    name = input$stock,                                     
                    type = input$chart_type,
                    theme = chartTheme("black"),
                    up.col = "lightblue",
                    dn.col = "red",
                    TA=paste(input$TACheckGroup, collapse=";")                  
                    )      

      }
      

      
      
    })

  
  
})