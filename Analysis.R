library(tidyverse)
library(data.table)
# 
# d <- fread("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/03-05-2020.csv") 
# 
# 
# d %>% filter(grepl("Africa",`Country/Region`)) -> Africa
# 
# # 706 Confirmed cases
# d %>% filter(grepl("Others",`Country/Region`)) -> a
# 
# 
# d %>% filter(grepl("India",`Country/Region`))-> India
# 
# d %>% ggplot(mapping = aes(x = Longitude,y = Confirmed)) +
#   geom_point() +
#   geom_smooth(method = 'lm')
# 


####################################################################3333333333
# downloads all data from 1-22-2020 to 3-5-2020
h <- list()
todayInMarch <- as.numeric(substring(date(),9,10))

day <- 22:31
count <- 1
for(d in day){
  url <- str_c("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/01-",d,"-2020.csv")
  print(url)
  h[[count]] <- fread(url)
  count <- count+1
}
day <- c(str_c("0",1:9),10:29)
for(d in day){
  url <- str_c("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/02-",d,"-2020.csv")
  print(url)
  h[[count]] <- fread(url)
  count <- count+1
}
day <- c(str_c("0",1:9),10:(todayInMarch-1))
for(d in day){
  url <- str_c("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/03-",d,"-2020.csv")
  print(url)
  h[[count]] <- fread(url)
  count <- count+1
}


ULT <- data.frame()

for(i in 1:length(h)){
  if(is_empty(ULT)){
    ULT <- h[[i]]
  } else{
    ULT <- ULT %>% rbind(h[[i]],fill = T)
  }
}

#######################################################################
# Get a summary table of the increasing number of cases day by day #
# On Earth
earth <- data.frame()
for(i in h){
  if(is_empty(earth)){
    earth <- i %>% summarize(confirms = sum(Confirmed,na.rm = T),
                         deaths = sum(Deaths,na.rm = T),
                         recovers = sum(Recovered,na.rm = T))
  } else{
    earth <- earth %>% rbind(i %>% summarize(confirms = sum(Confirmed,na.rm = T),
                                     deaths = sum(Deaths,na.rm = T),
                                     recovers = sum(Recovered,na.rm = T)))
  }
}
earth <- earth %>% mutate(day = 1:nrow(earth))
earth <- earth %>% select(day,confirms,deaths,recovers)
worldwide <- earth %>% pivot_longer(cols = c("confirms","deaths","recovers"),names_to = "Rate Type")
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# Not China
notChina <- data.frame()
for(i in h){
  if(is_empty(notChina)){
    notChina <- i %>% filter(!grepl("China",i[['Country/Region']])) %>%  summarize(confirms = sum(Confirmed,na.rm = T),
                                                                                   deaths = sum(Deaths,na.rm = T),
                                                                                   recovers = sum(Recovered,na.rm = T))
  } else{
    notChina <- notChina %>% rbind(i %>% filter(!grepl("China",i[['Country/Region']])) %>% 
                                     summarize(confirms = sum(Confirmed,na.rm = T),
                                               deaths = sum(Deaths,na.rm = T),
                                               recovers = sum(Recovered,na.rm = T)))
  }
}

notChina <- notChina %>% mutate(day = 1:nrow(notChina))
notChina <- notChina %>% select(day,confirms,deaths,recovers)
nC <- notChina %>% pivot_longer(cols = c("confirms","deaths","recovers"),names_to = "Rate Type")
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# In China
inChina <- data.frame()
for(i in h){
  if(is_empty(inChina)){
    inChina <- i %>% filter(grepl("China",i[['Country/Region']])) %>%  summarize(confirms = sum(Confirmed,na.rm = T),
                                                                                   deaths = sum(Deaths,na.rm = T),
                                                                                   recovers = sum(Recovered,na.rm = T))
  } else{
    inChina <- inChina %>% rbind(i %>% filter(grepl("China",i[['Country/Region']])) %>% 
                                     summarize(confirms = sum(Confirmed,na.rm = T),
                                               deaths = sum(Deaths,na.rm = T),
                                               recovers = sum(Recovered,na.rm = T)))
  }
}

inChina <- inChina %>% mutate(day = 1:nrow(inChina))
inChina <- inChina %>% select(day,confirms,deaths,recovers)
china <- inChina %>% pivot_longer(cols = c("confirms","deaths","recovers"),names_to = "Rate Type")
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# In US
inUS <- data.frame()
for(i in h){
  if(is_empty(inUS)){
    inUS <- i %>% filter(grepl("US",i[['Country/Region']])) %>%  summarize(confirms = sum(Confirmed,na.rm = T),
                                                                                   deaths = sum(Deaths,na.rm = T),
                                                                                   recovers = sum(Recovered,na.rm = T))
  } else{
    inUS <- inUS %>% rbind(i %>% filter(grepl("US",i[['Country/Region']])) %>% 
                                     summarize(confirms = sum(Confirmed,na.rm = T),
                                               deaths = sum(Deaths,na.rm = T),
                                               recovers = sum(Recovered,na.rm = T)))
  }
}

inUS <- inUS %>% mutate(day = 1:nrow(inUS))
inUS <- inUS %>% select(day,confirms,deaths,recovers)
domestic <- inUS %>% pivot_longer(cols = c("confirms","deaths","recovers"),names_to = "Rate Type")
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# In Italy
inItaly <- data.frame()
for(i in h){
  if(is_empty(inItaly)){
    inItaly <- i %>% filter(grepl("Italy",i[['Country/Region']])) %>%  summarize(confirms = sum(Confirmed,na.rm = T),
                                                                           deaths = sum(Deaths,na.rm = T),
                                                                           recovers = sum(Recovered,na.rm = T))
  } else{
    inItaly <- inItaly %>% rbind(i %>% filter(grepl("Italy",i[['Country/Region']])) %>% 
                             summarize(confirms = sum(Confirmed,na.rm = T),
                                       deaths = sum(Deaths,na.rm = T),
                                       recovers = sum(Recovered,na.rm = T)))
  }
}

