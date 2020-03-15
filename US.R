source("Analysis.R")

states <- c()
for(i in 1:length(h)){
  states[[i]] <- h[[i]] %>% filter(grepl("US",`Country/Region`))
}

terr <- unique(states[[length(states)]][["Province/State"]])


#Vars to be used for creating a data.frame for all the states
inStates <- data.frame()
currentState <- data.frame()
currTerr <- NULL
for(j in 1:length(terr)){
  
  currTerr <- terr[j]
  currentState <- data.frame()
  
  for(i in states){
    if(is_empty(currentState)){
      currentState <- i %>% filter(grepl(terr[j],i[['Province/State']])) %>%  summarize(confirms = sum(Confirmed,na.rm = T),
                                                                                    deaths = sum(Deaths,na.rm = T),
                                                                                    recovers = sum(Recovered,na.rm = T))%>% 
        mutate(active = confirms - deaths - recovers)
    } else{
      currentState <- currentState %>% rbind(i %>% filter(grepl(terr[j],i[['Province/State']])) %>% 
                               summarize(confirms = sum(Confirmed,na.rm = T),
                                         deaths = sum(Deaths,na.rm = T),
                                         recovers = sum(Recovered,na.rm = T)) %>% 
                               mutate(active = confirms - deaths - recovers))
    }
  }

  currentState <- currentState %>% mutate(day = 1:nrow(currentState))
  currentState <- currentState %>% select(day,confirms,deaths,recovers,active)
  plottable <- currentState %>% pivot_longer(cols = c("confirms","deaths","recovers","active"),names_to = "Rate Type")
  
  if(is_empty(inStates)){
    inStates <- plottable %>% mutate(state = currTerr)
  } else {
    inStates <- inStates %>% rbind(plottable %>% mutate(state = currTerr))
  }
    
}


# So now 'inStates' is a data frame for plotting the active cases curve for
# all states in the United States
notinStates <- c("District of Columbia","Puerto Rico","Virgin Islands, U.S.","Diamond Princess","Grand Princess")
nifty50 <- inStates %>% filter(!state %in% notinStates)

nifty50 %>% ggplot(mapping = aes(x = day, color = `Rate Type`)) +
  facet_wrap(~state) +
  geom_line(mapping = aes(y = value))




