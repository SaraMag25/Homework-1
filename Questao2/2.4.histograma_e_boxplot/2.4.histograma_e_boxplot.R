library(ggplot2)
names(X2_1_total_user)

hist(X2_1_total_user$total_user, 
     main = "Histograma de total_user",       
     xlab = "Distribuição do número total de usuários por dia.",   # nome do eixo X 
     ylab = "Densidade", # nome do eixo Y 
     freq = FALSE, # coloca em densidade
     col = "lightblue")              


ggplot(X2_1_total_user, aes(x = "", y = total_user)) +
  geom_boxplot(fill = "lightblue", color = "black", width = 0.35) +
  theme_minimal() +
  labs(title = "Distribuição do Total de Usuários Diários",
       y = "Número Total de Usuários (total_user)",
       x = "") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))

