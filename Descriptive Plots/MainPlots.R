# Trends

source("summaryTables.R") # Calls library.R and pipe1.R

#On Earth
earth %>% tp %>% ggplot(mapping = aes(x = day,y = value)) + 
  geom_line(mapping = aes(color = `Rate Type`),size = 1) + 
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate Worldwide")

# not in China
p <- notChina %>% tp %>% ggplot(mapping = aes(x = day,color = `Rate Type`))

p + geom_line(mapping = aes(y = value),size = 1) + 
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate Outside China")

p + geom_line(mapping = aes(y = log(value)),size = 0.8) +
  labs(x = "Days since January 22nd 2020",
       y = "Log Number of people worldwide",
       title = "Log Increase in Infection, Recovery, and Mortatilty Rate Outside China")

# In China
c$China %>% tp %>% ggplot(mapping = aes(x = day, color = `Rate Type`)) +
  geom_line(mapping = aes(y = value),size = 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in China")

# In US
p <- c$US %>% tp %>% ggplot(mapping = aes(x = day,color = `Rate Type`))

p + geom_line(mapping = aes(y = value),size = 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in US")

p + geom_line(mapping = aes(y = log(value)),size = 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Log Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in US")

# In Italy
over1000$Italy %>% tp %>% ggplot(mapping = aes(x = day,color = `Rate Type`)) +
  geom_line(mapping = aes(y = value),size = 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in Italy")

over1000$Italy %>% tp %>% ggplot(mapping = aes(x = day,color = `Rate Type`)) +
  geom_line(mapping = aes(y = log(value)),size = 1) +
  labs(x = "Days since January 22nd 2020",
       y = " Log Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in Italy")

# In Iran
over1000$Iran %>% tp %>% ggplot(mapping = aes(x = day, color = `Rate Type`)) +
  geom_line(mapping = aes(y = (value)),size= 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection,Recovery, and Mortality Rate in Iran")
# In Wisconsin
track("Wisconsin") %>% tp %>% ggplot(mapping = aes(x = day, color = `Rate Type`)) +
  geom_line(mapping = aes(y = (value)),size= 1) +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection,Recovery, and Mortality Rate in Wisconsin")


