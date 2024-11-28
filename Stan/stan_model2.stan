//
// Logistic Regression with several parameters
//
// DO NOT USE A Hashtag, it will not compile, 
// they will give you errors in compiling. 

// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N; // Number of observations
  int<lower=0> P; // Number of predictors
  //vector[N] X; replaced 
  matrix[N, P] X;   // predictor matrix
  int<lower=0,upper=1> y[N]; // Response variable
  real<lower=0> sigma;  // error scale
}

// The parameters accepted by the model.
parameters {
  real alpha; // intercept
  //real beta; replaced with a vector
  vector[P] beta; // beta vector
}

// The model to be estimated.
model {
  y ~ bernoulli_logit(alpha + X * beta);
  alpha ~ normal(0, sigma);
  beta ~ normal(0, sigma);
}

