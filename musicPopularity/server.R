#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {
  
  ## Reordering the dataset columns for the DT::renderDataTable object
  music_table <- all_music[, c(22, 15, 14, 17, 23, 3, 2, 4, 7)]
  
  output$boxplot <- renderPlotly({
    plot_ly(all_music, y = ~popularity, color = ~genre, type = "box") %>% 
      layout(title = "Popularity by Genre Box Plot")
  })
  
  output$densityplot <- renderPlot({
    ggplot(data = all_music, aes(popularity)) +
      geom_density(size = 0.75, alpha = 0.1, aes(fill = genre, color = genre)) +
      theme_bw() +
      ggtitle("Density of Popularity by Genre")
  })
  
  output$threeDscatter <- renderPlotly({
    plot_ly(subset_all_music, x = ~danceability, y = ~acousticness, z = ~popularity,
            color = ~genre, height = 700, width = 1000,
            text = ~paste('Artist:', artist_name, '<br>Song:', song_name, 
                          '<br>Danceability:', danceability,'<br>Acousticness:', energy, 
                          '<br>Pop.:', popularity)) %>%
      add_markers() %>%
      layout(scene = list(xaxis = list(title = 'Danceability'),
                          yaxis = list(title = 'Acousticness'),
                          zaxis = list(title = 'Popularity')))
    
  })
  
  output$table <- DT::renderDataTable({
    datatable(music_table, rownames = F)
  })
  
  
}
)

