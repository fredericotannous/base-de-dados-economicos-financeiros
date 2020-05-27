nome_carteira = "juros"
dt = as.Date("2018-01-01")

ler_movimentacoes_GET = function(nome_carteira, dt){
  stopifnot(length(nome_carteira) == 1, nome_carteira %in% c("juros", "acoes"),
            length(dt) == 1, is(dt, "Date"))
  url = paste0(
    "http://localhost:9454/DownloadReport?",
    "name=", nome_carteira,
    "&date=", format(dt, "%d/%m/%Y"))
  
  
  dados = read.csv2(url, stringsAsFactors = FALSE)
  dados$data = as.Date(dados$data, "%Y-%m-%d")
  return(dados) 
   
}
