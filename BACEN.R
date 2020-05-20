dt = as.Date("2018-07-13")

ler_bacen_negocios_tpf = function(dt){
  stopifnot(is(dt, "Date"), length(dt) == 1)
  
  url = format(dt, "https://www4.bcb.gov.br/pom/demab/negociacoes/download/NegE%Y%m.ZIP")
  
  filename = format(dt, 'Downloads/NegE%Y%m.ZIP')
  
  download.file(url = url, destfile = filename, mode = 'wb')             
  
  files = unzip(zipfile = filename, exdir = 'Downloads')
  dados = read.csv2(files, stringsAsFactors = FALSE)
  file.remove(files)
  file.remove(filename)
  
  dados$DATA.MOV = as.Date(dados$DATA.MOV, "%d%m%Y")
  dados$EMISSAO = as.Date(dados$EMISSAO, "%d%m%Y")
  dados$VENCIMENTO = as.Date(dados$VENCIMENTO, "%d%m%Y")
  
  
  dados = dados[dados$DATA.MOV == dt,]
  View(dados)
  return(dados)
}


