# =============================================================================
# MINICURSO: PRIMEIROS PASSOS NO R  (2 horas)
# Profa. Naiara Sandi de Almeida Alcantara - PPGCP / FCS - UFPA
#
# COMO USAR ESTE SCRIPT
# - Rode uma linha por vez com Ctrl + Enter (Cmd + Enter no Mac).
# - Tudo que vem depois do simbolo # e comentario: o R le e ignora.
# - Nao apague os comentarios. Eles sao a sua aula gravada por escrito.
# - Nao precisa instalar nenhum pacote para rodar este script.
# =============================================================================


# -----------------------------------------------------------------------------
# BLOCO 2 - PRIMEIRO CONTATO COM O RSTUDIO
# -----------------------------------------------------------------------------

# O console e uma calculadora. Teste:
2 + 2
10 / 3
(5 * 4) - 2

# Onde o R esta trabalhando agora? (diretorio de trabalho)
getwd()

# Para mudar o diretorio, use o atalho Ctrl + Shift + H
# ou escreva o caminho da pasta, assim (ajuste para a sua maquina):
# setwd("C:/curso_R")

# Dica: no Windows, troque as barras invertidas \ por barras normais /


# -----------------------------------------------------------------------------
# BLOCO 3 - A LOGICA DO R: OBJETO, FUNCAO E PACOTE
# -----------------------------------------------------------------------------

## 3.1 OBJETO ----------------------------------------------------------------
# Objeto e qualquer coisa a que damos um nome e guardamos na memoria.
# A seta <- e o gesto de guardar. Atalho de teclado: Alt + -

idade <- 27          # guardei o numero 27 no objeto chamado "idade"
idade                # pedindo para o R mostrar o que ha dentro do objeto

nome <- "Maria"      # texto SEMPRE entre aspas
nome

# Objeto guardado pode ser usado em contas:
idade * 2
idade + 10

# ATENCAO: o R diferencia maiuscula de minuscula.
# "idade" e "Idade" sao dois objetos diferentes.

# A funcao c() junta varios valores em um unico objeto (um vetor):
idades <- c(21, 34, 45, 29)
idades

# Repare no Environment (quadrante superior direito): os objetos aparecem la.


## 3.2 FUNCAO ----------------------------------------------------------------
# Se o objeto e o substantivo, a funcao e o verbo:
# nome_da_funcao(argumento)

mean(idades)      # media
median(idades)    # mediana
min(idades)       # menor valor
max(idades)       # maior valor
length(idades)    # quantos casos existem
summary(idades)   # varios resumos de uma vez

# Nao sabe o que uma funcao faz? Pergunte ao R:
?mean
# A ajuda abre no quadrante Help. Dica: leia primeiro os EXEMPLOS, no final.


## 3.3 PACOTE ----------------------------------------------------------------
# Pacote e um conjunto de funcoes que outra pessoa escreveu e disponibilizou.
# Instalar = baixar o aplicativo (UMA VEZ SO).
# library = abrir o aplicativo (TODA VEZ que abrir o R).

# install.packages("descr")   # rode so uma vez, sem o # na frente
# library(descr)              # rode em toda sessao nova

# Pacotes que aparecem na versao completa do curso:
# haven   -> abre bases do SPSS (.sav) e do Stata (.dta)
# readxl  -> abre planilhas do Excel (.xlsx)
# ggplot2 -> graficos para publicacao
# dplyr   -> manipulacao de bases


## 3.4 ERROS SAO NORMAIS -----------------------------------------------------
# Rode a linha abaixo e leia a mensagem:
# idadee
# Error: object 'idadee' not found  ->  o objeto nao existe (erro de digitacao)

# Se o console ficar com um "+" piscando, faltou fechar parentese ou aspas.
# Solucao: aperte Esc e escreva a linha de novo.

dd

# -----------------------------------------------------------------------------
# BLOCO 5 - NOSSA PRIMEIRA ANALISE
# -----------------------------------------------------------------------------

## 5.1 CRIANDO A BASE DA TURMA -----------------------------------------------
# Primeiro criamos cada coluna separadamente (vetores).
# ATENCAO: todos os vetores precisam ter o MESMO numero de elementos.

id        <- 1:8                                        # de 1 ate 8
idade     <- c(21, 34, 45, 29, 23, 38, 52, 26)          # quantitativa
sexo      <- c("F", "M", "F", "F", "M", "M", "F", "M")  # qualitativa nominal
curso     <- c("CSociais", "Direito", "CPolitica", "CSociais",
               "CPolitica", "Direito", "CSociais", "CPolitica")
interesse <- c(4, 5, 3, 4, 2, 5, 3, 4)                  # ordinal, de 1 a 5

# Agora juntamos os vetores em uma base de dados (data frame):
turma <- data.frame(id, idade, sexo, curso, interesse)

# Olhando a base:
turma          # imprime no console
View(turma)    # abre a tabela em uma aba (V maiusculo!)

# talvez os valores acima pelos dados
# reais das pessoas presentes na sala


