# Trends
if(!exists('s')){
  source("dataTables.R") # Calls library.R and pipe1.R
}
#On Earth
onEarth <- earth %>% tp %>% ggplot(mapping = aes(x = day,y = value)) + 
  geom_line(mapping = aes(color = `Rate Type`),size = 1) + 
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate Worldwide")

# not in China
p <- notChina %>% tp %>% ggplot(mapping = aes(x = day,color = `Rate Type`))

notInChina <- p + geom_line(mapping = aes(y = value),size = 1) + 
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate Outside China")

p + geom_line(mapping = aes(y = log(value)),size = 0.8) +
  labs(x = "Days since January 22nd 2020",
       y = "Log Number of people worldwide",
       title = "Log Increase in Infection, Recovery, and Mortatilty Rate Outside China")

# In China
inChina <- c$China %>% tp %>% ggplot(mapping = aes(x = day, color = `Rate Type`),size = 1) +
  geom_line(mapping = aes(y = value),size = 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in China")

# In US
p <- c$US %>% tp %>% ggplot(mapping = aes(x = day,color = `Rate Type`),size = 1)

inUS <- p + geom_line(mapping = aes(y = value),size = 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in US")

p + geom_line(mapping = aes(y = log(value)),size = 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Log Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in US")

# In Italy
inItaly <- c$Italy %>% tp %>% ggplot(mapping = aes(x = day,color = `Rate Type`),size = 1) +
  geom_line(mapping = aes(y = value),size = 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in Italy")

c$Italy %>% tp %>% ggplot(mapping = aes(x = day,color = `Rate Type`)) +
  geom_line(mapping = aes(y = log(value)),size = 1) +
  labs(x = "Days since January 22nd 2020",
       y = " Log Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in Italy")

# In Iran
inIran <- c$Iran %>% tp %>% ggplot(mapping = aes(x = day, color = `Rate Type`),size = 1) +
  geom_line(mapping = aes(y = (value)),size= 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection,Recovery, and Mortality Rate in Iran")
# In Wisconsin
inWI <- s$Wisconsin %>% tp %>% ggplot(mapping = aes(x = day, color = `Rate Type`),size = 1) +
  geom_line(mapping = aes(y = (value)),size= 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection,Recovery, and Mortality Rate in Wisconsin")

# :::::::::::::::::::::::::::::::::::::::::::::: #
# Over 1000

thousandPlus <- NULL
choice <- c("China","Italy","US","South Korea","Japan","Iran")

for(i in choice){
  if(is.null(thousandPlus)){
    df <- (c[[i]] %>% tp)
    colnames(df)[3] <- i
    thousandPlus <- df
  } else {
    df <- (c[[i]] %>% tp)
    colnames(df)[3] <- i
    thousandPlus <- thousandPlus %>% left_join(df,by = c('day','Rate Type'))
  }
}

comparison <- thousandPlus %>% filter(`Rate Type` == 'confirms') %>% 
  pivot_longer(cols = c(-1,-2),names_to = "country") %>%
  ggplot(mapping = aes(x = day, color = country)) +
    geom_line(mapping = aes(y = value),size = 1) +
    labs(x = "Days since Januray 22nd",
         y = "# of confirmed cases",
         title = "Several Countries Confirmed Rates Side-by-Side")




