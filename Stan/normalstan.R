library(rstan)

N <- 100
K <- 10
X <- matrix(rnorm(N*K), N, K)
beta <- rnorm(K)
y <- X%*%beta + rnorm(N)

fit <- stan(
  file = "~/Dropbox/Research/StanPower/normal.stan",  # Stan program
  data = list("X" = X, "y" = as.vector(y), "N" = N, "K" = K,
              sigma = 1, tau = 1),    # named list of data
  chains = 4,             # number of Markov chains
  warmup = 1000,          # number of warmup iterations per chain
  iter = 3000,            # total number of iterations per chain
  cores = 1,              # number of cores (could use one per chain)
  refresh = 0             # no progress shown
)

farr <- apply(as.array(fit), 3, "c")
plot(beta, colMeans(farr[, 2:11]))
abline(a = 0 ,b = 1)

plot(fit)
