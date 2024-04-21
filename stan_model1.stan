
// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N;
  vector[N] X;
  int<lower=0,upper=1> y[N];
  real<lower=0> sigma;  // error scale
}

// The parameters accepted by the model.
parameters {
  real alpha;
  real beta;
}

// The model to be estimated.
model {
  y ~ bernoulli_logit(alpha + beta * X);
  alpha ~ normal(0, sigma);
  beta ~ normal(0, sigma);
}

