library(readxl)
library(openxlsx)

arquivo_entrada <- "data_group.xlsx"
arquivo_saida <- "data_group_total_user.xlsx"

if (!file.exists(arquivo_entrada)) {
  stop("Arquivo 'data_group.xlsx' não encontrado na pasta do projeto.")
}

dados <- read_excel(arquivo_entrada)

# Verifica colunas essenciais
colunas_essenciais <- c("casual", "registered", "season", "weathersit", "dteday")
faltantes <- setdiff(colunas_essenciais, names(dados))

if (length(faltantes) > 0) {
  stop(paste("Colunas ausentes no arquivo Excel:", paste(faltantes, collapse = ", ")))
}

# Total de usuários por dia
dados$total_user <- dados$casual + dados$registered

# Rotular as estações para não ficar só com números no gráfico
dados$season <- factor(
  dados$season,
  levels = c(1, 2, 3, 4),
  labels = c("Inverno", "Primavera", "Verão", "Outono")
)

# Mesma ideia para o clima
dados$weathersit <- factor(
  dados$weathersit,
  levels = c(1, 2, 3, 4),
  labels = c("Céu limpo", "Nublado", "Chuva fraca", "Chuva forte")
)

dados$dteday <- as.Date(dados$dteday)

dados <- dados[order(dados$dteday), ]

write.xlsx(dados, file = arquivo_saida, rowNames = FALSE)

cat("Arquivo gerado com sucesso:", arquivo_saida, "\n")

str(dados)
head(dados)
summary(dados$total_user)
