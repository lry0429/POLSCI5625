data <- matrix(c(
  0, 0, 0, 172738,
  1, 0, 0, 2030,
  0, 1, 0, 114,
  0, 0, 1, 68,
  1, 1, 1, 50
), ncol = 4, byrow = TRUE)

write.csv(
  data,
  file = file.path("data-raw", "observed_pattern.csv"),
  row.names = FALSE
)