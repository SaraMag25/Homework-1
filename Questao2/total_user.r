library(readxl)
library(openxlsx)

arquivo_entrada <- "../Questao1/data_group.xlsx"
arquivo_saida <- "total_user.xlsx"

if (!file.exists(arquivo_entrada)) {
  stop("Arquivo 'data_group.xlsx' não encontrado na pasta Questao1.")
}

dados <- read_excel(arquivo_entrada)

colunas_essenciais <- c("casual", "registered", "season", "weathersit", "dteday")
faltantes <- setdiff(colunas_essenciais, names(dados))

if (length(faltantes) > 0) {
  stop(paste("Colunas ausentes no arquivo Excel:", paste(faltantes, collapse = ", ")))
}

dados$total_user <- dados$casual + dados$registered

dados$season <- factor(
  dados$season,
  levels = c(1, 2, 3, 4),
  labels = c("Inverno", "Primavera", "Verão", "Outono")
)

dados$weathersit <- factor(
  dados$weathersit,
  levels = c(1, 2, 3, 4),
  labels = c("Céu limpo", "Nublado", "Chuva fraca", "Chuva forte")
)

dados$dteday <- as.Date(dados$dteday)

dados <- dados[order(dados$dteday), ]

write.xlsx(
  dados,
  file = arquivo_saida,
  rowNames = FALSE,
  overwrite = TRUE
)

cat("Arquivo gerado com sucesso:", arquivo_saida, "\n")

str(dados)
head(dados)
summary(dados$total_user)