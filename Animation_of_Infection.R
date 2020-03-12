#Spread Animation:
source("Analysis.R")


for(i in 1:length(h)){
  h[[i]] %>% ggplot(mapping = aes(x = Longitude, y = Latitude)) +
    geom_point(mapping = aes(size = Confirmed),alpha = 1.5,color = "red") +
    labs(title = str_c("Spatial Map of # Confirmed Cases Depicted as Point Size Day ",i))
}



h[[length(h)]] %>% ggplot(mapping = aes(x = Longitude, y = Latitude)) +
  geom_point(mapping = aes(size = Confirmed),alpha = 1.5,color = "red") +
  labs(title = "Spatial Map of Number of Cases Depicted as Point Size")






