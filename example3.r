# Application of Multiple Testing Procedures
library(mutoss)
library(multest)
library(hommel)

p.adj <- p.adjust(p.values, method="hochberg") # Hochberg correction
p.adj <- multiple.down(p.values, alpha=0.05)$adjPValues # BYK procedure
p.adj <- BlaRoq(p.values, alpha=0.05, silent=TRUE)$adjPValues # BR-2S procedure
p.adj <- hommel(p.values) # very fast Hommel procedure