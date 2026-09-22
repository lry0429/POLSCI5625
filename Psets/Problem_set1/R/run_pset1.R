# Problem Set 1
## Ruiyuan Li

## R/run_pset1.R
#-------------------

functions_path <- file.path("R", "pset1.R")
source(functions_path)

n <- 100L
tea <- 50L
B <- 100000L
S_obs <- 67L

results <- sim(n, tea, B, S_obs, seed = 12345L)

dir.create("results", showWarnings = FALSE)

write.csv(
  results[[1]],
  file = file.path("results", "sim_assignment.csv"),
  row.names = FALSE
)

write.csv(
  results[[2]],
  file = file.path("results", "sim_correct.csv"),
  row.names = FALSE
)

png("results/histogram.png", width = 800, height = 600)
plot(results[[3]], xlab = "number of correctly classified cups", 
     main = "Histogram of Correctly Classified Cups under Sharp Null vs Observed Statistic")
abline(v = S_obs, col = "red", lwd = 2)
dev.off()

write.csv(
  results[[4]],
  file = file.path("results", "p_value.csv"),
  row.names = FALSE
)