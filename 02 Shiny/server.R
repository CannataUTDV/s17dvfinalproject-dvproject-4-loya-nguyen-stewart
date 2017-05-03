# data visualization final project shiny sever

require(ggplot2)
require(dplyr)
require(shiny)
require(shinydashboard)
require(data.world)
require(readr)
require(DT)
require(plotly)
require(hexbin)


connection <- data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50OmV4c29yZXN0IiwiaXNzIjoiYWdlbnQ6ZXhzb3Jlc3Q6OmY5ODk0YTlhLWZkNjAtNDI2NC04YTk3LTlhYjUwOWYzODZiZSIsImlhdCI6MTQ4NDY5NzMzNiwicm9sZSI6WyJ1c2VyX2FwaV93cml0ZSIsInVzZXJfYXBpX3JlYWQiXSwiZ2VuZXJhbC1wdXJwb3NlIjp0cnVlfQ.WLINQ3z7bGjvYCmpDR3Fvl3LZ4fFDLBDCngivFE3nfoF1EgGQQ0WCxZElC2bxC3YUoUiYEJ6hz8rxVW3yHoecg")

states <- query(connection,dataset="robin-stewart/s-17-dv-project-6", type="sql",
                query="SELECT distinct `fatal-police-shootings-cleaned`.state
                FROM `fatal-police-shootings-cleaned.csv/fatal-police-shootings-cleaned`
                order by 1"
)

stateSelectList <- as.list(states$state)

