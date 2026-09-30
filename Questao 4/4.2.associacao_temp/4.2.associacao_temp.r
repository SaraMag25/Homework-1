library(readxl)
dados <- read_excel("Questao2/2.1.total_user/2.1.total_user.xlsx")
correlacao <- cor(dados$temp, dados$total_user, method = "pearson")

cat("Coeficiente de Correlação de Pearson (Temperatura x Total Users):", round(correlacao, 4), "\n")

png("Questao 4/4.2.associacao_temp/imagens_4.2/4.2.grafico_dispersao_temp.png", width = 800, height = 600, res = 120)

plot(dados$temp, dados$total_user,
     main = "Associação entre Temperatura e Alugueres Diários",
     xlab = "Temperatura Normalizada",
     ylab = "Total de Utilizadores",
     pch = 19,            
     col = "steelblue",   
     cex = 0.8)           

modelo_linear <- lm(total_user ~ temp, data = dados)
abline(modelo_linear, col = "red", lwd = 2)

dev.off()