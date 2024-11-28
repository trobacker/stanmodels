// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N;
  vector[N] x;
  vector[N] y;
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real beta0;
  real beta1;
  // real<lower=0> tau;
  // real<lower=0> phi;
  real<lower=0> sigma;
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  beta0 ~ normal(0, 100); // fixed variance
  beta1 ~ normal(0, 100); // fixed variance
  // beta0 ~ normal(0, tau);
  // beta1 ~ normal(0, phi);
  sigma ~ inv_gamma(2,1);
  y ~ normal(beta0 + beta1*x, sigma);
}

