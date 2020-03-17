# Summary Tables #
source("library.R")
source("pipe1.R")

#--Summary Tables--#
# On Earth
earth <- track()

earthRecent <- earth[nrow(earth),]
colnames(earthRecent)[1] <- "Country/Region"
earthRecent[1,1] <- "---Worldwide Total---"

condition_summary <- t(0) %>% group_by(`Country/Region`) %>% 
  summarize(confirms = sum(Confirmed,na.rm = T),
            deaths = sum(Deaths,na.rm = T),
            recovers = sum(Recovered,na.rm = T),
            active = confirms - deaths - recovers) %>%
  rbind(earthRecent) %>% filter(confirms > 1000)
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
inDanger <- condition_summary$`Country/Region`[-nrow(condition_summary)]

over1000 <- list()
for(country in inDanger){
  over1000[[country]] <- track(country)
}
# Not China 
notChina <- earth - track("China")
notChina$day <- 1:nrow(notChina)
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #




