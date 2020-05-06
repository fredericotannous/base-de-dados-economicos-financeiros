install.packages("bizdays") #instala o pacote
library(bizdays) #carrega o pacote

#criando um calendário com feriados ANBIMA
holidaysANBIMA
create.calendar(name = "ANBIMA", holidays = holidaysANBIMA, weekdays=c("saturday", "sunday"))

#verificando se uma data é dia útil
d1 = as.Date("2018-01-07")
d1
d2 = as.Date("2018-01-17")
d2
is.bizday(d1, "ANBIMA")
is.bizday(d2, "ANBIMA")

#verificando se uma data é dia útil (vetorizado)
datas = seq(d1, d2, by="day")
datas
is.bizday(datas, "ANBIMA")

#gerando vetor de datas úteis
bizseq(from = d1, to = d2, cal = "ANBIMA")

#dias uteis entre datas
bizdays(from = d1, to = d2, cal = "ANBIMA")

#avançando/recuando n dias úteis
add.bizdays(as.Date("2018-01-12"), n = 1, "ANBIMA")
add.bizdays(as.Date("2018-01-15"), n = -2, "ANBIMA")

#ajuste para data útil mais próxima
adjust.next(as.Date("2018-01-13"), "ANBIMA")
adjust.previous(as.Date("2018-01-13"), "ANBIMA")

###EXEMPLO### - PRECIFICANDO UMA NTN-F
data_base = as.Date("2018-07-10")
vencimento = as.Date("2021-01-01")
tir = 9.04

proximos_pgtos = seq(from = vencimento, to = data_base, by = "-6 months")
proximos_pgtos
rev(proximo_pgtos)

proximos_pgtos = rev(proximos_pgtos)
proximos_pgtos

proximos_pgtos = adjust.next(proximos_pgtos, "ANBIMA")
proximos_pgtos

dias_uteis = bizdays(from = data_base, to = proximos_pgtos, cal = "ANBIMA")
dias_uteis

principal = 1000
juros = ((1+10/100)^(1/2)-1) * principal
juros

#valor futuro
vf = rep(juros, length(proximos_pgtos)) #pgtos de juros
vf[length(vf)]
vf[length(vf)] = vf[length(vf)] + principal
vf

#calculo do preço
vp = vf / ((1+tir/100)^(dias_uteis/252))
vp
preco = sum(vp)
preco

#dataframe com detalhamento da precificação
ntn_f = data.frame(
  datas = proximos_pgtos, 
  prazo_dias_uteis = dias_uteis, 
  vf = vf, 
  vp = vp
)

ntn_f
data_base
vencimento
tir
preco