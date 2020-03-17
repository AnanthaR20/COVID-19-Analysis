# Summary Tables #
source("setup/library.R")
source("setup/pipe1.R")

#--Summary Tables--#
# On Earth
earth <- track()

earthRecent <- earth[nrow(earth),-ncol(earth)]
colnames(earthRecent)[1] <- "Country/Region"
earthRecent[1,1] <- "---Worldwide Total---"

over1000 <- (t(0) %>% group_by(`Country/Region`) %>% 
  summarize(confirms = sum(Confirmed,na.rm = T)) %>% 
    filter(confirms > 1000))[["Country/Region"]]

allCountries <- unique((t(0) %>% group_by(`Country/Region`))[["Country/Region"]])

# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #

c <- list()
for(country in allCountries){
  c[[country]] <- track(country)
}
# Not China 
notChina <- earth - track("China")
notChina$day <- 1:nrow(notChina)
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #




