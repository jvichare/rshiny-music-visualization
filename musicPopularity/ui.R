library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(DT)


dashboardPage(skin = "green",
  
  dashboardHeader(
    title = 'Spotify Popularity Analysis',
    titleWidth = 260 # have to increase the width to display the entire title
  ),
  
  dashboardSidebar(
    width = 260,
    sidebarUserPanel("Josh Vichare", subtitle = "joshvichare@gmail.com",
                     image = "https://i.imgur.com/FqDKSj6.jpg"),
    sidebarMenu(
      menuItem("Introduction to Dataset", tabName = "intro", icon = icon("question-circle")),
      menuItem("Comparitive Plots", tabName = "two_d", icon = icon("clone")),
      menuItem("Interactive Scatter Plot", tabName = "three_d", icon = icon("circle")),
      menuItem("Threshold Values", tabName = "stats", icon = icon("calculator")),
      menuItem("Dataset", tabName = "table", icon = icon("database"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "intro",
              fluidRow(
                # describing most of the variables used in this project
                tabBox(
                  height = "200px",
                  width = 8,
                  selected = "Popularity",
                  tabPanel("Popularity", 
                           "Popularity is a value from 0 to 100, with 100 being the most popular.", br(),
                           "This is calculated based on the number of plays a track has, as well as how recent those plays are."),
                  tabPanel("Energy", 
                           "Energy is a value from 0.0 to 1.0 and represents a perceptual measure of intensity and activity.", br(),
                           "Typically, energetic tracks feel fast, loud, and noisy. For example, death metal has high energy, while a Bach prelude scores low on the scale.", br(),
                           "Perceptual features contributing to this attribute include dynamic range, perceived loudness, timbre, onset rate, and general entropy."),
                  tabPanel("Acousticness", 
                           "Acousticness is a value from 0.0 to 1.0, representing how likely the track is to be acoustic.", br(),
                           "A higher value indicates a higher confidence that the track is acoustic."),
                  tabPanel("Danceability", 
                           "Danceability is a value from 0.0 to 1.0, representing how suitable the music is for dancing.", br(),
                           "It is calculated based on the tempo, regularity of the beat/rhythm stability, and overall beat strength."),
                  tabPanel("Loudness", 
                           "Loudness is a relative value from -60 dB to 0 dB averaged across each track.", br(),
                           "The closer to 0 dB, the overall louder the song is. Decibels, the unit of measure, is a relative way to measure amplitude of sound waves."),
                  tabPanel("Valence",
                           "Valence is a value from 0.0 to 1.0, describing the mood of a track.", br(),
                           "A value closer to 0.0 indicates a sadder sounding song, and higher values represent the opposite."),
                  tabPanel("Speechiness", 
                           "Speechiness is a value from 0.0 to 1.0, describing the presence of spoken words within a song.", br(),
                           "The more exclusively speech-like the recording (e.g. talk show, audio book, poetry), the closer to 1.0 the attribute value.", br(),
                           "Values above 0.66 describe tracks that are probably made entirely of spoken words." , br(),
                           "Values between 0.33 and 0.66 describe tracks that may contain both music and speech, either in sections or layered, including such cases as rap music.",br(), 
                           "Values below 0.33 most likely represent music and other non-speech-like tracks."),
                  tabPanel("Instrumentalness", 
                           "A value from 0.0 to 1.0, detecting whether the track contains no vocals.", br(),
                           "Closer to 1.0, the higher the confidence that the track contains no vocals.", br(),
                           "Tracks above 0.5 already represent instrumental tracks, however above that just means higher confidence."),
                  tabPanel("Liveness", 
                           "A value from 0.0 to 1.0 describing if the track is a live recording or not.", br(),
                           "Higher values represent an increasing chance that the track is a live recording.", br(),
                           "Values above 0.8 have high confidence that the track is a live recording.")
                ),
                
                # information relevant to the spotipy API access used in this project
                box(height = 200,
                    width = 4,
                    status = "success",
                    "All data was gathered using the Spotipy library with Python", br(),
                    "to access the Spotify API. In the github repo, I have uploaded", br(),
                    "the relevant jupyter notebook containing my code.",
                    br(), br(), br(), br(), br(), # placing the learn more button at the bottom of the box
                    actionButton(inputId='ab1',
                                 label="Learn More",
                                 icon = icon("th"),
                                 onclick ="window.open('http://spotipy.readthedocs.io/en/latest/', '_blank')"))
              )),
      
      tabItem(tabName = "two_d",
              fluidRow(
                box(status = "success",
                  plotlyOutput("boxplot"), height = 450),
                box(status = "success",
                  plotlyOutput("densityplot"), height = 450)
              ),
              fluidRow(
                selectizeInput(inputId = "plot_var", 
                                   label = "Select Variable to Display", 
                                   choices = options_2d, 
                                   selected = 'popularity'), align = 'center')
              ),
      
      tabItem(tabName = "three_d",
              fluidRow(
                box(status = "success",
                  plotlyOutput("threeDscatter"), height = 700, width = 8),
                
                # box allowing for user-input for the scatter plot with defaults set
                box(status = "primary",
                  selectizeInput(inputId = "scatter_var1",
                                   label = "Select X-axis Variable",
                                   choices = options_3d,
                                   selected = "danceability"),
                    selectizeInput(inputId = "scatter_var2",
                                   label = "Select Y-axis Variable",
                                   choices = options_3d,
                                   selected = "acousticness"), width = 4),
                
                # allows the user to display correlation values, for better experience with
                # the interactive scatter plot
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
                  DT::dataTableOutput("threshold"), width = 12)
              )),
      
      tabItem(tabName = "table",
              fluidRow(
                box(status = "primary",
                  DT::dataTableOutput("table"), width = 12)))
    )
  )
)