# Problem Set 2
## Ruiyuan Li
#
## R/pset2_run.R

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

# save
dir.create("results", showWarnings = FALSE)

write.csv(
  results,
  file = file.path("results", "log-likelihood.csv"),
  row.names = FALSE
)

# Plot
png("results/log-likelihood.png", width = 800, height = 600)
plot(results$iter, results$loglik,
     type = "b", col = "darkblue",
     xlab = "Iteration",
     ylab = "Observed-data log-likelihood",
     main = "Observed-data log-likelihood"
)
dev.off()
