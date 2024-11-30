data {
  int<lower=1> N; // number of observations
  int<lower=1> K; // number of categories
  vector[N] time; // time variable
  int y[N,K]; // outcome proportions
}

parameters {
  vector[K-1] alpha; // intercepts
  vector[K-1] gamma; // coefficients for time
}

model {
  matrix[N, K] eta;
  for (n in 1:N) {
    for (k in 1:(K-1)) {
      eta[n, k] = alpha[k] + gamma[k] * time[n];
    }
    eta[n, K] = 0; // reference category
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

