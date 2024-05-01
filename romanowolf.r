tryCatch(
    {
        shell('cls')
    },
    error = function(e){
        system(print0('clear'))
        print("Running on linux!")
    },
    finally = {
        print("cleared session")
    }
)

print("Romano Wolf my beloved")

# set seed to funny number
set.seed(69)

print('---------------- LOADING DATA ----------------')

# read data from csv file
dane <- read.csv("baza-MS.csv")

# print if csv is parsed correctly
# print(dane)

# keeping all variables seperate for ease of future use
# TODO: Change this code to be more universal (priority = very_low)
Y <- dane[,1]
X1 <- dane[,2]
X2 <- dane[,3]
X3 <- dane[,4]
X4 <- dane[,5]
X5 <- dane[,6]
X6 <- dane[,7]
X7 <- dane[,8]
X8 <- dane[,9]
X9 <- dane[,10]
X10 <- dane[,11]

# A list of X's to easily iterate through
X <- list(X1, X2, X3, X4, X5, X6, X7, X8, X9, X10)

# Verifying if data has been parsed successfully
cat(paste("Y:\n", sep=""))
print(Y)
for (i in 1:10)
{
    cat(paste("X", i, ":\n", sep=""))
    print(X[[i]])
}

print('---------------- CORRELATION ----------------')
names_vector <- c('X1', 'X2', 'X3', 'X4', 'X5', 'X6', 'X7', 'X8', 'X9', 'X10')
correlation_vector <- c(cor.test(Y, X1)$estimate, cor.test(Y, X2)$estimate, cor.test(Y, X3)$estimate, cor.test(Y, X4)$estimate, cor.test(Y, X5)$estimate, cor.test(Y, X6)$estimate, cor.test(Y, X7)$estimate, cor.test(Y, X8)$estimate, cor.test(Y, X9)$estimate, cor.test(Y, X10)$estimate)
correlation_p <- c(cor.test(Y, X1)$p.value, cor.test(Y, X2)$p.value, cor.test(Y, X3)$p.value, cor.test(Y, X4)$p.value, cor.test(Y, X5)$p.value, cor.test(Y, X6)$p.value, cor.test(Y, X7)$p.value, cor.test(Y, X8)$p.value, cor.test(Y, X9)$p.value, cor.test(Y, X10)$p.value)
print(correlation_vector)
print(correlation_p)

print('---------------- SORTED ----------------')
# sort correlation vector and p values
sorted_indices <- order(correlation_p)
sorted_correlation_vector <- correlation_vector[sorted_indices]
sorted_correlation_p <- correlation_p[sorted_indices]
sorted_names <- names_vector[sorted_indices]
print(sorted_correlation_vector)
print(sorted_correlation_p)
print(sorted_names)

print('---------------- ANALYZE ----------------')
# assume 5% of error
alpha <- 0.05
# number of rejected hypothesis
rejected <- 0
# number of selected hypothesis
N <- length(sorted_correlation_p)
# 0 if not rejected 1 if rejected
rejected_bin <- c(rep(0, 10)) # or replicate(10, 0)

# print the binary vector
print(rejected_bin)

# 0 if hypothesis is rejected in iteration
flag <- 0
# rejection of variables that don't meet pvalue and alpha requirements

while(flag < 1)
{
    flag <- 1
    for (i in 1:N)
    {
        if (sorted_correlation_p[i] < alpha/(N-i+1))
        {
            flag <- 0
            rejected <- rejected + 1
            rejected_bin[i] <- 1
            print(rejected_bin)
        }
        else 
        {
            selected <- i
            print(selected)
            break
        }
    }
    # print(rejected_bin)
    sorted_correlation_vector <- sorted_correlation_vector[selected:length(sorted_correlation_vector)]
    sorted_correlation_p <- sorted_correlation_p[selected:length(sorted_correlation_p)]
    sorted_names <- sorted_names[selected:length(sorted_names)]
    print(sorted_names)
    N <- length(sorted_correlation_p)

}

# print the selected vector
