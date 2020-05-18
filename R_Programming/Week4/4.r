set.seed(1)
rpois(5, 2)

library(datasets)
Rprof()
fit <- lm(y ~ x1 + x2)
summaryRprof("profile1.out", lines = "show")
