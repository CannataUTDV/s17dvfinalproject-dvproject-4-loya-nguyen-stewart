# data visualization final project shiny sever

require(ggplot2)
require(dplyr)
require(shiny)
require(shinydashboard)
require(data.world)
require(readr)
require(DT)
require(plotly)


connection <- data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50OmV4c29yZXN0IiwiaXNzIjoiYWdlbnQ6ZXhzb3Jlc3Q6OmY5ODk0YTlhLWZkNjAtNDI2NC04YTk3LTlhYjUwOWYzODZiZSIsImlhdCI6MTQ4NDY5NzMzNiwicm9sZSI6WyJ1c2VyX2FwaV93cml0ZSIsInVzZXJfYXBpX3JlYWQiXSwiZ2VuZXJhbC1wdXJwb3NlIjp0cnVlfQ.WLINQ3z7bGjvYCmpDR3Fvl3LZ4fFDLBDCngivFE3nfoF1EgGQQ0WCxZElC2bxC3YUoUiYEJ6hz8rxVW3yHoecg")

states <- query(connection,dataset="robin-stewart/s-17-dv-project-5", type="sql",
                          query="SELECT distinct `fatal-police-shootings-cleaned`.state
                                     FROM `fatal-police-shootings-cleaned.csv/fatal-police-shootings-cleaned`
                                     order by 1"
)

stateSelectList <- as.list(states$state)


