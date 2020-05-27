library(readxl)

ler_ibge_ipca_por_subitem = function(dt){
  stopifnot(is(dt, "Date"), length(dt) == 1)
 
   if(dt >= as.Date("2018-01-01")){
    url = format(dt, 
                 "ftp://ftp.ibge.gov.br/Precos_Indices_de_Precos_ao_Consumidor/IPCA/Resultados_por_Subitem/2018/ipca_%Y%mSubitem.zip")  
  } else {
    
    url = format(dt, 
                 "ftp://ftp.ibge.gov.br/Precos_Indices_de_Precos_ao_Consumidor/IPCA/Resultados_por_Subitem/%Y/ipca_%Y%mSubitem.zip")
    
  }
  
  filename = format(dt, "Downloads/ipca_%Y%mSubitem.zip")
  
  download.file(url = url, destfile = filename, mode = "wb")
  
  files = unzip(zipfile = filename, exdir = "Downloads")
  
  dados = read_excel(path = files, sheet = 1, skip = 4, col_names = TRUE)
  dados = as.data.frame(dados)
  
  file.remove(files)
  
  colnames(dados)[1] = "SUBITEM"
  
  for(i in 2:ncol(dados)){
    
    dados[,i] = suppressWarnings(as.numeric(dados[,i]))
  }
  
  dados = dados[-1,]
  
  return(dados)
  
}
 