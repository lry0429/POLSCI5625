#################################
# Problem Set 3
# Ruiyuan Li
# R/pset3_run.R
#################################

source(file.path("R", "pset3.r"))
dir.create("results", showWarnings = FALSE)

# Question 1
# tests
n <- c(4, 7, 10, 15)
library(tidyverse)
results1 <- tibble(n, even_r(n), evenNumbers(n))

write.csv(
  results1,
  file = file.path("results", "results1.csv"),
  row.names = FALSE
)


# Question 2
## tests
n <- c(-3, 0, 3, 5, 10)
results2 <- tibble(n, sapply(n, stepR), stepCpp(n))

write.csv(
  results2,
  file = file.path("results", "results2.csv"),
  row.names = FALSE
)


# Question 3
## Calculation
N <- c(100, 1000, 10000, 100000)
set.seed(2026)
piR_results <- sapply(N, piR)
piCpp_results <- sapply(N, piCpp)
results3_1 <- tibble(N, piR_results, piCpp_results)

write.csv(
  results3_1,
  file = file.path("results", "results3_1.csv"),
  row.names = FALSE
)


## Accuracy Comparison
results3_2 <- data.frame(
  N = N,
  Accuracy_piR = round((1 - abs(piR_results-pi)/pi) * 100, 2),
  Accuracy_piCpp = round((1 - abs(piCpp_results-pi)/pi) * 100, 2)
)
# In both function, the accuracy of the estimates increases as the number of draws N increases.

write.csv(
  results3_2,
  file = file.path("results", "results3_2.csv"),
  row.names = FALSE
)


# Question 4
## Generate two random matrices
set.seed(2026)
n <- 100
A <- matrix(runif(n^2, 0, 1), nrow=n)
B <- matrix(runif(n^2, 0, 1), nrow=n)

## Verify both functions
results4_R <- multiplyR(A, B)
results4_Cpp <- multiplyCpp(A, B)

write.csv(
  results4_R,
  file = file.path("results", "results4_R.csv"),
  row.names = FALSE
)

write.csv(
  results4_Cpp,
  file = file.path("results", "results4_Cpp.csv"),
  row.names = FALSE
)

## Compare the execution times of the two functions
library(microbenchmark)
times_comparison1 <- microbenchmark(multiplyR(A, B), multiplyCpp(A, B), times = 100)
# When running both functions 100 times, the execution times of R function range from 7.69 to 112.78 milliseconds, 
# while the execution times of Rcpp function range from 4.32 to 12.33 milliseconds. Comparing each quarters, Rcpp function runs faster than R function.

write.csv(
  times_comparison1,
  file = file.path("results", "results4_times_comparison1.csv"),
  row.names = FALSE
)

## Compare with R's built-in function
times_comparison2 <- microbenchmark(A%*%B, multiplyCpp(A, B), times = 100)
# When running both functions 100 times, the maximum execution times of R's built-in matrix multiplication operation, 3509.64 microseconds, 
# is smaller than the minimum of execution times of Rcpp function, 4349.49 microseconds, indicating that R's built-in matrix multiplication operation
# is faster.

write.csv(
  times_comparison2,
  file = file.path("results", "results4_times_comparison2.csv"),
  row.names = FALSE
)


# Question 5
## tests
n <- c(10, 20, 30)
results5 <- tibble(n, sapply(n, fibR), sapply(n, fibCpp))

write.csv(
  results5,
  file = file.path("results", "results5.csv"),
  row.names = FALSE
)

## execution times of the two functions
times <- microbenchmark(fibR(10), fibR(20), fibR(30), 
                        fibCpp(10), fibCpp(20), fibCpp(30), times = 100)
# The recursive implementation becomes increasingly slow as n increases because it repeatedly calculates the same Fibonacci numbers, 
# resulting in an exponentially growing number of function calls.
# C++ makes the calculation faster for each n, but it cannot solve the repeated calculation problem.

write.csv(
  times,
  file = file.path("results", "results5_times_comparison.csv"),
  row.names = FALSE
)

  