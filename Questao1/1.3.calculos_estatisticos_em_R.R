source("2.1.total_user.R")

calcula_moda <- function(v) {
  frequencias <- table(v)
  maior_frequencia <- max(frequencias)

  if (maior_frequencia == 1) {
    return("Amodal")
  } else {
    return(as.numeric(names(frequencias)[frequencias == maior_frequencia]))
  }
}

cat("RESULTADOS DA QUESTÃO 2\n\n")

cat("TEMPERATURA\n")
cat("Média:", mean(dados$temp, na.rm = TRUE), "\n")
cat("Mediana:", median(dados$temp, na.rm = TRUE), "\n")
cat("Moda:", calcula_moda(dados$temp), "\n\n")

cat("USUÁRIOS CASUAIS\n")
cat("Média:", mean(dados$casual, na.rm = TRUE), "\n")
cat("Mediana:", median(dados$casual, na.rm = TRUE), "\n")
cat("Moda:", calcula_moda(dados$casual), "\n\n")

cat("USUÁRIOS REGISTRADOS\n")
cat("Média:", mean(dados$registered, na.rm = TRUE), "\n")
cat("Mediana:", median(dados$registered, na.rm = TRUE), "\n")
cat("Moda:", calcula_moda(dados$registered), "\n\n")

cat("TOTAL DE USUÁRIOS\n")
cat("Média:", mean(dados$total_user, na.rm = TRUE), "\n")
cat("Mediana:", median(dados$total_user, na.rm = TRUE), "\n")
cat("Moda:", calcula_moda(dados$total_user), "\n")