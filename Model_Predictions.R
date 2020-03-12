source("Analysis.R")

#Making Models
support <- 0:365
us <- 330415717
world <- 7770219335

############US Population####################
#Model Predictions for US:
logUSpop <- rep(log(us),length(support))

USmodel1 <- lm(log(confirms) ~ day , data = inUS)
USmodel2 <- lm(log(confirms) ~ day, data = (inUS %>% slice((nrow(inUS)-7):(nrow(inUS)))) )
USmodel3 <- lm(log(confirms) ~ day, data = (inUS %>% slice((nrow(inUS)-14):(nrow(inUS)))))
USmodel4 <- lm(log(confirms) ~ day, data = (inUS %>% slice((nrow(inUS)-21):(nrow(inUS)))))

f1 <- function(x){return(USmodel1$coefficients[1] + USmodel1$coefficients[2]*x)}
f2 <- function(x){return(USmodel2$coefficients[1] + USmodel2$coefficients[2]*x)}
f3 <- function(x){return(USmodel3$coefficients[1] + USmodel3$coefficients[2]*x)}
f4 <- function(x){return(USmodel4$coefficients[1] + USmodel4$coefficients[2]*x)}

USpredictions <- data.frame(matrix(nrow = length(support),ncol = 6))
USpredictions[[1]] <- support
USpredictions[[2]] <- logUSpop
USpredictions[[3]] <- f1(support)
USpredictions[[4]] <- f2(support)
USpredictions[[5]] <- f3(support)
USpredictions[[6]] <- f4(support)
colnames(USpredictions) <- c("day","US_population","timeline","last1Week","last2Weeks","last3Weeks")
USpredictions <- USpredictions %>% pivot_longer(cols = c("US_population","timeline","last1Week","last2Weeks","last3Weeks"),names_to = "model")


################## Model prediciton for the World #################
logWorld <- rep(log(world),length(support))

Wmodel1 <- lm(log(confirms) ~ day , data = earth)
Wmodel2 <- lm(log(confirms) ~ day, data = (earth %>% slice((nrow(earth)-7):(nrow(earth)))))
Wmodel3 <- lm(log(confirms) ~ day , data = (earth %>% slice((nrow(earth)-14):(nrow(earth)))))
Wmodel4 <- lm(log(confirms) ~ day , data = (earth %>% slice((nrow(earth)-21):(nrow(earth)))))

Wf1 <- function(x){return(Wmodel1$coefficients[1] + Wmodel1$coefficients[2]*x)}
Wf2 <- function(x){return(Wmodel2$coefficients[1] + Wmodel2$coefficients[2]*x)}
Wf3 <- function(x){return(Wmodel3$coefficients[1] + Wmodel3$coefficients[2]*x)}
Wf4 <- function(x){return(Wmodel4$coefficients[1] + Wmodel4$coefficients[2]*x)}

Wpredictions <- data.frame(matrix(nrow = length(support),ncol = 6))
Wpredictions[[1]] <- support
Wpredictions[[2]] <- logWorld
Wpredictions[[3]] <- Wf1(support)
Wpredictions[[4]] <- Wf2(support)
Wpredictions[[5]] <- Wf3(support)
Wpredictions[[6]] <- Wf4(support)
colnames(Wpredictions) <- c("day","World_population","timeline","last1Week","last2Weeks","last3Weeks")
Wpredictions <- Wpredictions %>% pivot_longer(cols = c("World_population","timeline","last1Week","last2Weeks","last3Weeks"),names_to = "model")


####################plots of models#################################

USpredictions %>% ggplot(mapping = aes(x = day,color = model)) +
  geom_line(mapping = aes(y = value)) + labs(x = "Days since January 22nd", y = "Log of US population",
       title = "3 model predictions for when #Confirmed = US population")


Wpredictions %>% ggplot(mapping = aes(x = day,color = model)) + 
  geom_line(mapping = aes(y = value)) + labs(x = "Days since January 22nd", y = "Log of World population",
       title = "3 model predictions for when #Confirmed = World population")
 