shinyServer(function(input, output) {
  
  # ------------------------------------------------------- Begin Box Plots Tab -------------------------------------------------------
  
  boxData <- eventReactive(input$clickBox, {
    
    tdf = query(connection,
                dataset="uscensusbureau/acs-2015-5-e-income", type="sql",
                query="select State, B19083_001 as GINI, B19301_001 as Per_Capita_Income, B19113_001 as Median_Family_Income, B19202_001 as Median_Non_Family_Income, B19019_001 as Median_Income
      from `USA_All_States` 
      order by Median_Income 
      limit 1000")
    
  })
  output$dataBox <- renderDataTable({DT::datatable(boxData(), rownames = FALSE,
                                                   extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  # ------------------------------------------------------- End Box Plots Tab -------------------------------------------------------

  
  #------------------------------------------------------- Begin Histogram Tab -------------------------------------------------------
  
  histogramData <- eventReactive(input$clickHis, {

    tdf = query(connection,
      dataset="uscensusbureau/acs-2015-5-e-income", type="sql",
      query="select State, B19083_001 as GINI, B19301_001 as Per_Capita_Income, B19113_001 as Median_Family_Income, B19202_001 as Median_Non_Family_Income, B19019_001 as Median_Income
      from `USA_All_States` 
      order by Median_Income 
      limit 1000")
    
  })
  output$dataHis <- renderDataTable({DT::datatable(histogramData(), rownames = FALSE,
                                                 extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  #------------------------------------------------------- End Histogram Tab -------------------------------------------------------
  
  
  
  
  
  
  
  
  
  #------------------------------------------------------- Begin Box Plots Tab -------------------------------------------------------
  
  boxData <- eventReactive(input$clickBox, {
    
    tdf = query(connection,
                dataset="uscensusbureau/acs-2015-5-e-income", type="sql",
                query="select State, B19083_001 as GINI, B19301_001 as Per_Capita_Income, B19113_001 as Median_Family_Income, B19202_001 as Median_Non_Family_Income, B19019_001 as Median_Income
      from `USA_All_States` 
      order by Median_Income 
      limit 1000")
    
  })
  output$dataBox <- renderDataTable({DT::datatable(boxData(), rownames = FALSE,
                                                   extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  #------------------------------------------------------- End Box Plots Tab -------------------------------------------------------
  
  

  
  
  
  
  
  #------------------------------------------------------- Begin Scatter Plots Tab -------------------------------------------------------
  
  dataScatter <- eventReactive(input$clickScatter, {
    
    tdf = query(connection,
                dataset="uscensusbureau/acs-2015-5-e-income", type="sql",
                query="select State, B19083_001 as GINI, B19301_001 as Per_Capita_Income, B19113_001 as Median_Family_Income, B19202_001 as Median_Non_Family_Income, B19019_001 as Median_Income
      from `USA_All_States` 
      order by Median_Income 
      limit 1000")
    
  })
  output$dataScatter <- renderDataTable({DT::datatable(dataScatter(), rownames = FALSE,
                                                   extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  #------------------------------------------------------- End Scatter Plots Tab -------------------------------------------------------
  
  
  
  
  
  
  
  
  #------------------------------------------------------- Begin Crosstabs, KPIs, Parameters Tab -------------------------------------------------------
  
  dataCross <- eventReactive(input$clickCross, {
    
    tdf = query(connection,
                dataset="uscensusbureau/acs-2015-5-e-income", type="sql",
                query="select State, B19083_001 as GINI, B19301_001 as Per_Capita_Income, B19113_001 as Median_Family_Income, B19202_001 as Median_Non_Family_Income, B19019_001 as Median_Income
      from `USA_All_States` 
      order by Median_Income 
      limit 1000")
    
  })
  output$dataCross <- renderDataTable({DT::datatable(dataCross(), rownames = FALSE,
                                                       extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  
  dataKPIs <- eventReactive(input$clickKPIs, {
    
    tdf = query(connection,
                dataset="uscensusbureau/acs-2015-5-e-income", type="sql",
                query="select State, B19083_001 as GINI, B19301_001 as Per_Capita_Income, B19113_001 as Median_Family_Income, B19202_001 as Median_Non_Family_Income, B19019_001 as Median_Income
                from `USA_All_States` 
                order by Median_Income 
                limit 1000")
    
  })
  output$dataKPIs <- renderDataTable({DT::datatable(dataKPIs(), rownames = FALSE,
                                                     extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  dataCalF <- eventReactive(input$clickCalF, {
    
    tdf = query(connection,
                dataset="uscensusbureau/acs-2015-5-e-income", type="sql",
                query="select State, B19083_001 as GINI, B19301_001 as Per_Capita_Income, B19113_001 as Median_Family_Income, B19202_001 as Median_Non_Family_Income, B19019_001 as Median_Income
                from `USA_All_States` 
                order by Median_Income 
                limit 1000")
    
  })
  output$dataCalF <- renderDataTable({DT::datatable(dataCalF(), rownames = FALSE,
                                                    extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  dataSets <- eventReactive(input$clickSets, {
    
    tdf = query(connection,
                dataset="uscensusbureau/acs-2015-5-e-income", type="sql",
                query="select State, B19083_001 as GINI, B19301_001 as Per_Capita_Income, B19113_001 as Median_Family_Income, B19202_001 as Median_Non_Family_Income, B19019_001 as Median_Income
                from `USA_All_States` 
                order by Median_Income 
                limit 1000")
    
  })
  output$dataSets <- renderDataTable({DT::datatable(dataSets(), rownames = FALSE,
                                                    extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  dataPara <- eventReactive(input$clickPara, {
    
    tdf = query(connection,
                dataset="uscensusbureau/acs-2015-5-e-income", type="sql",
                query="select State, B19083_001 as GINI, B19301_001 as Per_Capita_Income, B19113_001 as Median_Family_Income, B19202_001 as Median_Non_Family_Income, B19019_001 as Median_Income
                from `USA_All_States` 
                order by Median_Income 
                limit 1000")
    
  })
  output$dataPara <- renderDataTable({DT::datatable(dataPara(), rownames = FALSE,
                                                    extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  
  #------------------------------------------------------- End Crosstabs, KPIs, Sets, Parameters Tab -------------------------------------------------------
  
  
  
  
  
  
  
  
  
  #------------------------------------------------------- Begin Bar Charts and Table Calculations Tab -------------------------------------------------------
  
  dataBar <- eventReactive(input$clickBar, {
    
    tdf = query(connection,
                dataset="uscensusbureau/acs-2015-5-e-income", type="sql",
                query="select State, B19083_001 as GINI, B19301_001 as Per_Capita_Income, B19113_001 as Median_Family_Income, B19202_001 as Median_Non_Family_Income, B19019_001 as Median_Income
      from `USA_All_States` 
      order by Median_Income 
      limit 1000")
    
  })
  output$dataBar <- renderDataTable({DT::datatable(dataBar(), rownames = FALSE,
                                                       extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  dataTabCal <- eventReactive(input$clickTabCal, {
    
    tdf = query(connection,
                dataset="uscensusbureau/acs-2015-5-e-income", type="sql",
                query="select State, B19083_001 as GINI, B19301_001 as Per_Capita_Income, B19113_001 as Median_Family_Income, B19202_001 as Median_Non_Family_Income, B19019_001 as Median_Income
                from `USA_All_States` 
                order by Median_Income 
                limit 1000")
    
  })
  output$dataTabCal <- renderDataTable({DT::datatable(dataTabCal(), rownames = FALSE,
                                                    extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  dataRefLine <- eventReactive(input$clickRefLine, {
    
    tdf = query(connection,
                dataset="uscensusbureau/acs-2015-5-e-income", type="sql",
                query="select State, B19083_001 as GINI, B19301_001 as Per_Capita_Income, B19113_001 as Median_Family_Income, B19202_001 as Median_Non_Family_Income, B19019_001 as Median_Income
                from `USA_All_States` 
                order by Median_Income 
                limit 1000")
    
  })
  output$dataRefLine <- renderDataTable({DT::datatable(dataRefLine(), rownames = FALSE,
                                                    extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  dataIdSet <- eventReactive(input$clickIdSet, {
    
    tdf = query(connection,
                dataset="uscensusbureau/acs-2015-5-e-income", type="sql",
                query="select State, B19083_001 as GINI, B19301_001 as Per_Capita_Income, B19113_001 as Median_Family_Income, B19202_001 as Median_Non_Family_Income, B19019_001 as Median_Income
                from `USA_All_States` 
                order by Median_Income 
                limit 1000")
    
  })
  output$dataIdSet <- renderDataTable({DT::datatable(dataIdSet(), rownames = FALSE,
                                                    extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  #------------------------------------------------------- End Bar Charts and Table Calculations Tab -------------------------------------------------------
  
  
  
    
})