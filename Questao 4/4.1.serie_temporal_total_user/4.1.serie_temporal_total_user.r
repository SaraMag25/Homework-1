setwd("C:/Users/clari/Programas - estudo/Trabalhos Faculdade/Homework-1")

source("Questao1/1.2.data_group/1.2.data_group.R")

data_group <- dados

data_group$total_user <- data_group$casual + data_group$registered

data_group <- data_group[order(data_group$dteday), ]

indice_max <- which.max(data_group$total_user)
indice_min <- which.min(data_group$total_user)

png(
  filename = "Questao 4/4.1.serie_temporal_total_user.png",
  width = 1400,
  height = 800,
  res = 150
)

plot(
  data_group$dteday,
  data_group$total_user,
  type = "l",
  lwd = 2,
  xlab = "Data",
  ylab = "Total de usuários",
  main = "Série temporal do total de usuários"
)

points(
  data_group$dteday,
  data_group$total_user,
  pch = 16,
  cex = 0.4
)

points(
  data_group$dteday[indice_max],
  data_group$total_user[indice_max],
  pch = 19,
  cex = 1.2
)

points(
  data_group$dteday[indice_min],
  data_group$total_user[indice_min],
  pch = 19,
  cex = 1.2
)

text(
  data_group$dteday[indice_max],
  data_group$total_user[indice_max],
  labels = paste(
    "Máximo:",
    data_group$total_user[indice_max]
  ),
  pos = 3
)

text(
  data_group$dteday[indice_min],
  data_group$total_user[indice_min],
  labels = paste(
    "Mínimo:",
    data_group$total_user[indice_min]
  ),
  pos = 1
)

dev.off()

cat("\nMAIOR UTILIZAÇÃO\n")
cat(
  "Data:",
  as.character(data_group$dteday[indice_max]),
  "\n"
)
cat(
  "Total de usuários:",
  data_group$total_user[indice_max],
  "\n"
)

cat("\nMENOR UTILIZAÇÃO\n")
cat(
  "Data:",
  as.character(data_group$dteday[indice_min]),
  "\n"
)
cat(
  "Total de usuários:",
  data_group$total_user[indice_min],
  "\n"
)