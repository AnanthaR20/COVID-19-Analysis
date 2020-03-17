source("library.R")
#######################################################################

h[[length(h)]] %>% filter(`Country/Region` ==  "US") %>% ggplot(mapping = aes(x = `Country/Region`,y = Confirmed)) +
  facet_wrap(~`Province/State`) +
  geom_bar(stat = 'identity') + coord_flip()

# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
#Exponential Rates
USrates <- c()
for(i in 1:(nrow(inUS)-1)){
  USrates[i] <- (inUS$confirms[i+1]/inUS$confirms[i])
}

USratesD <- c()
for(i in 1:(nrow(inUS)-1)){
  USratesD[i] <- (inUS$deaths[i+1]/inUS$deaths[i])
}

USratesR <- c()
for(i in 1:(nrow(inUS)-1)){
  USratesR[i] <- (inUS$recovers[i+1]/inUS$recovers[i])
}


Iranrates <- c()
for(i in 1:(nrow(inIran)-1)){
  Iranrates[i] <- (inIran$confirms[i+1]/inIran$confirms[i])
}

Italyrates <- c()
for(i in 1:(nrow(inItaly)-1)){
  Italyrates[i] <- (inItaly$confirms[i+1]/inItaly$confirms[i])
}

Chinarates <- c()
for(i in 1:(nrow(inChina)-1)){
  Chinarates[i] <- (inChina$confirms[i+1]/inChina$confirms[i])
}

Spainrates <- c()
for(i in 1:(nrow(inSpain)-1)){
  Spainrates[i] <- (inSpain$confirms[i+1]/inSpain$confirms[i])
}



ggplot(mapping = aes(x = 1:(nrow(earth)-1))) + 
  geom_line(aes(y = Italyrates), color = 'orange') +
  geom_line(aes(y = Chinarates), color = 'blue') +
  geom_line(aes(y = USrates), color = "Red") +
  geom_line(aes(y = Spainrates),color = "Black") +
  geom_line(aes(y = Iranrates), color = "Yellow")
  

