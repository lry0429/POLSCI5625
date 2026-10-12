# Problem Set 2
## Ruiyuan Li
#
## R/pset2.R

################################

EM <- function(data, theta, p, q, tol, max_iter){
  delta <- data[,c(1:3)]
  count <- data[, 4]
  N <- sum(count)
  
  # E-step
  
  ## probability of each agreement pattern
  pattern_prob <- function(delta, probs) {
    apply(delta, 1, function(x) {
      prod(probs^x * (1 - probs)^(1-x))
    })
  }
  
  loglik <- numeric(max_iter + 1L)
  mixture_prob0 <- theta * pattern_prob(delta, p) + (1 - theta) * pattern_prob(delta, q)
  loglik[1] <- sum(count * log(mixture_prob0))
  
  for (iter in 1:max_iter) {
    
    f_p <- pattern_prob(delta, p)
    f_q <- pattern_prob(delta, q)
    
    E_M <- theta * f_p / (theta * f_p + (1 - theta) * f_q)
    expected_match <- count * E_M
    expected_nonmatch <- count * (1 - E_M)
    
    # M-step
    
    theta_new <- sum(expected_match) / N
    p_new <- colSums(delta * expected_match) / sum(expected_match)
    q_new <- colSums(delta * expected_nonmatch) / sum(expected_nonmatch)
    
    f_p_new <- pattern_prob(delta, p_new)
    f_q_new <- pattern_prob(delta, q_new)
    
    mixture_prob <- theta_new * f_p_new + (1 - theta_new) * f_q_new
    
    loglik[iter + 1L] <- sum(count * log(mixture_prob))
    
    ## convergence criterion
    change <- max(
      abs(theta_new - theta),
      abs(p_new - p),
      abs(q_new - q)
    )
    
    theta <- theta_new
    p <- p_new
    q <- q_new
    
    if (change < tol) break
  }
  
  # Store the observed-data log-likelihood
  
  history = data.frame(
    iter = 0:iter,
    loglik = loglik[seq_len(iter + 1L)]
  )
}

