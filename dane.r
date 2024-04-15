# R < dane.r --no-save

library(mvtnorm) #wczytanie mvtnorm
korelacja <- 0.5 #ustalenie wartosci korelacji
macierz_korelacji <- matrix(korelacja, nrow=2, ncol= 2) #zbudowanie macierzy wypelnionej wartosciami korelacji
#   [0.5 0.5]
#   [0.5 0.5]

diag(macierz_korelacji) <- 2 #ustalamy wariancje zmiennych na przekatnej macierzy
#daje nam to macierz ktora funkcji rmvnorm przekaze korelacje i wariancje w wlasciwym formacie
#   [2  0.5]
#   [0.5  2]

set.seed(111) #tak aby kod byl powtarzalny
data <- rmvnorm(n=10000, sigma = macierz_korelacji) #generujemy 10000 obserwacji zmiennych

print(data)

print(cor.test(data[,1], data[,2]))

p <- c()
c <- c()

for(i in 1:100){
 losoweDaneKolumny1 <- sample(data[,1], 100, replace=TRUE) #losujemy 100 liczb z kolumny 1           
 losoweDaneKolumny2 <- sample(data[,2], 100, replace=TRUE) #losujemy 100 liczb z kolumny 2
 test <- cor.test(losoweDaneKolumny1, losoweDaneKolumny2)
 p <- c(p, test$p.value)
 c <- c(c, test$estimate)
 print(cor.test(losoweDaneKolumny1, losoweDaneKolumny2))
}
print(p)
print(c)


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