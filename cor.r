library(mvtnorm)
library(multtest)

cor <- 0.2
cor_matrix <- matrix(cor, nrow=10, ncol=10)

print(cor_matrix)

diag(cor_matrix) <- 1.2

print(cor_matrix)

data <- rmvnorm(n=100, sigma = cor_matrix)

print(data)

print(cor.test(data[,1], data[,2]))