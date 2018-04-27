library(dplyr)
library(data.table)
library(ggplot2)
library(plotly)
library(rgl)
library(car)
library(scatterplot3d)

setwd("~/Documents/NYCDSA/shiny_project/")

music_attributes <- lapply(Sys.glob("./*_3000.csv"), 
                           fread, 
                           stringsAsFactors = F, 
                           header = T)

genre_vec = c('classical', 'hip-hop', 'indie pop', 'indie rock', 'jazz', 'metal', 'pop', 'rap', 'rock')

all_music = music_attributes[[1]] %>% mutate(genre = genre_vec[1])
  
for (i in 2:length(music_attributes)) {
  temp_data = music_attributes[[i]] %>%
    mutate(genre = genre_vec[i])
  all_music = rbind(all_music, temp_data)
}

names(all_music)

write.csv(all_music, file = "all_music_attributes.csv")

all_music = fread("./all_music_attributes.csv", stringsAsFactors = F, header = T, )
all_music = select(all_music, -1) # generated row number V1 column, selecting it out

# to do -
# correlate certain musical attributes with popularity, i.e. what makes Drake so popular
## extend this to each genre too
# look at popularity at velence (0 = sad song, 1 = happy song), like how do you make a popular sad song?
# scatter plot with all genres, colored by genre, finding areas that bleed into each other

ggplot(data = all_music, aes(x = tempo_norm, y = valence)) +
  geom_point(size = 0.5, aes(color = genre))

ggplot(data = all_music, aes(energy)) +
  geom_density(alpha = 0.05, aes(fill = genre, color = genre)) +
  scale_fill_brewer(palette = "Spectral")



box_p <- plot_ly(all_music, y = ~popularity, color = ~genre, type = "box")





# num colors for groups = 7 max, have to subset, then factor the genres - 
subset = filter(all_music, genre == 'metal'| genre == 'hip-hop' | genre == 'pop')
subset$genre = as.factor(subset$genre)

scatter3d(x = subset$energy, y = subset$tempo, z = subset$popularity, groups = subset$genre,
          surface=FALSE, ellipsoid = TRUE, ellipsoid.alpha = 0.01)



b = ggplot(data = all_music, aes(x = genre, y = popularity_norm)) + geom_boxplot()
bp = ggplotly(b)
bp



# # subset 3d plot
# subset_p <- plot_ly(subset, x = ~energy, y = ~tempo, z = ~popularity, 
#              size = ~popularity, color = ~genre, text = ~full_name,
#              colors = c('red', 'blue', 'green')) %>%
#   add_markers() %>%
#   layout(scene = list(xaxis = list(title = 'Energy'),
#                       yaxis = list(title = 'Tempo'),
#                       zaxis = list(title = 'Popularity')))

# full 3d plot
all_p <- plot_ly(all_music, x = ~energy, y = ~tempo, z = ~popularity, 
                 size = ~popularity, color = ~genre, colors = 'YlGnBu', 
                 text = ~paste('Artist:', artist_name, '<br>Song:', song_name, '<br>Tempo:', tempo,
                               '<br>Energy:', energy, '<br>Pop.:', popularity)) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Energy'),
                      yaxis = list(title = 'Tempo'),
                      zaxis = list(title = 'Popularity')))

## Correlation values to popularity
cor(all_music$duration_ms, all_music$popularity) # -0.2335363
cor(all_music$acousticness, all_music$popularity) # -0.4420549
cor(all_music$danceability, all_music$popularity) # 0.5098558
cor(all_music$energy, all_music$popularity) # 0.3308283
cor(all_music$instrumentalness, all_music$popularity) #0.4491173
cor(all_music$liveness, all_music$popularity) # -0.01378942
cor(all_music$loudness, all_music$popularity) # 0.4500575
cor(all_music$valence, all_music$popularity) # 0.2406122
cor(all_music$speechiness, all_music$popularity) #0.2653365
cor(all_music$key, all_music$popularity) # 0.007946865
cor(all_music$mode, all_music$popularity) # -0.01787605
cor(all_music$tempo, all_music$popularity) # 0.09590416

## generating subsets of the data - 
metal = all_music %>% filter(genre == 'metal')
classical = all_music %>% filter(genre == 'classical')
indie_pop = all_music %>% filter(genre == 'indie pop')
indie_rock = all_music %>% filter(genre == 'indie rock')
rock = all_music %>% filter(genre == 'rock')
rap = all_music %>% filter(genre == 'rap')
hip_hop = all_music %>% filter(genre == 'hip-hop')
jazz = all_music %>% filter(genre == 'jazz')
pop = all_music %>% filter(genre == 'pop')

metal_sub = sample_n(metal, size = 50)
classical_sub = sample_n(classical, size = 50)
indie_pop_sub = sample_n(indie_pop, size = 50)
indie_rock_sub = sample_n(indie_rock, size = 50)
rock_sub = sample_n(rock, size = 50)
rap_sub = sample_n(rap, size = 50)
hip_hop_sub = sample_n(hip_hop, size = 50)
jazz_sub = sample_n(jazz, size = 50)
pop_sub = sample_n(pop, size = 50)

subset = rbind(metal_sub, classical_sub, indie_pop_sub, indie_rock_sub, 
               rock_sub, rap_sub, hip_hop_sub, jazz_sub, pop_sub)

# to change the genres shown in the subset - 
filter(subset, genre %in% c('rap', 'hip-hop'))

# subset 3d plot - 
subset_p <- plot_ly(subset_all_music, x = ~danceability, y = ~acousticness, z = ~popularity,
                    color = ~genre,
                    text = ~paste('Artist:', artist_name, '<br>Song:', song_name, 
                                  '<br>Danceability:', danceability,'<br>Acousticness:', energy, 
                                  '<br>Pop.:', popularity)) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Danceability'),
                      yaxis = list(title = 'Acousticness'),
                      zaxis = list(title = 'Popularity')))


# plotly box and whiskers
box_p <- plot_ly(all_music, y = ~popularity, color = ~genre, type = "box")

# density
dens = ggplot(data = all_music, aes(popularity)) +
  geom_density(size = 0.75, alpha = 0.1, aes(fill = genre, color = genre)) +
  theme_bw() # + 
  # scale_color_brewer(palette = "Spectral") +
  # scale_fill_brewer(palette = 'Spectral')

densp = ggplotly(dens)

metal_median = filter(all_music, genre == 'metal') %>% filter(popularity == median(popularity))
rap_median = filter(all_music, genre == 'rap') %>% filter(popularity == median(popularity))
hip_hop_median = filter(all_music, genre == 'hip-hop') %>% filter(popularity == median(popularity))
indie_pop_median = filter(all_music, genre == 'indie pop') %>% filter(popularity == median(popularity))
pop_median = filter(all_music, genre == 'pop') %>% filter(popularity == median(popularity))
indie_rock_median = filter(all_music, genre == 'indie rock') %>% filter(popularity == median(popularity))
rock_median = filter(all_music, genre == 'rock') %>% filter(popularity == median(popularity))
jazz_median = filter(all_music, genre == 'jazz') %>% filter(popularity == median(popularity))
classical_median = filter(all_music, genre == 'classical') %>% filter(popularity == median(popularity))

median_stats = rbind(metal_median, rap_median, hip_hop_median, indie_pop_median, pop_median,
                     indie_rock_median, rock_median, jazz_median, classical_median)

median_stats = median_stats %>% group_by(genre) %>% select_if(is.numeric) %>% summarise_all(median)
