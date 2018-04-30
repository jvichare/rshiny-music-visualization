library(shiny)
library(plotly)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {
  
  ## Reordering the dataset columns for the full dataset object
  music_table <- all_music[, c(22, 15, 14, 17, 23, 3, 2, 4, 7)]
  
  ## Reodering the dataset columns for the threshold dataset object
  median_stats <- median_stats[, c(1, 15, 19, 5, 3, 4, 8, 9, 10, 6, 13)]
  
  # plotly box and whisker plot with user input for the y-axis
  output$boxplot <- renderPlotly({
    plot_ly(all_music, y = ~get(input$plot_var), color = ~genre, type = "box") %>% 
      layout(yaxis = list(title = input$plot_var))
  })
  
  # ggplot density plot with user input for the axis variable
  output$densityplot <- renderPlotly({
    dens = ggplot(data = all_music, aes_string(input$plot_var)) + 
      geom_density(alpha = 0.3, aes(fill = genre, color = genre)) + 
      xlab(lab = input$plot_var) + 
      theme(legend.title=element_blank())
    
    ggplotly(dens)
  })
  
  # plotly 3d scatter plot, taking user input for the x and y-axis, keeping z-axis fixed on popularity
  output$threeDscatter <- renderPlotly({
    plot_ly(subset_all_music, x = ~get(input$scatter_var1), y = ~get(input$scatter_var2), z = ~popularity,
            color = ~genre, key = ~full_name, height = 650, marker = list(size = 4),
            text = ~paste('Artist:', artist_name, '<br>Song:', song_name, '<br>Popularity:', popularity)) %>%
      add_markers() %>%
      layout(scene = list(zaxis = list(title = 'Popularity'),
                          xaxis = list(title = input$scatter_var1),
                          yaxis = list(title = input$scatter_var2)))
    
  })
  
  # a text box to go with the 3d plot to store information once user clicks on a data point
  output$click <- renderPrint({
    d <- event_data("plotly_click")
    if (is.null(d)) "Click to display the song information" else d
  })
  
  # the full dataset so the user can search through and look at all possible values if necessary
  output$table <- DT::renderDataTable({
    datatable(music_table, rownames = F)
  })
  
  # data table containing the median values to achieve 50th percentile popularity in each genre
  output$threshold <- DT::renderDataTable({
    datatable(median_stats, rownames = F)
  })
  
  # data table containing the correlation between specified variable to popularity
  output$corr_tbl <- DT::renderDataTable({
    datatable(corr_df, rownames = T)
  })
  
  
  
}
)

