dat = fread("https://coronadatascraper.com/timeseries-tidy.csv")

dat %>% 
  filter(state == "WI",
         city == "", 
         county == "",
         type %in% c("tested", "cases")) %>% 
  filter(date > "2020-03-14") %>% 
  select(date, value, type) %>% 
  pivot_wider(names_from = type, values_from = value) %>% 
  mutate(proportionPositive = cases/tested) %>% 
  ggplot(aes(x = tested, y= proportionPositive)) + geom_line()


diffDat = dat %>% 
  filter(state == "WI",
         city == "", 
         county == "",
         type %in% c("tested", "cases")) %>% 
  filter(date > "2020-03-15") %>% 
  select(date, value, type) %>% 
  pivot_wider(names_from = date, values_from = value) %>% 
  select(-type) %>% 
  apply(1, diff)

plot(diffDat[,2:1],type = "l", xlab ="new Tests", ylab = "newcases" )