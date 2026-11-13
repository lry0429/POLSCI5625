#################################
# Problem Set 3
# Ruiyuan Li
# R/pset3.R
#################################

# Question 1
## in R
even_r <- function(x){
  floor(x/2) == x/2
}

## in C++
library(Rcpp)
cppFunction('
  LogicalVector evenNumbers(NumericVector x) {
    return floor(x/2) == x/2;
  }
')


# Question 2
## R function
stepR <- function(x){
  if (x < 0) 0
  else if (x < 5) 1
  else 2
}
## C++ function
cppFunction('
  NumericVector stepCpp(NumericVector x) {
    NumericVector out(x.size());
    for (int i = 0; i < x.size(); i++) {
      if (x[i] < 0) out[i] = 0;
      else if (x[i] < 5) out[i] = 1;
      else out[i] = 2;
    }
    return out;
  }
')


# Question 3
## R function
piR <- function(x) {
  inside <- numeric(0)
  for (i in 1:x) {
    point <- runif(2, 0, 1)
    inside[i] <- point[1]^2 + point[2]^2 <= 1
  }
  pi_hat <- 4 * sum(inside) / x
  return(pi_hat)
}

## C++ function
cppFunction('
  double piCpp(int x) {
  LogicalVector inside(x);
  NumericVector point(1);
    for (int i = 0; i < x; i++) {
      point = Rcpp::runif(2, 0, 1);
      inside[i] = point[0]*point[0] + point[1]*point[1] <= 1;
    }
    return 4.0 * sum(inside) / x;
  }
')


# Question 4
## R function
multiplyR <- function(x, y) {
  C <- matrix(rep(0, n^2), nrow = n)
  i <- 1
  while (i <= n) {
    j <- 1
    while (j <= n) {
      C[i, j] <- sum(A[i, ] * B[, j])
      j <- j + 1
    }
    i <- i + 1
  }
  return(C)
}

## C++ function
cppFunction('
  NumericMatrix multiplyCpp(NumericMatrix x, NumericMatrix y) {
    int n = 100;
    NumericMatrix C(n, n);
    int i = 0;
    while (i < n) {
      int j = 0;
      while (j < n) {
        NumericVector row = x(i, _);
        NumericVector col = y(_, j);
        C(i, j) = sum(row * col);
        j++;
      }
      i++;
    }
    return C;
  }
')


# Question 5
## R function
fibR <- function(x) {
  if (x < 2) return(x)
  else return(fibR(x-2) + fibR(x-1))
}

## C++ function
cppFunction('
  int fibCpp(int x) {
    if (x<2) return x;
    else return fibCpp(x-2) + fibCpp(x-1);
  }
')

