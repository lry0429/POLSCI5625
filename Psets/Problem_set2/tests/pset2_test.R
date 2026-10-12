# Problem Set 2
## Ruiyuan Li
#
## tests/pset2_test.R

################################

source(file.path("R", "pset2.r"))
data <- read.csv(file.path("data-raw", "observed_pattern.csv"), header = TRUE)

# initial values
theta <- 0.5
p <- c(0.9, 0.9, 0.9)
q <- c(0.1, 0.1, 0.1)

tol <- 1e-10
max_iter <- 1000

# run
results <- EM(data, theta, p, q, tol, max_iter)


stopifnot(
  nrow(data) == 5,
  all(diff(loglik) >= -1e-8)
)

cat("PASS: observed-data log-likelihood does not decrease.")


