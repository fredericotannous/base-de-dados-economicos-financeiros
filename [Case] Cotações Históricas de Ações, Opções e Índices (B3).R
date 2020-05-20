ler_bmf_cotahist = function(dt){
  
  stopifnot(is(dt, "Date"), length(dt) == 1)
  
  url = format(dt, "http://bvmf.bmfbovespa.com.br/InstDados/SerHist/COTAHIST_D%d%m%Y.ZIP")
  filename = format(dt, "Downloads/COTAHIST_D%d%m%Y.ZIP")
  download.file(url = url, destfile = filename, mode = "wb")
  
  file = unzip(zipfile = filename, exdir = "Downloads")
  
  layout = read.csv2("Layout/layout_cotahist.csv", stringsAsFactors = FALSE)
  
  dados = read.fwf(
    file = file, 
    widths = layout$tamanho, 
    header = FALSE, 
    col.names = layout$campo, 
    skip = 1,
    stringsAsFactors = FALSE)
  
  file.remove(file)
  
  
  
  dados = dados[-nrow(dados),] #retirada a última linha
  
  dados$DATA_PREGAO = as.Date(dados$DATA_PREGAO, "%Y%m%d")
  dados$DATVEN = as.Date(as.character(dados$DATVEN), "%Y%m%d")
  
  cols = c(
    "PREABE", "PREMAX", "PREMIN", 
    "PREMED", "PREULT", "PREOFC",
    "PREOFV", "PREEXE")
  
  for(nome_coluna in cols){
    dados[,nome_coluna] = dados[,nome_coluna]/100}
  
  
  return(dados)
  
  
}

