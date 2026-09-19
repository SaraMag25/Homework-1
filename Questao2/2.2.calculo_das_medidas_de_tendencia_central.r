library(readxl)

arquivo <- "2.1.total_user.xlsx"

dados <- read_excel(arquivo)

calcular_moda <- function(x) {
  frequencias <- table(x)
  maior_frequencia <- max(frequencias)
  modas <- names(frequencias)[frequencias == maior_frequencia]

  list(
    valores = as.numeric(modas),
    frequencia = maior_frequencia
  )
}

mostrar_resultados <- function(nome, x) {
  media <- mean(x, na.rm = TRUE)
  mediana <- median(x, na.rm = TRUE)
  moda <- calcular_moda(x)

  cat(nome, "\n")
  cat("Média:", round(media, 2), "\n")
  cat("Mediana:", round(mediana, 2), "\n")
  cat("Moda:", paste(moda$valores, collapse = ", "), "\n")
  cat("Frequência da moda:", moda$frequencia, "\n")
  cat("\n")
}

mostrar_resultados("TEMPERATURA", dados$temp)
mostrar_resultados("USUÁRIOS CASUAIS", dados$casual)
mostrar_resultados("USUÁRIOS REGISTRADOS", dados$registered)
mostrar_resultados("TOTAL DE USUÁRIOS", dados$total_user)