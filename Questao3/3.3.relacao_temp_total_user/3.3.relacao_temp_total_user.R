library(readxl)

arquivo_entrada <- "2.1.total_user.xlsx"

dados <- read_excel(arquivo_entrada)

correlacao <- cor(
  dados$temp,
  dados$total_user,
  method = "pearson"
)

cat("Coeficiente de correlação de Pearson:", correlacao, "\n")

png(
  "3.1.grafico_temp_total_user.png",
  width = 1200,
  height = 800,
  res = 120
)

plot(
  dados$temp,
  dados$total_user,
  main = "Relação entre temperatura e total de usuários",
  xlab = "Temperatura",
  ylab = "Total de usuários",
  pch = 19
)

abline(
  lm(total_user ~ temp, data = dados),
  lwd = 2
)

dev.off()

plot(
  dados$temp,
  dados$total_user,
  main = "Relação entre temperatura e total de usuários",
  xlab = "Temperatura",
  ylab = "Total de usuários",
  pch = 19
)

abline(
  lm(total_user ~ temp, data = dados),
  lwd = 2
)