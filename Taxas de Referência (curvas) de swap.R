

ler_bmf_swap = function(dt){
 
  stopifnot(is(dt, "Date"), length(dt) == 1)
  
  url = format(dt, "ftp://ftp.bmf.com.br/TaxasSwap/TS%y%m%d.ex_")
  
  filename = format(dt, "Downloads/TS%y%m%d.exe")
  
  download.file(url, filename, mode = "wb")
  
  files = unzip(filename, exdir = "Downloads")
  
  layout = read.csv2("Layout/layout_taxaswap.csv", stringsAsFactors = FALSE)
  
  dados = read.fwf(files, 
                   widths = layout$tamanho, 
                   header = FALSE, 
                   col.names = layout$campo, 
                   strip.white = TRUE,
                   stringsAsFactors = FALSE
)                 
  
  dados$VL_TAXA = dados$VL_TAXA/10^7
  dados$VL_TAXA = ifelse(dados$SINAL_VL_TAXA == "-", yes= -dados$VL_TAXA , no= dados$VL_TAXA)
  
  dados$SINAL_VL_TAXA = NULL
  dados$DT_ARQUIVO = as.Date(as.character(dados$DT_ARQUIVO), "%Y%m%d")
  
  return(dados)
}
