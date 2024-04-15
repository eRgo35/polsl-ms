# # For simulating multivariate normal data with a mean vector of μ and a covariance matrix of Σ
library(mvtnorm)

# variable init
n <- 100 # sample size for each group
m <- 10 # number of hypotheses
mu1 <- rep(0, m) # mean vector for group 1
mu2 <- rep(0.5, m) # mean vector for group 2
Sigma2 <- matrix(0.5, nrow=m, ncol=m) # covariance matrix
diag(Sigma2) <- 1 # set diagonal elements to 1
#####

# group 1 data
data1 <- rmvnorm(n=n, mean=mu1, sigma=Sigma2, method="chol")

# group 2 data
data2 <- rmvnorm(n=n, mean=mu2, sigma=Sigma2, method="chol")

p.values <- vector(length=m) # m : number of hypotheses
for (i in 1:m) {
  res <- t.test(data1[,i], data2[,i], mu=0, alternative="two.sided")
  p.values[i] <- res $ p.val
}

print(p.values)