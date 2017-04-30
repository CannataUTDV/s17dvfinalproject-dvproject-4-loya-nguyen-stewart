# data visualization final project shiny ui 

require(shiny)
require(shinydashboard)

dashboardPage(
  skin = "yellow",
  
  dashboardHeader(title = "Fatal Police Shooting Since 2015",
                  titleWidth = 400
  ),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "home", icon = icon("bar-chart")),
      menuItem("Box Plots", tabName = "box", icon = icon("bar-chart")),
      menuItem("Histograms", tabName = "hist", icon = icon("bar-chart")),
      menuItem("Scatter Plot", tabName = "scatter", icon = icon("bar-chart")),
      menuItem("Crosstabs", tabName = "cross", icon = icon("bar-chart"),
        menuSubItem("KPIs", tabName = "kpi", icon = icon("check")),
        menuSubItem("Calculated Fields", tabName = "calf", icon = icon("check")),
        menuSubItem("Sets", tabName = "sets", icon = icon("check")),
        menuSubItem("Parameters", tabName = "para", icon = icon("check"))
        ),
      menuItem("Bar Charts", tabName = "bar", icon = icon("bar-chart"),
        menuSubItem("Table Calculations", tabName = "tableCal", icon = icon("check")),
        menuSubItem("Reference Line", tabName = "refLine", icon = icon("check")),
        menuSubItem("ID Sets", tabName = "idSet", icon = icon("check"))
      )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem("Home", tabName = "home"
      ),
      tabItem("Box Plot", tabName = "box",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickBox",  label = "To get data, click here"),
                         hr(),
                         DT::dataTableOutput("dataBox")
                )
              )
      ),
      tabItem("Histogram", tabName = "hist",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickHis",  label = "To get data, click here"),
                         hr(),
                         DT::dataTableOutput("dataHis")
                )
              )
      ),
      tabItem("Scatter Plot", tabName = "scatter",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickScatter",  label = "To get data, click here"),
                         hr(),
                         DT::dataTableOutput("dataScatter")
                )
              )
      ),
      
#------------------------------------------------------- Begin Crosstabs, KPIs, Parameters Tab -------------------------------------------------------
      
      tabItem("Crosstabs", tabName = "cross",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickCross",  label = "To get data, click here"),
                         hr(), 
                         DT::dataTableOutput("dataCross")
                )
              )
      ),
      tabItem("KPIs", tabName = "kpi",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickKPIs",  label = "To get data, click here"),
                         hr(), 
                         DT::dataTableOutput("dataKPIs")
                )
              )
      ),
      tabItem("Calculated Fields", tabName = "calf",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickCalF",  label = "To get data, click here"),
                         hr(), 
                         DT::dataTableOutput("dataCalF")
                )
              )
      ),
      tabItem("Sets", tabName = "sets",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickSets",  label = "To get data, click here"),
                         hr(), 
                         DT::dataTableOutput("dataSets")
                )
              )
      ),
      tabItem("Parameters", tabName = "para",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickPara",  label = "To get data, click here"),
                         hr(), 
                         DT::dataTableOutput("dataPara")
                )
              )
      ),
      
#------------------------------------------------------- End Crosstabs, KPIs, Sets, Parameters Tab -------------------------------------------------------
      






#------------------------------------------------------- Begin Bar Charts and Table Calculations Tab -------------------------------------------------------

      tabItem("Bar Charts", tabName = "bar",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickBar",  label = "To get data, click here"),
                         hr(),
                         DT::dataTableOutput("dataBar")
                )
              )
      ),
      tabItem("Table Calculations", tabName = "tableCal",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickTabCal",  label = "To get data, click here"),
                         hr(), 
                         DT::dataTableOutput("dataTabCal")
                )
              )
      ),
      tabItem("Reference Line", tabName = "refLine",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickRefLine",  label = "To get data, click here"),
                         hr(), 
                         DT::dataTableOutput("dataRefLine")
                )
              )
      ),
      tabItem("ID Sets", tabName = "idSet",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickIdSet",  label = "To get data, click here"),
                         hr(), 
                         DT::dataTableOutput("dataIdSet")
                )
              )
      )

#------------------------------------------------------- End Bar Charts and Table Calculations Tab -------------------------------------------------------

    )
  )
)