library(dplyr)
library(data.table)
library(ggplot2)
library(car)
library(MASS)

all_music = fread("./rshiny-music-visualization/musicPopularity/all_music_attributes.csv",
                  stringsAsFactors = F,
                  header = T)
all_music = select(all_music, -1) # generated row number V1 column, selecting it out

metal = all_music %>% filter(genre == 'metal')

metal_numeric = select(metal, c(17, 19, 21, 3:10))

model.saturated = lm(popularity ~
                       duration_ms + energy + danceability + instrumentalness + loudness,
                     data = metal)
metal_model = summary(model.saturated)
