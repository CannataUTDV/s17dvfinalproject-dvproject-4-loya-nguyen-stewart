# data visualizxation shiny ui 

require(shiny)
require(shinydashboard)
require(leaflet)

dashboardPage(
  dashboardHeader(
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Barcharts and Table Calculations", tabName = "firsttab", icon = icon("dashboard"))
    )
  ),
  dashboardBody(
    tabItems(
      
      tabItem(tabName = "firsttab",
              tabsetPanel(
                tabPanel("Median Income by Race", plotOutput("distPlot1")),
                tabPanel("Median Income by Fleeing", plotOutput("distPlot2")),
                tabPanel("Inequality Index for High Income Criminals", plotOutput("distPlot3"))
                
              )
      )
    )
  )
)