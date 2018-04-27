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
  
  ## Reordering the dataset columns for the full dataset object
  music_table <- all_music[, c(22, 15, 14, 17, 23, 3, 2, 4, 7)]
  
  ## Reodering the dataset columns for the threshold dataset object
  median_stats <- median_stats[, c(1, 15, 19, 5, 3, 4, 8, 9, 10, 6, 13)]
  
  output$boxplot <- renderPlotly({
    plot_ly(all_music, y = ~get(input$plot_var), color = ~genre, type = "box") %>% 
      layout(yaxis = list(title = input$plot_var))
  })
  
  output$densityplot <- renderPlot({
    ggplot(data = all_music, aes_string(input$plot_var)) +
      geom_density(size = 0.75, alpha = 0.1, aes(fill = genre, color = genre)) +
      theme_bw() +
      labs(x = input$plot_var, y = "")
  })
  
  output$threeDscatter <- renderPlotly({
    plot_ly(subset_all_music, x = ~get(input$scatter_var1), y = ~get(input$scatter_var2), z = ~popularity,
            color = ~genre, key = ~full_name, height = 650, marker = list(size = 4),
            text = ~paste('Artist:', artist_name, '<br>Song:', song_name, '<br>Popularity:', popularity)) %>%
      add_markers() %>%
      layout(scene = list(zaxis = list(title = 'Popularity'),
                          xaxis = list(title = input$scatter_var1),
                          yaxis = list(title = input$scatter_var2)))
    
  })
  
  output$click <- renderPrint({
    d <- event_data("plotly_click")
    if (is.null(d)) "Click to display the song information" else d
  })
  
  output$table <- DT::renderDataTable({
    datatable(music_table, rownames = F)
  })
  
  output$threshold <- DT::renderDataTable({
    datatable(median_stats, rownames = F)
  })
  
  
  
}
)