income <- query(connection,
                dataset="uscensusbureau/acs-2015-5-e-income", type="sql",
                query="select State, B19083_001 as GINI, B19301_001 as Per_Capita_Income, B19113_001 as Median_Family_Income, B19202_001 as Median_Non_Family_Income, B19019_001 as Median_Income
                from `USA_All_States` 
                order by Median_Income 
                limit 1000")

fatalPoliceShootings <- query(connection,
                              dataset="robin-stewart/s-17-dv-final-project", type="sql",
                              query="SELECT * FROM `fatal-police-shootings-cleaned.csv/fatal-police-shootings-cleaned` LIMIT 1000"
)

incomeOfTheFatallyShot <- dplyr::inner_join(income,fatalPoliceShootings, by = c("State" = "state"))

shinyServer(function(input, output) {
  
  #------------------------------------------------------- Begin Histogram Tab -------------------------------------------------------
  
  histogramData <- eventReactive(input$clickHis, {
    
    histo <- incomeOfTheFatallyShot
  })
  output$dataHis <- renderDataTable({DT::datatable(histogramData(), rownames = FALSE,
                                                   extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  output$Histogram <- renderPlot({
    countTotal <- as.data.frame(histogramData())
    
    ggplot(countTotal) + 
      geom_histogram(aes(Per_Capita_Income, fill = Per_Capita_Income  ))
    
  })
  #------------------------------------------------------- End Histogram Tab -------------------------------------------------------
  
  
  
  
  #------------------------------------------------------- Begin Box Plots Tab -------------------------------------------------------
  
  boxData <- eventReactive(input$clickBox, {
    
    boxDataSet <- incomeOfTheFatallyShot %>% dplyr::select(flee, Median_Family_Income)
    
  })
  output$dataBox <- renderDataTable({DT::datatable(boxData(), rownames = FALSE,
                                                   extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  output$plotBox <- renderPlot({
    countTotal <- as.data.frame(boxData())
    
    ggplot(countTotal) + 
      geom_boxplot(aes(x = flee, y = Median_Family_Income, fill = flee)  )
    
  })
  #------------------------------------------------------- End Box Plots Tab -------------------------------------------------------
  

  
  
  #------------------------------------------------------- Begin Scatter Plots Tab -------------------------------------------------------
  
  dataScatter <- eventReactive(input$clickScatter, {
    
   scatters <- incomeOfTheFatallyShot %>% dplyr::select(GINI, Median_Family_Income, armed)
    
  })
  output$dataScatter <- renderDataTable({DT::datatable(dataScatter(), rownames = FALSE,
                                                       extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })

  output$scatterPlot1 <- renderPlot({
    df <- as.data.frame(dataScatter())
    ggplot(df) + geom_point(aes(x = GINI, y = Median_Family_Income, color = armed))
  })
  output$scatterPlot2 <- renderPlot({
    df <- as.data.frame(dataScatter())
    brush = brushOpts(id="plot_brush", delayType = "throttle", delay = 30)
    bdf=brushedPoints(df, input$plot_brush)
    
    if( !is.null(input$plot_brush) ) {
      df %>% dplyr::filter(df$GINI %in% bdf[, "GINI"]) %>% ggplot() + geom_point(aes(x = GINI, y = Median_Family_Income, color = armed)) 
    } 
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
    genderMentalIll <- dplyr::select(incomeOfTheFatallyShot, Per_Capita_Income, gender, signs_of_mental_illness)
    countTotal <- genderMentalIll %>% mutate(Per_Capita_Range = ifelse(Per_Capita_Income < 26500, "low", ifelse(Per_Capita_Income < 31000 & Per_Capita_Income > 26500, "medium","high"))) %>% count(Per_Capita_Range,gender, signs_of_mental_illness)
  })
  output$dataKPIs <- renderDataTable({DT::datatable(dataKPIs(), rownames = FALSE,
                                                    extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  output$KPIPlot <- renderPlot({
    countTotal <- as.data.frame(dataKPIs())
    
    lowCapitaRange <- countTotal %>% filter(Per_Capita_Range == "low")
    mediumCapitaRange <- countTotal %>% filter(Per_Capita_Range == "medium")
    highCapitaRange <- countTotal %>% filter(Per_Capita_Range == "high")
    ggplot() + 
      geom_text(data = lowCapitaRange, aes(x=gender, y=signs_of_mental_illness, label = n),nudge_x = -0.2, size=6) + 
      geom_text(data = mediumCapitaRange, aes(x=gender, y=signs_of_mental_illness, label = n),nudge_x = 0, size=6) + 
      geom_text(data = highCapitaRange, aes(x=gender, y=signs_of_mental_illness, label = n),nudge_x = 0.2, size=6) 
    
  })
  
  dataSets <- eventReactive(input$clickSets, {
    incomeOfTheFatallyShot %>% 
      dplyr::group_by(gender, race) %>% 
      dplyr::summarize(avg_median_income = mean(Median_Income))
    
  })
  output$dataSets <- renderDataTable({DT::datatable(dataSets(), rownames = FALSE,
                                                    extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  output$setPlot <- renderPlot({
    escapePlot <- as.data.frame(dataSets())
    subset <- dplyr::inner_join(income,fatalPoliceShootings, by = c("State" = "state")) %>% dplyr::filter(Median_Income >= 46000 & Median_Income <= 62000) %>%
      dplyr::group_by(gender, race) %>% 
      dplyr::summarize(avg_median_income = mean(Median_Income)) 
    ggplot() + 
      geom_text(data = escapePlot, aes(x= gender, y=race, label = avg_median_income), size=10) + 
      geom_text(data = subset, aes(x=gender, y=race, label = avg_median_income), nudge_y = -.5, size=4)
    
  })
  dataPara <- eventReactive(input$clickPara, {
    paraData <- incomeOfTheFatallyShot %>% dplyr::group_by(race,flee) %>% dplyr::summarise(income = median(Median_Income), MedianFamilyIncomePerCapitaIncomeRatio = median(Median_Family_Income/Per_Capita_Income))

    
  })
  output$dataPara <- renderDataTable({DT::datatable(dataPara(), rownames = FALSE,
                                                    extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  output$paraPlot <- renderPlot({
    
    escapePlot <- as.data.frame(dataPara())
    
    ggplot(escapePlot) + 
      theme(axis.text.x=element_text(angle=90, size=16, vjust=0.5)) + 
      theme(axis.text.y=element_text(size=16, hjust=0.5)) +
      geom_text(aes(x=race, y=flee, label = income), size=6)+
      geom_tile(aes(x=race, y=flee, fill=MedianFamilyIncomePerCapitaIncomeRatio), alpha=0.50)
    
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
    
    incomeByRace <- incomeOfTheFatallyShot %>% dplyr::group_by(race, gender) %>% dplyr::summarize(avg_median_income = mean(Median_Income), sum_income = sum(Median_Income)) %>% dplyr::group_by(race, gender, avg_median_income) %>% dplyr::summarize(window_avg_income = mean(sum_income))
    
  })
  
  output$dataTabCal <- renderDataTable({DT::datatable(dataTabCal(), rownames = FALSE,
                                                      extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  output$tabCalPlot <- renderPlot({
    
    escapePlot <- as.data.frame(dataTabCal())
    
    ggplot(escapePlot, aes(x = gender, y = avg_median_income)) + 
      geom_bar(stat = "identity") +
      scale_y_continuous(labels = scales::comma) + 
      facet_wrap(~race, ncol=1) +
      coord_flip() +
      geom_text(mapping=aes(x=gender, y=avg_median_income, label=round(avg_median_income - window_avg_income)),colour="blue", hjust=-.5)
    
  })
  
  dataRefLine <- eventReactive(input$clickRefLine, {
    
    fleeMentalIncome <- incomeOfTheFatallyShot %>% dplyr::select(flee,signs_of_mental_illness,Median_Income) %>% group_by(signs_of_mental_illness,flee) %>% dplyr::filter(flee %in% c('Car','Foot','Not fleeing')) %>% summarise(Median_income = median(Median_Income))
    
    
    
  })
  output$dataRefLine <- renderDataTable({DT::datatable(dataRefLine(), rownames = FALSE,
                                                       extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  output$refLinePlot <- renderPlot({
    
    escapePlot <- as.data.frame(dataRefLine())
    
    ggplot(escapePlot, aes(x=signs_of_mental_illness, y=Median_income, fill=signs_of_mental_illness)) +
      theme(axis.text.x=element_text(angle=0, size=12, vjust=0.5)) + 
      theme(axis.text.y=element_text(size=12, hjust=0.5)) + 
      geom_bar(stat = "identity") + 
      facet_wrap(~flee, ncol=1) + 
      coord_flip() + 
      geom_hline(aes(yintercept = median(Median_income)), color="purple")
    
  })
  
  dataIdSet <- eventReactive(input$clickIdSet, {
    
    inequalityIndexforHighIncome <- incomeOfTheFatallyShot %>% dplyr::select(id,GINI,Median_Income) %>% mutate(Median_Income_Range = ifelse(Median_Income < 50000, "low", ifelse(Median_Income < 60000 & Median_Income > 50000, "medium","high"))) %>% dplyr::filter(Median_Income_Range == 'high',id > 1000) 
    
  })
  output$dataIdSet <- renderDataTable({DT::datatable(dataIdSet(), rownames = FALSE,
                                                     extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  output$idSetPlot <- renderPlot({
    
    escapePlot <- as.data.frame(dataIdSet())
    
    ggplot(escapePlot, aes(x=id, y=GINI, fill=Median_Income)) +
      theme(axis.text.x=element_text(angle=0, size=12, vjust=0.5)) + 
      theme(axis.text.y=element_text(size=12, hjust=0.5)) +
      geom_bar(stat = "identity")
    
  })
  
  #------------------------------------------------------- End Bar Charts and Table Calculations Tab -------------------------------------------------------
  
  
})