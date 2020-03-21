#Spread Animation:
source("Analysis.R")


#Generate a bunch of daily snapshots of the world and COVID-19 spread
# for (i in 1:length(h)){
#   
#   temp_plot <- h[[i]] %>% ggplot(mapping = aes(x = Longitude, y = Latitude)) +
#     geom_point(mapping = aes(size = Confirmed),alpha = 1.5,color = "red") +
#     labs(title = "Spatial Map of Number of Cases Depicted as Point Size")
#   
#   ggsave(temp_plot, file=paste0("world_on_day_", i,".png"), width = 14, height = 10, units = "cm",path = "spread/")
# }


t(0) %>% ggplot(mapping = aes(x = Longitude, y = Latitude)) +
  geom_point(mapping = aes(size = Confirmed),alpha = 1.5,color = "red") +
  labs(title = "Spatial Map of Number of Cases Depicted as Point Size")


  # library(rnaturalearth)
# library(rnaturalearthdata)
# library(sf)
# world <- ne_countries(scale = 'medium',returnclass = 'sf'
