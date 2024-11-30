## Generate synthetic HMLR data
library(tidyverse)
library(brms)
library(scoringRules)
library(mc2d)
library(extraDistr)

# PRNG
set.seed(1234)

num_clades <- 3 # match length of alpha
N = 100 # Sample size of multinomial sampling

clades <- c("A", "B", "C")
props_obs <- list()
alpha_obs <- list()

C = 2 # controls some variation in proportions
for(i in seq(from=1, to = 10, by = 1)){
  alpha = c(i*C, i*C, C) # alpha starts at (C, C, C) increases as (tC, tC, C)
  # theta = rdirichlet(n = 1, alpha = alpha) # realized proportions from Dir(alpha)
  # obs <- rmultinom(n = 1, size = N, prob = theta) # Put as counts
  obs <- t(rdirmnom(n = 1, size = N, alpha = alpha))
  
  props_obs[[i]] <- cbind( rep(i,3), 
                           obs/sum(obs),
                           clades
  )
  alpha_obs[[i]] <- alpha
  #theta_obs[[i]] <- theta
}

dat <- data.frame(Reduce(rbind, props_obs))
names(dat) <- c("date", "prop", "clade")
dat$date <- as.numeric(dat$date)
#dat$date <- as.Date("2024-11-18") + days(dat$date)
dat$prop <- as.numeric(dat$prop)

ggplot(data = dat, aes(x = date, y = prop, color = clade)) + 
  geom_point() +
  geom_line() #+ scale_x_date(date_minor_breaks = "1 day")

write_csv(dat, file = "./Data/syn_hmlr_dat.csv")