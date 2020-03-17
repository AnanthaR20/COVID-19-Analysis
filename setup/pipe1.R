# :::::::::::::::::::::::::::::::::::::::::::::: #
# Pipe in the Data from Johns Hopkins Repository #
# :::::::::::::::::::::::::::::::::::::::::::::: #
# This script creates a 'heat' list of the full available
#   timeline of the epidemic. It is the list that shows the
#   time 'under heat' so it is named 'h' and contains all the data
# At the end of this script there are a couple of function associated
#   with the way the data is structured to get useful info from it.
source("setup/library.R")

h <- list()
todayInMarch <- as.numeric(substring(date(),9,10))
count <- 1

# January
day <- 22:31
for(d in day){
  url <- str_c("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/01-",d,"-2020.csv")
  print(url)
  h[[count]] <- fread(url)
  count <- count+1
}
# February
day <- c(str_c("0",1:9),10:29)
for(d in day){
  url <- str_c("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/02-",d,"-2020.csv")
  print(url)
  h[[count]] <- fread(url)
  count <- count+1
}
# March
day <- c(str_c("0",1:9),10:(todayInMarch-1))
for(d in day){
  url <- str_c("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/03-",d,"-2020.csv")
  print(url)
  h[[count]] <- fread(url)
  count <- count+1
}

# Handle inconsistent naming convention for South Korea
for(i in 1:length(h)){
 h[[i]]$`Country/Region` <- ifelse((h[[i]]$`Country/Region` == "Korea, South" | h[[i]]$`Country/Region` == "Republic of Korea"),"South Korea",h[[i]]$`Country/Region`)
}

# Add longitude and latitude to the whole data set
lon_lat_key <- h[[length(h)]] %>% select(`Country/Region`,`Province/State`,Longitude,Latitude)

for(i in 1:length(h)){
  if(is.null(h[[i]][["Longitude"]])){
    h[[i]] <- h[[i]] %>% left_join(lon_lat_key,by = c("Country/Region","Province/State"))
  }
}

ULT <- data.frame()

for(i in 1:length(h)){
  if(is_empty(ULT)){
    ULT <- h[[i]]
  } else{
    ULT <- ULT %>% rbind(h[[i]],fill = T)
  }
}
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
# -- Functions for the 'heat' 'h' list -- #

source("setup/pipe1functions.R")
