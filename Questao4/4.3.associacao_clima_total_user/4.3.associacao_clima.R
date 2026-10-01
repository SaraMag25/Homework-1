library(readxl)
dados <- read_excel("Questao2/2.1.total_user/total_user.xlsx")
dados$weathersit <- as.factor(dados$weathersit)
modelo_anova <- aov(total_user ~ weathersit, data = dados)

cat("RESULTADO ESTATÍSTICO (ANOVA) \n")
print(summary(modelo_anova))
png("Questao 4/4.3.associacao_clima_total_user/imagens_4.3/4.3.boxplot_clima.png", width = 800, height = 600, res = 120)

boxplot(total_user ~ weathersit, data = dados,
        main = "Associação entre Clima e Alugueres Diários",
        xlab = "Condição Meteorológica (1=Bom, 2=Nublado/Misto, 3=Chuva/Neve Leve)",
        ylab = "Total de Utilizadores",
        col = c("#A8E6CF", "#FFD3B6", "#FF8A8A"), 
        border = "darkgray")

dev.off()