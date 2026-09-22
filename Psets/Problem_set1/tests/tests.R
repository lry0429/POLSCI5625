# Problem Set 1
## Ruiyuan Li

## tests/tests.R
#-------------------

functions_path <- file.path("R", "pset1.R")
source(functions_path)

n <- 100L
tea <- 50L
B <- 100000L
S_obs <- 67L

results <- sim(n, tea, B, S_obs, seed = 12345L)

stopifnot(nrow(results[[1]]) == 100000L)
stopifnot(ncol(results[[1]]) == 100L)
stopifnot(apply(results[[1]], 1, sum) == 50L)
cat("Pass: simulated 50 tea-first cups and 50 milk-first cups 100,000 times")

stopifnot(all(results[[2]] >= 0 & results[[2]] <= 100))
cat("Pass: correct number of correct classification")

stopifnot(abs(mean(results[[2]]) - 50) < 0.5)
cat("Pass: assignments under null distribution approximately even")

stopifnot(results[[4]] >= 0 & results[[4]] <= 1)
cat("Pass: p value is within 0 and 1")

cat("All Problem Set 1 tests passed.\n")
