#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(DT)


# Define UI for application that draws a histogram
dashboardPage(
  
  dashboardHeader(
    title = 'Title: TBD'
  ),
  dashboardSidebar(
    sidebarUserPanel("Josh Vichare",
                     image = "https://i.imgur.com/FqDKSj6.jpg"),
    sidebarMenu(
      menuItem("Introduction to Dataset", tabName = "intro", icon = icon("user")),
      menuItem("2D Plots and Graphs", tabName = "twod", icon = icon("clone")),
      menuItem("3D Graph", tabName = "threed", icon = icon("circle")),
      menuItem("Statistical Analysis", tabName = "stats", icon = icon("calculator")),
      menuItem("Dataset", tabName = "table", icon = icon("database"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "intro",
              "To be replaced with full introduction"),
      
      tabItem(tabName = "twod",
              fluidRow(
                box(plotlyOutput("boxplot"), height = 450),
                box(plotOutput("densityplot"), height = 450)
              )),
      
      tabItem(tabName = "threed",
              fluidPage(
                box(plotlyOutput("threeDscatter"), 
                height = 750, width = 12)
              )),
      
      tabItem(tabName = "stats",
              "To be replaced with some statistical analysis"),
      
      tabItem(tabName = "table",
              fluidRow(
                box(DT::dataTableOutput("table"),
                    width = 12)))
    )
  )
)