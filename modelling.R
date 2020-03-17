source("Analysis.R")

fit <- nls(confirms ~ SSlogis(day, Asym, xmid, scal), data = inChina)
mChina <- predict(fit) 
projectChina <- inChina %>% mutate(fit = predict(fit))

projectChina <- projectChina %>% pivot_longer(cols = c("confirms","deaths","recovers","active"),names_to = "Rate Type")

projectChina %>% ggplot(mapping = aes(x = day,color = `Rate Type`))+
  geom_line(mapping = aes(y = value)) +
  geom_line(mapping = aes(y = fit),color = 'black') +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in China")

# US
projectUS <- inUS %>% mutate(fit = predict(fit))
projectUS <- projectUS %>% pivot_longer(cols = c("confirms","deaths","recovers","active"),names_to = "Rate Type")

projectUS %>% ggplot(mapping = aes(x = day,color = `Rate Type`)) + 
  geom_line(mapping = aes(y = value),size = 1) +
  #geom_line(mapping = aes(y = fit)) +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in US")
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #


# Asym/(1+exp((xmid-input)/scal))
sig <- function(x,parameters = c(Asymp,xmid,scal)){
  
}
