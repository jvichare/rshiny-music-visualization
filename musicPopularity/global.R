library(data.table)
library(dplyr)

all_music <- fread('./all_music_attributes.csv')
all_music = select(all_music, c(-1, -2, -3, -17, -19, -24)) # getting rid of unneeded columns
all_music$genre = as.factor(all_music$genre)

# creating a random sample from each genre so that the 3d plot won't look very noisy - 
metal_sub = all_music %>% filter(genre == 'metal') %>% sample_n(size = 50)
classical_sub = all_music %>% filter(genre == 'classical') %>% sample_n(size = 50)
indie_pop_sub = all_music %>% filter(genre == 'indie pop') %>% sample_n(size = 50)
indie_rock_sub = all_music %>% filter(genre == 'indie rock') %>% sample_n(size = 50)
rock_sub = all_music %>% filter(genre == 'rock') %>% sample_n(size = 50)
rap_sub = all_music %>% filter(genre == 'rap') %>% sample_n(size = 50)
hip_hop_sub = all_music %>% filter(genre == 'hip-hop') %>% sample_n(size = 50)
jazz_sub = all_music %>% filter(genre == 'jazz') %>% sample_n(size = 50)
pop_sub = all_music %>% filter(genre == 'pop') %>% sample_n(size = 50)

subset_all_music = rbind(metal_sub, classical_sub, indie_pop_sub, indie_rock_sub, 
                         rock_sub, rap_sub, hip_hop_sub, jazz_sub, pop_sub)
