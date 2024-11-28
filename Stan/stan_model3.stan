// POISSON Regression with several parameters

// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N; // Number of observations
  //int<lower=0> N_rep; // Posterior samples
  int<lower=0> P; // Number of predictors
  matrix[N, P] X;   // predictor matrix
  int<lower=0> y[N]; // Response variable
  real<lower=0> sigma;  // error scale
}

// The parameters accepted by the model.
parameters {
  //real alpha; // intercept
  vector[P] beta; // beta vector
}

//transformed parameters{
//  vector[P] theta;
//  theta = exp(beta);
//}

// The model to be estimated.
// Need to do a transformed parameters I believe!
// https://rpubs.com/kaz_yos/stan-pois1

model {
  y ~ poisson_log(X * beta); // Poisson_log is nice! :) 
  beta ~ normal(0, sigma);
}

generated quantities {
  
  // This is the one that ALMOST works:
  int y_rep[N] = poisson_log_rng(X * beta);
  
  
  /*
  int<lower=0> y_rep = poisson_log_rng(dot_product(X, beta));
  
  int<lower=0> y_rep;
  y_rep = poisson_log_rng(X * beta);
  
  vector[N] y_rep;

  for(i in 1:N){
    y_rep[i] = poisson_log_rng(beta * X);
  }
  */
  
  
  /* 
  How to check if model is working, if enough data, estimates converge to GLM
  
  */
}

