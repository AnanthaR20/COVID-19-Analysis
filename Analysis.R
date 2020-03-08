library(tidyverse)
library(data.table)

d <- fread("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/03-05-2020.csv") 


d %>% filter(grepl("Africa",`Country/Region`)) -> Africa

# 706 Confirmed cases
d %>% filter(grepl("Others",`Country/Region`)) -> a


d %>% filter(grepl("India",`Country/Region`))-> India

d %>% ggplot(mapping = aes(x = Longitude,y = Confirmed)) +
  geom_point() +
  geom_smooth(method = 'lm')




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
day <- str_c("0",1:(todayInMarch-1))
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

View(ULT)


h[[length(h)]] %>% filter(`Country/Region` ==  "US") %>% ggplot(mapping = aes(x = `Country/Region`,y = Confirmed)) +
  facet_wrap(~`Province/State`) +
  geom_bar(stat = 'identity') + coord_flip()

#######################################################################
# #separate days
#  for(i in 1:length(h)){
#    h[[i]] <- h[[i]] %>% cbind(day = i)
#  }


# Get a summary table of the increasing number of cases day by day #
a <- data.frame()
for(i in h){
  if(is_empty(a)){
    a <- i %>% summarize(confirms = sum(Confirmed,na.rm = T),
                         deaths = sum(Deaths,na.rm = T),
                         recovers = sum(Recovered,na.rm = T))
  } else{
    a <- a %>% rbind(i %>% summarize(confirms = sum(Confirmed,na.rm = T),
                                     deaths = sum(Deaths,na.rm = T),
                                     recovers = sum(Recovered,na.rm = T)))
  }
}
a <- a %>% mutate(day = 1:nrow(a))
a <- a %>% select(day,confirms,deaths,recovers)
b <- a %>% pivot_longer(cols = c("confirms","deaths","recovers"),names_to = "Rate Type")
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #

p <- b %>% ggplot(mapping = aes(x = day,y = value))

p + geom_line(mapping = aes(color = `Rate Type`),size = 1) + 
  labs(x = "Days since January 22nd 2020",
       y = "Number of people worldwide",
       title = "Increase in Infection, Recovery, and Mortatilty Rate")


























