library(readxl)
ficheiro <- "Questao2/2.1.total_user.xlsx"
dados <- read_excel(ficheiro)
dados_ordenados <- sort(dados$total_user)
quartis <- quantile(dados_ordenados, probs = c(0.25, 0.50, 0.75))
Q1 <- quartis[1]
Q2 <- quartis[2]
Q3 <- quartis[3]

iqr_valor <- IQR(dados_ordenados)
lower_bound <- Q1 - 1.5 * iqr_valor
upper_bound <- Q3 + 1.5 * iqr_valor

cat("RESULTADOS DA QUESTÃO 2 - QUARTIS E LIMITES\n")
cat("1. Primeiro Quartil (Q1 - 25%):", Q1, "\n")
cat("2. Segundo Quartil / Mediana (Q2 - 50%):", Q2, "\n")
cat("3. Terceiro Quartil (Q3 - 75%):", Q3, "\n")
cat("4. Intervalo Interquartil (IQR):", iqr_valor, "\n")
cat("5. Limite Inferior (Lower Bound):", lower_bound, "\n")
cat("6. Limite Superior (Upper Bound):", upper_bound, "\n")