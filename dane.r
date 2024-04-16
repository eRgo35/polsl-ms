# R < dane.r --no-save
library(mvtnorm)

korelacja <- 0.2
wariancja <- 1.5

macierz_korelacji <- matrix(nrow = 2, ncol = 2, korelacja)

print(macierz_korelacji)
#   [0.2 0.2]
#   [0.2 0.2]

diag(macierz_korelacji) <- wariancja

print(macierz_korelacji)
#   [1.5  0.2]
#   [0.2  1.5]

n = 1000 # Ilosć danych
dane <- rmvnorm(n = n, sigma = macierz_korelacji) 

print(dane)

test_korelacji <- cor.test(dane[,1], dane[,2]) # kolumna 1 z kolumną 2

print(test_korelacji)

for(i in 1:100){
  losoweDaneKolumny1 <- sample(dane[,1], 100, replace=TRUE)           
  losoweDaneKolumny2 <- sample(dane[,2], 100, replace=TRUE)
 
  test_kor <- cor.test(losoweDaneKolumny1, losoweDaneKolumny2)
 
  p_values <- c(test_kor$p.value)
  estimates <- c(test_kor$estimate)
 
  print(test_kor)
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
