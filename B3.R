ler_bmf_indices = function(dt){
  stopifnot(is(dt, 'Date'), length(dt) == 1)
  
  url = format(dt, "ftp://ftp.bmf.com.br/IndicadoresEconomicos/ID%y%m%d.ex_")

  filename = format(dt, 'Downloads/%y%m%d.exe') #troca-se a extensão do arquivo
             
  download.file(url = url, destfile = filename, mode = 'wb')  #arquivo do tipo binário      

  files = unzip(zipfile = filename, exdir = 'Downloads')

  layout = read.csv2('Layout/layout_bmfindic.csv', stringsAsFactors = FALSE)

  dados = read.fwf(
    file = files, 
    widths = layout$tamanho, 
    header = FALSE, 
    col.names = layout$campo, 
    stringsAsFactors = FALSE, 
    strip.white = TRUE
  )
   file.remove(files)
 
  dados$DT_ARQUIVO = as.Date(as.character(dados$DT_ARQUIVO), '%Y%m%d') #temos que converter em strings para, depois, convertermos em datas.

  dados$VL_INDICADOR = dados$VL_INDICADOR/(10^dados$NUM_CASAS_DECIMAIS)

  dados$NUM_CASAS_DECIMAIS = NULL

  dados = dados[dados$DT_ARQUIVO == dt,]

  return(dados)
}

dt = as.Date("2018-7-13")
dados = ler_bmf_indices(dt)
