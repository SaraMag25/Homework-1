library(dplyr)
library(ggplot2)
library(scales)
library(readxl)

dados <- read_excel("Questao2/2.1.total_user/2.1.total_user.xlsx")
limite_inferior <- quantile(dados$total_user, 0.25, na.rm = TRUE)

dados <- dados %>%
  mutate(low_usage = ifelse(total_user < limite_inferior, 1, 0))

estatisticas_clima <- dados %>%
  group_by(weathersit) %>%
  summarise(
    media_utilizadores = mean(total_user, na.rm = TRUE),
    desvio_padrao = sd(total_user, na.rm = TRUE),
    total_dias = n(),
    dias_low_usage = sum(low_usage == 1, na.rm = TRUE), 
    proporcao_low_usage = dias_low_usage / total_dias
  )

print("Estatísticas por Condição Meteorológica")
print(estatisticas_clima)

grafico_boxplot <- ggplot(dados, aes(x = as.factor(weathersit), y = total_user, fill = as.factor(weathersit))) +
  geom_boxplot() +
  labs(
    title = "Distribuição de Utilizadores por Condição Meteorológica",
    x = "Condição Meteorológica",
    y = "Total de Utilizadores",
    fill = "Clima"
  ) +
  theme_minimal()

grafico_proporcao <- ggplot(estatisticas_clima, aes(x = as.factor(weathersit), y = proporcao_low_usage, fill = as.factor(weathersit))) +
  geom_col() +
  scale_y_continuous(labels = percent_format()) +
  labs(
    title = "Proporção de Dias de Baixa Utilização por Clima",
    x = "Condição Meteorológica",
    y = "Proporção de 'Low Usage'",
    fill = "Clima"
  ) +
  theme_minimal()
# Como eu desenvolvi esta parte da questão no VS Code, executando o script pelo terminal, as imagens não aparecem na tela como acontece no painel "Plots" do RStudio. 
# Por isso, utilizo o ggsave para gerar as imagens e guardá-las diretamente na pasta "imagens" do repositório para depois as incluir no Overleaf.

ggsave("imagens/boxplot_clima.png", plot = grafico_boxplot, width = 8, height = 5)
ggsave("imagens/proporcao_low_usage.png", plot = grafico_proporcao, width = 8, height = 5)
