
args <- commandArgs(trailingOnly = TRUE)
arquivo <- if (length(args) >= 1L) args[[1L]] else "HW1_bike_sharing.csv"
pasta_figuras <- if (length(args) >= 2L) args[[2L]] else "figuras"
dir.create(pasta_figuras, recursive = TRUE, showWarnings = FALSE)

dados <- read.csv(arquivo, check.names = FALSE, stringsAsFactors = FALSE)
campos <- c("instant", "dteday", "season", "weathersit",
            "temp", "casual", "registered")
stopifnot(nrow(dados) == 731L, all(campos %in% names(dados)))


M <- 581706L
r <- 1L + (M %% 100L)
data_group <- dados[r:(r + 299L), , drop = FALSE]
data_group$dteday <- as.Date(data_group$dteday)
stopifnot(
  nrow(data_group) == 300L,
  data_group$instant[[1L]] == 7L,
  data_group$instant[[300L]] == 306L,
  !anyNA(data_group[campos])
)

data_group$total_user <- data_group$casual + data_group$registered
q1 <- unname(quantile(data_group$total_user, probs = 0.25, type = 7))
data_group$low_usage <- as.integer(data_group$total_user < q1)

if (all(data_group$temp >= 0 & data_group$temp <= 1)) {
  data_group$temp_c <- 41 * data_group$temp
} else if (all(data_group$temp >= -30 & data_group$temp <= 50)) {
  data_group$temp_c <- data_group$temp
} else {
  stop("A escala da coluna temp não foi reconhecida.")
}

baixo <- data_group$low_usage == 1L
cores <- c(baixo = "#CF542F", demais = "#197D91")
cor_pontos <- ifelse(baixo, cores[["baixo"]], cores[["demais"]])
lim_x <- range(data_group$temp_c)
lim_y <- c(0, max(data_group$total_user) * 1.06)

# Gráfico 1: dispersão conjunta e limite usado para formar os dois grupos.
figura_1 <- file.path(pasta_figuras, "questao_4_3_dispersao.png")
png(figura_1, width = 2400, height = 1550, res = 240)
par(mar = c(5.2, 5.6, 4.3, 1.2))
plot(
  data_group$temp_c, data_group$total_user,
  xlim = lim_x, ylim = lim_y, pch = 16, cex = 0.85,
  col = adjustcolor(cor_pontos, alpha.f = 0.68),
  main = "Temperatura e utilização diária",
  xlab = "Temperatura (°C)", ylab = "Total de usuários por dia"
)
abline(h = q1, col = "#585858", lwd = 2, lty = 2)
legend(
  "topleft",
  legend = c(sprintf("Baixa utilização (n = %d)", sum(baixo)),
             sprintf("Demais dias (n = %d)", sum(!baixo)),
             sprintf("Primeiro quartil: %.1f", q1)),
  col = c(cores[["baixo"]], cores[["demais"]], "#585858"),
  pch = c(16, 16, NA_integer_), lty = c(NA_integer_, NA_integer_, 2),
  lwd = c(NA_real_, NA_real_, 2), bty = "n", cex = 0.83
)
grid(col = adjustcolor("gray60", alpha.f = 0.25))
dev.off()

# Gráfico 2: a mesma escala nos dois painéis permite comparar as faixas.
# As retas são apenas descrições de cada subconjunto, não efeitos causais.
figura_2 <- file.path(pasta_figuras, "questao_4_3_paineis.png")
png(figura_2, width = 2500, height = 1450, res = 240)
par(mfrow = c(1, 2), mar = c(5.1, 5.2, 4.5, 1.2), oma = c(0, 0, 1, 0))
for (i in seq_along(list(baixo, !baixo))) {
  idx <- list(baixo, !baixo)[[i]]
  cor <- if (i == 1L) cores[["baixo"]] else cores[["demais"]]
  titulo <- if (i == 1L) "Baixa utilização" else "Demais dias"
  plot(
    data_group$temp_c[idx], data_group$total_user[idx],
    xlim = lim_x, ylim = lim_y, pch = 16, cex = 0.8,
    col = adjustcolor(cor, alpha.f = 0.65),
    main = sprintf("%s (n = %d)", titulo, sum(idx)),
    xlab = "Temperatura (°C)", ylab = "Total de usuários por dia"
  )
  abline(h = q1, col = "#585858", lty = 2)
  ajuste <- lm(total_user ~ temp_c, data = data_group[idx, , drop = FALSE])
  grade <- seq(min(data_group$temp_c[idx]), max(data_group$temp_c[idx]),
               length.out = 100L)
  lines(grade,
        predict(ajuste, newdata = data.frame(temp_c = grade)),
        col = cor, lwd = 2.2)
  grid(col = adjustcolor("gray60", alpha.f = 0.25))
}
mtext("Mesmas escalas nos dois painéis; retas descritivas", outer = TRUE,
      line = -0.2, cex = 0.85)
dev.off()


resumo <- data.frame(
  grupo = c("Baixa utilização", "Demais dias"),
  n = c(sum(baixo), sum(!baixo)),
  temperatura_media_c = c(mean(data_group$temp_c[baixo]),
                          mean(data_group$temp_c[!baixo])),
  temperatura_min_c = c(min(data_group$temp_c[baixo]),
                        min(data_group$temp_c[!baixo])),
  temperatura_max_c = c(max(data_group$temp_c[baixo]),
                        max(data_group$temp_c[!baixo])),
  correlacao = c(cor(data_group$temp_c[baixo], data_group$total_user[baixo]),
                cor(data_group$temp_c[!baixo], data_group$total_user[!baixo]))
)
cat("Datas selecionadas:", as.character(data_group$dteday[[1L]]), "a",
    as.character(data_group$dteday[[300L]]), "\n")
cat("Q1:", q1, "\n")
print(resumo, row.names = FALSE)
cat("Gráficos:", figura_1, "e", figura_2, "\n")
