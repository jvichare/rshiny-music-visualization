library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(DT)


dashboardPage(skin = "green",
  
  dashboardHeader(
    title = 'Spotify Popularity Analysis',
    titleWidth = 265 # have to increase the width to display the entire title
  ),
  
  dashboardSidebar(
    width = 265,
    sidebarUserPanel("Josh Vichare",
                     image = "https://i.imgur.com/FqDKSj6.jpg"),
    sidebarMenu(
      menuItem("Introduction to Dataset", tabName = "intro", icon = icon("question-circle")),
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
                box(status = "success",
                  plotlyOutput("boxplot"), height = 450),
                box(status = "success",
                  plotOutput("densityplot"), height = 450)
              ),
              fluidRow(
                selectizeInput(inputId = "plot_var", 
                                   label = "Select Variable to Display", 
                                   choices = options, 
                                   selected = 'popularity'), align = 'center')
              ),
      
      tabItem(tabName = "threed",
              fluidRow(
                box(status = "success",
                  plotlyOutput("threeDscatter"), height = 680, width = 8),
                
                # box allowing for user-input for the scatter plot with defaults set
                box(status = "primary",
                  selectizeInput(inputId = "scatter_var1",
                                   label = "Select X-axis Variable",
                                   choices = options,
                                   selected = "danceability"),
                    selectizeInput(inputId = "scatter_var2",
                                   label = "Select Y-axis Variable",
                                   choices = options,
                                   selected = "acousticness"), width = 4),
                
                box(title = "Correlation with Popularity",
                    status = "primary",
                    DT::dataTableOutput('corr_tbl'), width = 4,
                    collapsible = T, collapsed = T)),
              
              fluidRow(
                box(status = "primary", 
                    verbatimTextOutput("click"), width = 8)
              )),
      
      tabItem(tabName = "stats",
              fluidRow(
                box(status = "primary",
                  DT::dataTableOutput("threshold"), width = 12,
                    collapsible = T, collapsed = F)
              )),
      
      tabItem(tabName = "table",
              fluidRow(
                box(status = "primary",
                  DT::dataTableOutput("table"), width = 12)))
    )
  )
)