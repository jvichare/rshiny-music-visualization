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
              "To be replaced with 2d plots and graphs"),
      tabItem(tabName = "threed",
              "To be replaced with 3d plotly graph"),
      tabItem(tabName = "stats",
              "To be replaced with some statistical analysis"),
      tabItem(tabName = "table",
              "To be replaced with the table of the dataset")
    )
  )
)