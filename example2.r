# For simulating multivariate normal data for constraint covariance matrices
library(mvgraphnorm)

# group 1 data
data1 <- rmvggm(n.samples=n1, net.str=g1, mean=mu1, method="htf")$data

# group 2 data
data2 <- rmvggm(n.samples=n2, net.str=g2, mean=mu2, method="htf")$data

p.values <- vector(length=m)
for (i in 1:m){
  res <- t.test(data1[,i], data2[,i], mu=0, alternative="two.sided")
  p.values[i] <- res$p.val
}