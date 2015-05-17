library(shiny)

# Define UI for application that draws a histogram
shinyUI( 
  navbarPage("Developing Data Products",
             tabPanel("Documentation",
                      
                      fluidPage(
                        titlePanel("Documentation"),
                        sidebarLayout(
                          sidebarPanel(
                            h2("Installation"),
                            p("Shiny is available on CRAN, so you can install it in the usual way from your R console:"),
                            code('install.packages("shiny")'),
                            
                            br(),br(),
                            
                            p("Shiny apps have two components:",
                              tags$ul(
                                tags$li("a user-interface script: The user-interface ui.R script controls the layout and appearance of your app."),
                                tags$li("a server script: The server.R script contains the instructions that your computer needs to build your app.")
                              )
                            ),
                            
                            p("If you want to build on my app, you can download my files from github and place both files (ui.R and server.R) in the same folder. For this example, i place mine in C:/stock"),
                            p("In RStudio or R console line, type "),
                            p(code("setwd(\"C:/\")")),
                            p(code("library(shiny)")),
                            p(code("runApp(\"stock\")")),
                            
                            p("If you just want to test the app, please click on the Simple Stock App at the top"),
                            p("Thanks")
                          ),
                          mainPanel(
                            h1("Introducing my simple stock App"),
                            p("Dear Peer Reviewer,"),
                            p("I have built a simple stock app using shiny. 
                              Please read below ",tags$b("How to use this app.")
                            ),
                            p("And to make it easier for you to evaluate/ grade, 
                              I have also placed the ",tags$b("list of requirements")," below with my comments. 
                              I hope this will help make it easier to grade me. Thanks!"),                        
                            
                            h2("How to use this app"),
                            p("Click on the ",tags$b("Simple Stock App")," tab at the top."),
                            p("Click on the drop-down list on the left panel to select from a list of stocks. 
                              You may need to wait a few seconds for the app to load the data from yahoo finance.
                              Once loaded, you will find that the change is pretty fast as I am using R's",
                              em("reactive"), " function to check when to re-load the data. 
                              FYI only, data needs to be reloaded only when dates are subsequently changed."
                              ),
                            p("Modify the widgets ",
                              em("Date Range, Chart Type, Add TA", style = "color: purple;"),
                              " choices accordingly to see the changes."
                            ),
                            p("You will observe how the right-hand plot changes with your choices"),
                            p("Please note the Date Range that you select. 
                              You will see an error if you select incorrect date ranges. 
                              Example if your From-Date is greater than the To-Date."),
                            
                            h2("Grading requirements checklist"),
                            p("Was there enough documentation on the shiny site for a user to get started using the application?"),
                            p("Yes, I placed a short & sweet step-by-step how-to-use my app documentation above.", style = "color: #4d3a7d;"),
                                                                                  
                            p("Did the application run as described in the documentation?"),
                            p("Yes, please click on above Simple Stock App tab to play with the app.", style = "color: #4d3a7d;"),
                            
                            p("Was there some form of widget input (slider, textbox, radio buttons, checkbox, ...) in either ui.R or a custom web page?"),
                            p("Yes, in the app, you will find some of these widget inputs.", style = "color: #4d3a7d;"),
                            
                            p("Did server.R perform some calculations on the input in server.R?"),
                            p("Yes, for example, using quantmod package, server.R will calculate the Exponential Volume Weighted MA line (EVWMA-line) to show in the plot.
                              This EVWMA-line is calculated exponentially based on the closing price of the stock and is weighted by its volume on that day.", style = "color: #4d3a7d;"),
                            
                            p("Was the server calculation displayed in the html page?"),
                            p("Yes, you will see the yellow EVWMA-line on the plot. You can also see other TA calculations plotted ", style = "color: #4d3a7d;"),
                            
                            p("Was the app substantively different than the very simple applications built in the class?"),
                            p("Yes, I never see the stock app in the class notes.", style = "color: #4d3a7d;"),
                            
                            p("Here's your opportunity to give the app +1 for being well done, or neat, or even just a solid effort.
                            "),
                            p("I hope by listing this grading requirements checklist, it will help ease you in grading and gain some brownie points for making this effort ;-).", style = "color: #4d3a7d;"),
                            
                            br(),
                            p("Thanks for taking time to evaluate. Have a nice day!"),
                            br()
                          )
                        )
                      )
                      
                      ),

             tabPanel("Simple Stock App",
                            
                      sidebarLayout(
                        sidebarPanel(
                          helpText("Have fun with this simple app :-)"),
                          
                          ## textInput("symb", "Symbol", "SPY"),
                          selectInput("stock", 
                                      label = "Choose a stock to display",
                                      choices = c("Viacom Inc (VIAB)",
                                                  "The Walt Disney Co (DIS)",
                                                  "Time Warner (TWX)",
                                                  "Twenty First Century Fox (FOXA)",
                                                  "General Electric (GE)",
                                                  "United Parcel Service (UPS)",
                                                  "Genting Singapore (G13.SI)",
                                                  "Fraser Centerpoint Limited (TQ5.SI)"
                                                  ),
                                      selected = "The Walt Disney Co (DIS)"),                      
                          
                          dateRangeInput("dates", 
                                         "Date range",
                                         start = "2015-01-02", 
                                         end = as.character(Sys.Date())),
                          
                          radioButtons("chart_type", label ="Chart Type",
                                       choices = list("Candlestick" = "candlesticks", 
                                                      "Bar" = "bars",
                                                      "Line" = "line"),
                                       selected = "candlesticks"),
                          
                          checkboxGroupInput("TACheckGroup", 
                                             label = "Add Technical Analysis", 
                                             choices = list("Volume"="addVo()",
                                                            "Bollinger Bands" = "addBBands()", 
                                                            "MACD" = "addMACD()",
                                                            "Exponential Volume Weighted MA" = "addEVWMA()"),
                                             selected = NULL)
                          
                         
                          ),
                        
                        mainPanel(plotOutput("plot"))
                      )
                      )
))