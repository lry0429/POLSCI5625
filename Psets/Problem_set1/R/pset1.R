# Problem Set 1
## Ruiyuan Li

## R/pset1.R
#-------------------

## Question 5

sim <- function(n, tea, B, S_obs, seed = 12345L){
  ### (a)
  classif <- c(rep(1, tea), rep(0, (n-tea)))
  samples <- matrix(rep(NA, n*B), nrow = B, ncol = n)
  for (i in seq_len(B)){
    samples[i, ] <- sample(classif, n, replace = FALSE)
  }
  
  ### (b)
  S <- rep(NA, B)
  for (i in seq_len(B)){
    S[i] <- sum(samples[i, ] == classif)
  }
  
  ### (c)
  h <- hist(S, plot = FALSE)
  
  ### (d)
  p_value <- sum(S >= S_obs) / B
  
  return(list(samples, S, h, p_value))
}

