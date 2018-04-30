library(data.table)
library(dplyr)

all_music <- fread('./all_music_attributes.csv')
all_music = select(all_music, c(-1, -2, -3, -17, -19, -24)) # getting rid of unneeded columns
all_music$genre = as.factor(all_music$genre) # setting the genres as factor to help with plotly grouping
all_music$duration_s = all_music$duration_ms / 1000 # new column for song length in seconds, easier to read

options = colnames(all_music)[c(2:9, 17)]


# creating a random sample from each genre so that the 3d plot won't look very noisy - 
metal_sub = all_music %>% filter(genre == 'metal') %>% sample_n(size = 100)
classical_sub = all_music %>% filter(genre == 'classical') %>% sample_n(size = 100)
indie_pop_sub = all_music %>% filter(genre == 'indie pop') %>% sample_n(size = 100)
indie_rock_sub = all_music %>% filter(genre == 'indie rock') %>% sample_n(size = 100)
rock_sub = all_music %>% filter(genre == 'rock') %>% sample_n(size = 100)
rap_sub = all_music %>% filter(genre == 'rap') %>% sample_n(size = 100)
hip_hop_sub = all_music %>% filter(genre == 'hip-hop') %>% sample_n(size = 100)
jazz_sub = all_music %>% filter(genre == 'jazz') %>% sample_n(size = 100)
pop_sub = all_music %>% filter(genre == 'pop') %>% sample_n(size = 100)

subset_all_music = rbind(metal_sub, classical_sub, indie_pop_sub, indie_rock_sub, 
                         rock_sub, rap_sub, hip_hop_sub, jazz_sub, pop_sub)



# Finding threshold values for each genre by taking the median of the popularity,
# then taking the median of all songs that have that popularity, to identify what would make a
# successful song per genre
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

median_stats = median_stats %>% 
  group_by(genre) %>%
  summarise_if(is.numeric, median)
