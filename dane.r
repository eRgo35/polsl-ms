# R < dane.r --no-save
library(mvtnorm)

korelacja <- 0.2
wariancja <- 1

macierz_korelacji <- matrix(nrow = 2, ncol = 2, korelacja)

print(macierz_korelacji)
#   [0.2 0.2]
#   [0.2 0.2]

diag(macierz_korelacji) <- wariancja

print(macierz_korelacji)
#   [1  0.2]
#   [0.2  1]

wariancje <- 0.3
wariancja <- 1 

macierz_wariancji <- matrix(nrow = 3, ncol = 3, wariancje)

print(macierz_wariancji)

diag(macierz_wariancji) <- wariancja

n = 1000 # Ilosć danych
dane <- rmvnorm(n = n, sigma = macierz_korelacji) 
hmmm <- rmvnorm(n = n, sigma = macierz_wariancji) 

print(dane)

test_korelacji <- cor.test(dane[,1], dane[,2]) # kolumna 1 z kolumną 2

print(test_korelacji)

for(i in 1:100){
  test_kor <- cor.test(sample(dane[,1], 100), sample(dane[,2], 100))
 
  p_values <- c(test_kor$p.value)
  estimates <- c(test_kor$estimate)
 
  # print(test_kor)
  # print(p_values)
  # print(test_kor)
}

print(p_values)
print(estimates)

# Sprawdzenie poprawnosci wynikow za pomoca stats
library(stats)
# Dane wejściowe - wektor p-wartości
#p_values <- p
#c(0.01, 0.02, 0.03, 0.04, 0.05)

# Korekcja metodą Holma
adjusted_p_values_holm <- p.adjust(p_values, method = "holm")

# Korekcja metodą Hommela
adjusted_p_values_hommel <- p.adjust(p_values, method = "hommel")

# Korekcja metodą Hochberga
adjusted_p_values_hochberg <- p.adjust(p_values, method = "hochberg")

# Wyświetlenie wyników
adjusted_p_values_holm
adjusted_p_values_hommel
adjusted_p_values_hochberg
