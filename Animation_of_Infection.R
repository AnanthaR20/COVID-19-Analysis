#Spread Animation:
source("Analysis.R")

# We'll need to augment the previous dataframes to include latitude and longitude
lon_lat_key <- h[[length(h)]] %>% select(`Country/Region`,`Province/State`,Longitude,Latitude)

for(i in 1:length(h)){
  if(is.null(h[[i]][["Longitude"]])){
    h[[i]] <- h[[i]] %>% left_join(lon_lat_key,by = c("Country/Region","Province/State"))
  }
}
#Generate a bunch of daily snapshots of the world and COVID-19 spread
for (i in 1:length(h)){
  
  temp_plot <- h[[i]] %>% ggplot(mapping = aes(x = Longitude, y = Latitude)) +
    geom_point(mapping = aes(size = Confirmed),alpha = 1.5,color = "red") +
    labs(title = "Spatial Map of Number of Cases Depicted as Point Size")
  
  ggsave(temp_plot, file=paste0("world_on_day_", i,".png"), width = 14, height = 10, units = "cm",path = "spread/")
}


# library(rnaturalearth)
# library(rnaturalearthdata)
# library(sf)
# world <- ne_countries(scale = 'medium',returnclass = 'sf'
