# data visualization final project shiny ui 

require(shiny)
require(shinydashboard)

dashboardPage(
  dashboardHeader(
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "home", icon = icon("bar-chart")),
      menuItem("Box Plots", tabName = "box", icon = icon("bar-chart")),
      menuItem("Histograms", tabName = "hist", icon = icon("bar-chart")),
      menuItem("Scatter Plots", tabName = "scatter", icon = icon("bar-chart")),
      menuItem("Crosstabs, KPIs, Parameters", tabName = "cross", icon = icon("bar-chart")),
      menuItem("Bar Charts and Table Calculations", tabName = "bar", icon = icon("bar-chart"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem("Home", tabName = "home"
      ),
      tabItem("Box Plots", tabName = "box",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickBox",  label = "To get data, click here"),
                         hr(),
                         DT::dataTableOutput("dataBox")
                )
              )
      ),
      tabItem("Histograms", tabName = "hist",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickHis",  label = "To get data, click here"),
                         hr(),
                         DT::dataTableOutput("dataHis")
                )
              )
      ),
      tabItem("Scatter Plots", tabName = "scatter",
              tabsetPanel(
                tabPanel("Data",
                         actionButton(inputId = "clickScatter",  label = "To get data, click here"),
                         hr(),
                         DT::dataTableOutput("dataScatter")
                )
              )
      ),
      tabItem("Crosstabs, KPIs, Parameters", tabName = "cross",
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