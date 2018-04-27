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
dashboardPage(skin = "green",
  
  dashboardHeader(
    title = 'Spotify Popularity Analysis',
    titleWidth = 300
  ),
  dashboardSidebar(
    width = 300,
    sidebarUserPanel("Josh Vichare",
                     image = "https://i.imgur.com/FqDKSj6.jpg"),
    sidebarMenu(
      menuItem("Introduction to Dataset", tabName = "intro", icon = icon("user")),
      menuItem("2D Plots and Graphs", tabName = "twod", icon = icon("clone")),
      menuItem("3D Graph", tabName = "threed", icon = icon("circle")),
      menuItem("Threshold Values", tabName = "stats", icon = icon("calculator")),
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
              ),
              fluidRow(
                selectizeInput(inputId = "plot_var", 
                                   label = "Select Variable to Display", 
                                   choices = options, 
                                   selected = 'popularity'), align = 'center')
              ),
      
      tabItem(tabName = "threed",
              fluidRow(
                box(plotlyOutput("threeDscatter"), height = 680, width = 8),
                box(selectizeInput(inputId = "scatter_var1",
                                   label = "Select X-axis Variable",
                                   choices = options,
                                   selected = "danceability"),
                    selectizeInput(inputId = "scatter_var2",
                                   label = "Select Y-axis Variable",
                                   choices = options,
                                   selected = "acousticness"), width = 4)),
              fluidRow(
                box(verbatimTextOutput("click"), width = 8)
              )),
      
      tabItem(tabName = "stats",
              fluidRow(
                box(DT::dataTableOutput("threshold"),
                    width = 12)
              )),
      
      tabItem(tabName = "table",
              fluidRow(
                box(DT::dataTableOutput("table"),
                    width = 12)))
    )
  )
)