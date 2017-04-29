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
      tabItem("Crosstabs", tabName = "cross",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickCross",  label = "To get data, click here"),
                         hr(), 
                         DT::dataTableOutput("dataCross")
                )
              )
      ),
      tabItem("Bar Charts and Table Calculations", tabName = "bar",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickBar",  label = "To get data, click here"),
                         hr(),
                         DT::dataTableOutput("dataBar")
                )
              )
      )
    )
  )
)