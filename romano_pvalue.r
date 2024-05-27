# Wczytanie danych z pliku CSV
dane <- read.csv("C:\\Users\\User\\Documents\\dane.txt")

# Przypisanie kolumny Y (zmienna zależna) oraz kolumn X (zmienne niezależne)
Y <- dane$Y
X <- dane[,2:11]

# Funkcja do obliczania statystyk testowych korelacji dla każdej kolumny X względem Y
calculate_statistics <- function(Y, X) {
  sapply(1:ncol(X), function(i) cor.test(Y, X[,i])$statistic)
}

# Funkcja do obliczania p-value dla statystyk testowych korelacji
calculate_pvalues <- function(Y, X) {
  sapply(1:ncol(X), function(i) cor.test(Y, X[,i])$p.value)
}

# Funkcja do permutacji i obliczania permutowanych statystyk testowych
calculate_permuted_statistics <- function(Y, X, M) {
  n <- ncol(X)  # liczba kolumn w X
  permuted_stats <- matrix(0, nrow = M, ncol = n)  # macierz do przechowywania permutowanych statystyk
  for (m in 1:M) {
    permuted_Y <- sample(Y)  # permutacja wartości Y
    permuted_stats[m, ] <- calculate_statistics(permuted_Y, X)  # obliczenie statystyk dla permutowanych danych
  }
  permuted_stats
}

# Funkcja do implementacji procedury stepdown Romano-Wolfa
stepdown_romano_wolf <- function(Y, X, alpha, M) {
  n <- ncol(X)  # liczba kolumn w X
  original_stats <- calculate_statistics(Y, X)  # obliczenie oryginalnych statystyk testowych
  original_pvalues <- calculate_pvalues(Y, X)  # obliczenie oryginalnych p-value
  sorted_indices <- order(abs(original_stats), decreasing = TRUE)  # sortowanie indeksów statystyk malejąco wg wartości bezwzględnych
  sorted_stats <- original_stats[sorted_indices]  # posortowane statystyki
  sorted_pvalues <- original_pvalues[sorted_indices]  # posortowane p-value
  sorted_X <- X[, sorted_indices]  # posortowane kolumny X zgodnie z posortowanymi statystykami
  
  permuted_stats <- calculate_permuted_statistics(Y, sorted_X, M)  # obliczenie permutowanych statystyk testowych
  
  R <- 0  # liczba odrzuconych hipotez
  for (s in 1:n) {
    max_permuted_stats <- apply(permuted_stats[, 1:s, drop=FALSE], 1, max)  # maksymalne wartości permutowanych statystyk dla pierwszych s kolumn
    threshold <- quantile(max_permuted_stats, probs = 1 - alpha)  # wyznaczenie kwantyla empirycznego na poziomie 1 - alpha
    cat("Kwantyl empiryczny dla s =", s, ":", threshold, "\n")
    if (abs(sorted_stats[s]) > threshold) {  # porównanie oryginalnej statystyki z progiem
      R <- s  # aktualizacja liczby odrzuconych hipotez
    } else {
      cat("Hipoteza nieodrzucona dla s =", s, ":", abs(sorted_stats[s]), "<=", threshold, "\n")
      break  # przerwanie pętli, jeśli hipoteza nie jest odrzucona
    }
  }
  list(R = R, sorted_indices = sorted_indices, sorted_stats = sorted_stats, sorted_pvalues = sorted_pvalues)  # zwrócenie wyników
}

# Wartość M dla permutacji
M <- 10000
alpha <- 0.05

# Wywołanie funkcji stepdown_romano_wolf i zapisanie wyników
result <- stepdown_romano_wolf(Y, X, alpha, M)
cat("Liczba odrzuconych hipotez:", result$R, "\n")

# Wyświetlenie odrzuconych hipotez
rejected_hypotheses <- names(dane)[result$sorted_indices[1:result$R] + 1]
cat("Odrzucone hipotezy:", rejected_hypotheses, "\n")

# Wyświetlenie nieodrzuconych hipotez z tytułem kolumny, wartością statystyki i p-value
if (result$R < length(result$sorted_indices)) {
  not_rejected_indices <- result$sorted_indices[(result$R + 1):length(result$sorted_indices)]
  not_rejected_stats <- result$sorted_stats[(result$R + 1):length(result$sorted_stats)]
  not_rejected_pvalues <- result$sorted_pvalues[(result$R + 1):length(result$sorted_pvalues)]
  not_rejected_hypotheses <- names(dane)[not_rejected_indices + 1]
  
  cat("Nieodrzucone hipotezy:\n")
  for (i in 1:length(not_rejected_hypotheses)) {
    cat("Hipoteza:", not_rejected_hypotheses[i], "Statystyka:", not_rejected_stats[i], "P-value:", not_rejected_pvalues[i], "\n")
  }
}
