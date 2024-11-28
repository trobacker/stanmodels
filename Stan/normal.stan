//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

// The input data
data {
  int<lower=0> N;   // number of data items
  int<lower=0> K;   // number of predictors
  matrix[N, K] X;   // predictor matrix
  vector[N] y;      // outcome vector
  real<lower=0> sigma;  // error scale
  real<lower=0> tau;   // coefficient variance scale
}

// The parameters accepted by the model.
parameters {
  real mu;           // intercept
  vector[K] beta;       // coefficients for predictors
}

// The model to be estimated.
model {
  y ~ normal(X * beta + mu, sigma);  // likelihood
  beta ~ normal(0, tau);
}

