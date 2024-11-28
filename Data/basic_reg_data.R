## Generate simple regression data
library(tidyverse)
set.seed(77)
n <- 100
x <- round(runif(n, min = 0, max = 10),2)
eps <- round(rnorm(n, mean = 0, sd = 2), 2)

## Y = 2X + N(0,4)
y <- 2*x+eps

df <- data.frame("x" = x, "y" = y)
#write.csv(df, file = "./simplereg_data")

# Random indices to induce NA at rate 10%
id_remove <- rbinom(n = n, size = 1, prob = 0.10)
df["missing"] <- id_remove

df %>%
  mutate(x_na = if_else( (missing > 0), NA_real_, x))

write.csv(df, file = "./Data/simpleregwithNA_data")
