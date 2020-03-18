source("Analysis.R")

fit <- nls(confirms ~ SSlogis(day, Asym, xmid, scal), data = c$China)
projectChina <- c$China %>% mutate(fit = predict(fit))


projectChina %>% tp %>% ggplot(mapping = aes(x = day,color = `Rate Type`))+
  geom_line(mapping = aes(y = value)) +
  geom_line(mapping = aes(y = fit),color = 'black') +
  labs(x = "Days since January 22nd 2020",
       y = "Number of people",
       title = "Increase in Infection, Recovery, and Mortatilty Rate in China")

# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
