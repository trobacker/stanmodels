// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N_obs;
  int<lower=0> N_mis;
  vector[N_obs] x_obs; // X for observed
  vector[N_mis] x_mis; // X for missing y's
  vector[N_obs] y_obs;
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real beta0;
  real beta1;
  real<lower=0> sigma;
  
  array[N_mis] real y_mis;
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
  y_obs ~ normal(beta0 + beta1*x_obs, sigma);
  y_mis ~ normal(beta0 + beta1*x_mis, sigma);
}