inItaly <- inItaly %>% mutate(day = 1:nrow(inItaly))
inItaly <- inItaly %>% select(day,confirms,deaths,recovers)
domesticItaly <- inItaly %>% pivot_longer(cols = c("confirms","deaths","recovers"),names_to = "Rate Type")
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# In Iran
inIran <- data.frame()
for(i in h){
  if(is_empty(inIran)){
    inIran <- i %>% filter(grepl("Iran",i[['Country/Region']])) %>%  summarize(confirms = sum(Confirmed,na.rm = T),
                                                                                 deaths = sum(Deaths,na.rm = T),
                                                                                 recovers = sum(Recovered,na.rm = T))
  } else{
    inIran <- inIran %>% rbind(i %>% filter(grepl("Iran",i[['Country/Region']])) %>% 
                                   summarize(confirms = sum(Confirmed,na.rm = T),
                                             deaths = sum(Deaths,na.rm = T),
                                             recovers = sum(Recovered,na.rm = T)))
  }
}

inIran <- inIran %>% mutate(day = 1:nrow(inIran))
inIran <- inIran %>% select(day,confirms,deaths,recovers)
domesticIran <- inIran %>% pivot_longer(cols = c("confirms","deaths","recovers"),names_to = "Rate Type")
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# In Wisco
inWI <- data.frame()
for(i in h){
  if(is_empty(inWI)){
    inWI <- i %>% filter(grepl("Wisconsin",i[['Province/State']])) %>%  summarize(confirms = sum(Confirmed,na.rm = T),
                                                                               deaths = sum(Deaths,na.rm = T),
                                                                               recovers = sum(Recovered,na.rm = T))
  } else{
    inWI <- inWI %>% rbind(i %>% filter(grepl("Wisconsin",i[['Province/State']])) %>% 
                                 summarize(confirms = sum(Confirmed,na.rm = T),
                                           deaths = sum(Deaths,na.rm = T),
                                           recovers = sum(Recovered,na.rm = T)))
  }
}

inWI <- inWI %>% mutate(day = 1:nrow(inIran))
inWI <- inWI %>% select(day,confirms,deaths,recovers)
wisconsin <- inWI %>% pivot_longer(cols = c("confirms","deaths","recovers"),names_to = "Rate Type")
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #

h[[length(h)]] %>% filter(`Country/Region` ==  "US") %>% ggplot(mapping = aes(x = `Country/Region`,y = Confirmed)) +
  facet_wrap(~`Province/State`) +
  geom_bar(stat = 'identity') + coord_flip()

# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
### Plots of confirms,deaths, and recovers in specific areas###################################################
# Worldwide
worldwide %>% ggplot(mapping = aes(x = day,y = value)) + 
  geom_line(mapping = aes(color = `Rate Type`),size = 1) + 
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate Worldwide")

# not in China
p <- nC %>% ggplot(mapping = aes(x = day,color = `Rate Type`))

p + geom_line(mapping = aes(y = value),size = 1) + 
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate Outside China")

p + geom_line(mapping = aes(y = log(value)),size = 0.8) +
  labs(x = "Days since January 22nd 2020",
       y = "Log Number of people worldwide",
       title = "Log Increase in Infection, Recovery, and Mortatilty Rate Outside China")

# In China
china %>% ggplot(mapping = aes(x = day, color = `Rate Type`)) +
  geom_line(mapping = aes(y = value),size = 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in China")

# In US
p <- domestic %>% ggplot(mapping = aes(x = day,color = `Rate Type`))

p + geom_line(mapping = aes(y = value),size = 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in US")

p + geom_line(mapping = aes(y = log(value)),size = 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Log Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in US")

# In Italy
domesticItaly %>% ggplot(mapping = aes(x = day,color = `Rate Type`)) +
  geom_line(mapping = aes(y = value),size = 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in Italy")

domesticItaly %>% ggplot(mapping = aes(x = day,color = `Rate Type`)) +
  geom_line(mapping = aes(y = log(value)),size = 1) +
  labs(x = "Days since January 22nd 2020",
       y = " Log Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in Italy")

# In Iran
domesticIran %>% ggplot(mapping = aes(x = day, color = `Rate Type`)) +
  geom_line(mapping = aes(y = log(value)),size= 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection,Recovery, and Mortality Rate in Iran")
# In Wisconsin
wisconsin %>% ggplot(mapping = aes(x = day, color = `Rate Type`)) +
  geom_line(mapping = aes(y = log(value)),size= 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection,Recovery, and Mortality Rate in Wisconsin")

#Exponential Rates
USrates <- c()
for(i in 1:(nrow(inUS)-1)){
  USrates[i] <- (inUS$confirms[i+1]/inUS$confirms[i])
}

#Active Cases
h[[length(h)]] %>% group_by(`Country/Region`) %>% 
  summarize(confirms = sum(Confirmed,na.rm = T),
            deaths = sum(Deaths,na.rm = T),
            recovers = sum(Recovered,na.rm = T)) %>% 
  mutate(active = confirms-deaths-recovers) %>% 
  filter(confirms > 1000) %>% View





