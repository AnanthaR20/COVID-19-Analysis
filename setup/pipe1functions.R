# ::::::::::Functions for use :::::::::: #
# This script must be run at the end of 'pipe1.R'
# to initialize the functions properly
# ::::::::::::::::::::::::::::::::::::: #


#--Time Slice Function--#
# returns data from t days ago
#
t <- function(days = 0){
  return(h[[length(h)-days]])
}


#--Add Incidence Function--#
# returns df with an incidence column
addIncidence <- function(df){
  for(i in 1:nrow(df)){
    if(i == 1){df$incidence[i] <- df$confirms[i]}
    else {
      df$incidence[i] <- df$confirms[i]-df$confirms[i-1]
    }
  }
  return(df)
}

#--'To Plottable' Formatting Function--#
# Takes data frames made by *Tracking Function* and
# puts them into a plottable format for ggplot
tp <- function(df){
  return(df %>% pivot_longer(cols = c("confirms","deaths","recovers","active","incidence"),names_to = "Rate Type"))
}


#--Tracking Function--# 
# For any un/specified location 
# Requires source("pipe1.R") to be run
# Creates a day by day summary table for a given location
# returns a list( 1 data.frame with nrow = days, 1 plottable df)
#
track <- function(location = 'earth'){
  countryList <- unique(union(t()[["Country/Region"]],h[[1]][["Country/Region"]]))
  stateList <- unique(union(t()[["Province/State"]],h[[1]][["Province/State"]]))
  geopol <- NULL
  
  if(location %in% countryList){
    geopol <- "Country/Region"
  } 
  else if(location %in% stateList){
    geopol <- "Province/State"
  } 
  else if(location == 'earth'){
    df <- data.frame()
    for(i in h){
      if(is_empty(df)){
        df <- i %>% summarize(confirms = sum(Confirmed,na.rm = T),
                              deaths = sum(Deaths,na.rm = T),
                              recovers = sum(Recovered,na.rm = T)) %>% 
          mutate(active = confirms - deaths - recovers)
      } else {
        df <- df %>% rbind(i %>% summarize(confirms = sum(Confirmed,na.rm = T),
                                           deaths = sum(Deaths,na.rm = T),
                                           recovers = sum(Recovered,na.rm = T)) %>% 
                             mutate(active = confirms - deaths - recovers))
      }
    }
    
    df <- df %>% mutate(day = 1:nrow(df)) %>%
      select(day,confirms,deaths,recovers,active) %>% 
      addIncidence()
    return(df)
  } 
  else {
    print("No data on this location yet --OR-- Type the location differently")
    View(countryList)
    View(stateList)
    return(NULL)
  }
  
  # Looking for and returning a particular location
  df <- data.frame()
  for(i in h){
    if(is_empty(df)){
      df <- i %>% filter(grepl(location,i[[geopol]])) %>% 
        summarize(confirms = sum(Confirmed,na.rm = T),
                  deaths = sum(Deaths,na.rm = T),
                  recovers = sum(Recovered,na.rm = T)) %>% 
        mutate(active = confirms - deaths - recovers)
    } else{
      df <- df %>% rbind(i %>% filter(grepl(location,i[[geopol]])) %>% 
                           summarize(confirms = sum(Confirmed,na.rm = T),
                                     deaths = sum(Deaths,na.rm = T),
                                     recovers = sum(Recovered,na.rm = T)) %>% 
                           mutate(active = confirms - deaths - recovers))
    }
  }
  
  df <- df %>% mutate(day = 1:nrow(df)) %>% 
    select(day,confirms,deaths,recovers,active) %>% 
    addIncidence()
  return(df)
}




