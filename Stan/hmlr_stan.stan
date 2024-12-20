data {
  int<lower=1> N; // number of observations
  int<lower=1> K; // number of categories
  vector[N] time; // time variable
  array[N,K]int y; // outcome counts // proportions: real <lower=0, upper=1>
}

parameters {
  vector[K-1] alpha; // intercepts
  vector[K-1] gamma; // coefficients for time
}

transformed parameters{
  // eta calc twice, do once here, once below in model
  // append a 0 row to eta to avoid the zero estimates
}

model {
  matrix[N, K] eta;
  
  for (n in 1:N) {
    for (k in 1:(K-1)) {
      eta[n, k] = alpha[k] + gamma[k] * time[n];
    }
    eta[n, K] = 0;
    //eta[n, K] = -eta[n,1] - eta[n, 2]; // reference category
  }
  
  for (n in 1:N) {
    y[n] ~ multinomial_logit(eta[n]');
  }
}

generated quantities {
  matrix[N, K] eta;
  
  for (n in 1:N) {
    for (k in 1:(K-1)) {
      eta[n, k] = alpha[k] + gamma[k] * time[n];
    }
    eta[n, K] = 0; // reference category
  }
}

