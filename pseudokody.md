# Pseudokody metod

## SD Holm correction procedure

```
Algorithm 1: SD Holm correction procedure.
Input: p(1) ≤ p(2) · · · ≤ p(m)
1 k = 0
2 while p(k+1) ≤ α/(m − k) do
3   k = k + 1
4 Reject H(1), H(1), . . . H(k)
```


```r
holm_correction <- function(p_values, alpha) {
  m <- length(p_values)
  p_sorted <- sort(p_values)
  k <- 0
  
  while (p_sorted[k + 1] <= alpha / (m - k)) {
    k <- k + 1
  }
  
  rejected <- p_sorted[1:k]
  return(rejected)
}

# Example usage:
p_values <- c(0.01, 0.03, 0.05, 0.07, 0.09)
alpha <- 0.05
rejected <- holm_correction(p_values, alpha)
print(rejected)
```

## SU Hochberg correction procedure

```
Algorithm 2: SU Hochberg correction procedure
Input: p(1) ≤ p(2) · · · ≤ p(m)
1 k = m
2 while p(k) > α/(m − k + 1) do
3   k = k − 1
4 Reject H(1), H(1), . . . H(k)
```

```r
hochberg_correction <- function(p_values, alpha) {
  m <- length(p_values)
  p_sorted <- sort(p_values)
  k <- m
  
  while (p_sorted[k] > alpha / (m - k + 1)) {
    k <- k - 1
  }
  
  rejected <- p_sorted[1:k]
  return(rejected)
}

# Example usage:
p_values <- c(0.01, 0.03, 0.05, 0.07, 0.09)
alpha <- 0.05
rejected <- hochberg_correction(p_values, alpha)
print(rejected)
```

## Hommel Correction

```
Algorithm 3: Hommel correction procedure
Input: p(1) ≤ p(2) · · · ≤ p(m)
1 i = m
2 while p(m−i+k) ≤ (k/i)*α for at least one k ∈ {1, ... , i} do
3   i = i − 1
4 i* = i
5 if i* = 0 then
6   Reject H(1), H(1), ... H(m)
7 else
8   Reject H(l) with pl < α/i∗
```

```r
hommel_correction <- function(p_values, alpha) {
  m <- length(p_values)
  p_sorted <- sort(p_values)
  i <- m
  
  while (any(p_sorted[m - i + 1:m] <= (1:i) * alpha / i)) {
    i <- i - 1
  }
  
  i_star <- i
  
  if (i_star == 0) {
    rejected <- p_sorted[1:m]
  } else {
    rejected <- p_sorted[p_sorted < alpha / i_star]
  }
  
  return(rejected)
}

# Example usage:
p_values <- c(0.01, 0.03, 0.05, 0.07, 0.09)
alpha <- 0.05
rejected <- hommel_correction(p_values, alpha)
print(rejected)
```