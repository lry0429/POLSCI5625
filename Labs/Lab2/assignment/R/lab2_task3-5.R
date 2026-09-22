# Lab 2 assignment: Task 3 - Task5
# Ruiyuan Li
## ----------------------------

## Setup

source(file.path("R", "gendata.r"))
x <- lab2_vectors[[1]]
y <- lab2_vectors[[2]]
threshold <- 0.5


## Task 3: Nested loops

source(file.path("R", "assignment_helpers.r"))
thresholded_distance_loop <- function(x, y, threshold) {
  validate_pairwise_inputs(x, y)
  distance <- matrix(NA, nrow = length(x), ncol = length(y))
  for (i in seq_along(x)) {
    for (j in seq_along(y)) {
      d = abs(x[i] - y[j])
      distance[i,j] = ifelse(d < threshold, 0, d)
    }
  }
  return(distance)
}

task3 <- thresholded_distance_loop(x, y, threshold = 0.5)


## Task 4: Vectorized dense matrix

thresholded_distance_vectorized <- function(x, y, threshold){
  validate_pairwise_inputs(x, y)
  distance <- abs(outer(x, y, "-"))
  distance[distance < threshold] <- 0
  return(distance)
}

task4 <- thresholded_distance_vectorized(x, y, threshold = 0.5)


## Task 5: Vectorized sparse matrix

library(Matrix)

thresholded_distance_sparse <- function(x, y, threshold){
  validate_pairwise_inputs(x, y)
  distance <- abs(outer(x, y, "-"))
  distance[distance < threshold] <- 0
  d <- Matrix(distance, sparse = TRUE)
  return(d)
}

task5 <- thresholded_distance_sparse(x, y, threshold = 0.5)



