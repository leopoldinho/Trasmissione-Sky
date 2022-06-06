#Libraries

library(devtools) 
library(tidyverse)
library(googlesheets4)
library(httr)
library(jsonlite)


#Scarico dati Abruzzo
download.file("https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniAbruzzo_csv.zip",
              "abruzzo.zip")
download.file("https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniAbruzzo_csv.zip",
              "abruzzo_sem.zip")



abruzzo_mese = read.csv2(unzip( "abruzzo.zip"))
abruzzo_mese$DataRilevazione <- 
  as.Date(abruzzo_mese$DataRilevazione,format ="%d/%m/%Y")
abruzzo_mese$DataProtocollo <- 
  as.Date(abruzzo_mese$DataProtocollo,format ="%d/%m/%Y")
abruzzo_mese$DataAccadimento <- 
  as.Date(abruzzo_mese$DataAccadimento,format ="%d/%m/%Y")
abruzzo_mese$DataMorte <- 
  as.Date(abruzzo_mese$DataMorte,format ="%d/%m/%Y")


abruzzo_semest = read.csv2(unzip( "abruzzo_sem.zip"))
abruzzo_semest$DataRilevazione <- 
  as.Date(abruzzo_semest$DataRilevazione,format ="%d/%m/%Y")
abruzzo_semest$DataProtocollo <- 
  as.Date(abruzzo_semest$DataProtocollo,format ="%d/%m/%Y")
abruzzo_semest$DataAccadimento <- 
  as.Date(abruzzo_semest$DataAccadimento,format ="%d/%m/%Y")
abruzzo_semest$DataDefinizione <- 
  as.Date(abruzzo_semest$DataDefinizione,format ="%d/%m/%Y")
abruzzo_semest$DataMorte <- 
  as.Date(abruzzo_semest$DataMorte,format ="%d/%m/%Y")




#API
res = GET("https://dati.inail.it/api/OpenData/DatiConCadenzaSemestraleInfortuni",
          query = list(Regione = "Abruzzo", AnnoAccadimento="2021",MeseAccadimento="7" ))