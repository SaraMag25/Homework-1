library(readxl)
library(openxlsx)

arquivo_entrada <- "2.1.total_user.xlsx"
arquivo_saida <- "2.5.low_usage.xlsx"

dados <- read_excel(arquivo_entrada)

Q1 <- quantile(dados$total_user, 0.25)

dados$low_usage <- ifelse(
  dados$total_user < Q1,
  1,
  0
)

numero_low_usage <- sum(dados$low_usage)

proporcao_low_usage <- mean(dados$low_usage)

cat("Q1:", Q1, "\n")
cat("Número de dias de baixa utilização:", numero_low_usage, "\n")
cat("Proporção de dias de baixa utilização:", proporcao_low_usage, "\n")
cat("Porcentagem de dias de baixa utilização:",
    proporcao_low_usage * 100, "%\n")

write.xlsx(
  dados,
  arquivo_saida,
  overwrite = TRUE
)

View(dados)