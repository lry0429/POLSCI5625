######################################################
#                                                    #
# Lab 4: Euclidean distance and parallel computing   #
#                                                    #
# R/lab4.r                                           #
#                                                    #
# In-class reference implementations for:            #
#   Task 1. nested-loop pairwise distances           #
#   Task 2. vectorized pairwise distances            #
#   Task 3. sequential and parallel foreach          #
#                                                    #
######################################################

# Use the local package library when present.
if (dir.exists(".Rlib")) {
  .libPaths(c(".Rlib", .libPaths()))
}

library(foreach)


# Task 1. Pairwise distances with nested loops

# mat contains latitude and longitude in its two columns.
# Each function returns an N by N matrix of county distances.

distance_loop <- function(mat) {
  n <- nrow(mat)

  distances <- matrix(
    0,
    nrow = n,
    ncol = n
  )

  for (i in seq_len(n)) {
    for (j in seq_len(n)) {
      distances[i, j] <- sqrt(
        (mat[i, 1] - mat[j, 1])^2 + # 1: latitude
        (mat[i, 2] - mat[j, 2])^2   # 2: longitude
      )
    }
  }

  distances
}


# Task 2. Pairwise distances with a vectorized inner loop

# Calculate distances from county i to every county in one expression.

distance_vectorized <- function(mat) {
  n <- nrow(mat)

  distances <- matrix(
    0,
    nrow = n,
    ncol = n
  )

  for (i in seq_len(n)) {
    distances[i, ] <- sqrt(
      (mat[i, 1] - mat[, 1])^2 +
      (mat[i, 2] - mat[, 2])^2
    )
  }

  distances
}


# Task 3. Pairwise distances with foreach

# Each iteration returns one row. Use %do% for sequential execution
# and %dopar% for parallel execution with a registered backend.

distance_foreach <- function(mat, parallel = FALSE) {
  iterations <- foreach(
    i = seq_len(nrow(mat)),
    .combine = "rbind",# 每次循环算出来的结果，用 rbind() 一行一行拼起来
    .inorder = TRUE # 即使并行计算时不同任务完成顺序不同，最后也按 i = 1,2,3,... 的顺序整理结果
  )

  if (parallel) {
    distances <- iterations %dopar% { # %dopar% = parallel
      sqrt(
        (mat[i, 1] - mat[, 1])^2 +
        (mat[i, 2] - mat[, 2])^2
      )
    }
  } else {
    distances <- iterations %do% { # %do% = sequential
      sqrt(
        (mat[i, 1] - mat[, 1])^2 +
        (mat[i, 2] - mat[, 2])^2
      )
    }
  }

  matrix(distances, nrow = nrow(mat), ncol = nrow(mat))
}
