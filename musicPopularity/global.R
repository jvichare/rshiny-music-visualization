library(data.table)
library(dplyr)

all_music <- fread('./all_music_attributes.csv')
all_music = select(all_music, c(-1, -2, -3, -17, -19, -24)) # getting rid of unneeded columns
all_music$genre = as.factor(all_music$genre) # setting the genres as factor to help with plotly grouping
all_music$duration_s = all_music$duration_ms / 1000 # new column for song length in seconds, easier to read

options = colnames(all_music)[c(2:9, 17)]


# creating a random sample from each genre so that the 3d plot won't look very noisy - 
subset_all_music = all_music %>% 
  group_by(genre) %>% 
  sample_n(100)

# Finding threshold values for each genre by taking the median of the popularity,
# then taking the median of all songs that have that popularity, to identify what would make a
# successful song per genre
median_tracks = all_music %>% 
  group_by(genre) %>% 
  filter(popularity == median(popularity))

median_stats = median_tracks %>% 
  group_by(genre) %>%
  summarise_if(is.numeric, median)

# Displaying a table of the correlation values to give the user an idea of what variables would display
# the largest change for the scatter plot page
corr_values = c(cor(all_music$duration_ms, all_music$popularity), cor(all_music$acousticness, all_music$popularity), 
                cor(all_music$danceability, all_music$popularity), cor(all_music$energy, all_music$popularity), 
                cor(all_music$instrumentalness, all_music$popularity), cor(all_music$liveness, all_music$popularity), 
                cor(all_music$loudness, all_music$popularity), cor(all_music$valence, all_music$popularity), 
                cor(all_music$speechiness, all_music$popularity))

corr_rnames = c('Duration', 'Acousticness', 'Danceability', 'Energy', 'Instrumentalness', 'Liveness',
                'Loudness', 'Valence', 'Speechiness')

corr_df = data.frame(Correlation = corr_values, row.names = corr_rnames)