## 5.2 CONHECENDO A BASE ANTES DE ANALISAR -----------------------------------

str(turma)       # estrutura: quantos casos, quantas variaveis, e de que tipo
summary(turma)   # resumo de todas as variaveis de uma vez
head(turma)      # primeiras linhas
nrow(turma)      # numero de linhas  (casos)
ncol(turma)      # numero de colunas (variaveis)
names(turma)     # nomes das variaveis

# O R chuta o tipo de cada variavel, mas quem decide se esta certo e voce.
# "sexo" e "curso" sao categorias: o correto e transforma-las em fator.
turma$sexo  <- as.factor(turma$sexo)
turma$curso <- as.factor(turma$curso)

str(turma)   # confira: agora aparece "Factor" nessas duas variaveis

# "interesse" e ordinal (1 a 5, com ordem). Se quisermos tratar como fator
# ordenado, fazemos assim:
# turma$interesse <- factor(turma$interesse, levels = 1:5, ordered = TRUE)


## 5.3 SELECIONANDO PARTES DA BASE -------------------------------------------
# O cifrao ($) chama uma coluna dentro da base:
turma$idade
turma$curso

# Tambem da para usar colchetes: base[linha, coluna]
turma[1, ]        # toda a linha 1
turma[, 2]        # toda a coluna 2
turma[1:3, ]      # linhas 1 a 3
turma[turma$idade > 30, ]   # so quem tem mais de 30 anos


## 5.4 DESCREVENDO: CONTAR E RESUMIR -----------------------------------------

# --- Variaveis QUALITATIVAS: contam-se os casos ---
table(turma$curso)                             # frequencia absoluta
table(turma$sexo)

prop.table(table(turma$curso))                 # proporcao
round(prop.table(table(turma$curso)) * 100, 1) # porcentagem com 1 casa

# --- Variaveis QUANTITATIVAS: resumem-se os valores ---
mean(turma$idade)     # media
median(turma$idade)   # mediana
sd(turma$idade)       # desvio-padrao
range(turma$idade)    # minimo e maximo
summary(turma$idade)

# Media x mediana: a media e sensivel a valores extremos, a mediana nao.
# Teste incluindo uma pessoa de 90 anos:
teste <- c(turma$idade, 90)
mean(teste)     # a media sobe bastante
median(teste)   # a mediana quase nao se move

# --- Cruzando duas variaveis ---
table(turma$sexo, turma$curso)

# Media de interesse por curso (a funcao tapply aplica uma funcao por grupo):
tapply(turma$interesse, turma$curso, mean)

# Se houver valores faltantes (NA), avise a funcao:
# mean(turma$idade, na.rm = TRUE)


## 5.5 O PRIMEIRO GRAFICO ----------------------------------------------------
# Os graficos aparecem no quadrante Plots (canto inferior direito).

# Barras - para variavel qualitativa
barplot(table(turma$curso),
        main = "Curso dos participantes",
        ylab = "Numero de pessoas",
        col  = "steelblue")

# Histograma - para variavel quantitativa
hist(turma$idade,
     main = "Distribuicao de idade da turma",
     xlab = "Idade (anos)",
     ylab = "Frequencia",
     col  = "lightblue")

# Boxplot - mediana, quartis e valores extremos
boxplot(turma$idade,
        main = "Idade da turma",
        ylab = "Anos")

# Boxplot comparando grupos (o til ~ le-se "em funcao de")
boxplot(turma$idade ~ turma$sexo,
        main = "Idade por sexo",
        xlab = "Sexo", ylab = "Idade")

# Dispersao - duas variaveis quantitativas
plot(turma$idade, turma$interesse,
     main = "Idade e interesse por politica",
     xlab = "Idade", ylab = "Interesse (1 a 5)",
     pch  = 19)

# Para exportar: no quadrante Plots, clique em Export > Save as Image / PDF.


## 5.6 SALVANDO O TRABALHO ---------------------------------------------------

# 1. O SCRIPT: Ctrl + S. E o arquivo mais importante do dia.
# 2. A base no formato do R:
save(turma, file = "turma.RData")
# Para abrir depois:  load("turma.RData")

# 3. A base em CSV (abre no Excel e em qualquer software):
write.csv2(turma, "turma.csv", row.names = FALSE)
# Para abrir depois:  turma <- read.csv2("turma.csv")

# Tudo isso e salvo no diretorio de trabalho. Confira com getwd().


# -----------------------------------------------------------------------------
# DESAFIOS
# -----------------------------------------------------------------------------
# 1. Refaca a base usando outros dados hipotéticos ou da sua própria pesquisa
#    (dez linhas ja bastam).
#
# 2. Descreva duas variaveis: uma com table() e outra com summary().
#    Escreva em UMA FRASE, como comentario aqui no script, o que voce achou.
#
# 3. Faca um grafico, exporte a imagem e me envie: o script e a imagem.
#
# Repositorio do curso: https://github.com/NaiaraSandi1995/CursoR2024
# Instalacao: https://posit.co/download/rstudio-desktop/
# =============================================================================
