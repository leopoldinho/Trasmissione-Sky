#Libraries



library(devtools) 
library(tidyverse)
library(googlesheets4)
library(httr)
library(jsonlite)
library(lubridate)

#Scarico dati Abruzzo
download.file("https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniAbruzzo_csv.zip",
              "abruzzo.zip")
download.file("https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniAbruzzo_csv.zip",
              "abruzzo_sem.zip")


#Sistemo il dataset ultimi due anni (compreso quello in corso)
abruzzo_mese = read.csv2(unzip( "abruzzo.zip")) %>%
  select(DataAccadimento, DataMorte, Genere, Eta, LuogoNascita, SettoreAttivitaEconomica)%>%
  filter(DataMorte !="")

abruzzo_mese$DataAccadimento = 
  as.Date(abruzzo_mese$DataAccadimento,format ="%d/%m/%Y")
abruzzo_mese$DataMorte = 
  as.Date(abruzzo_mese$DataMorte,format ="%d/%m/%Y")

#Sistemo il dataset 6 anni precedenti
abruzzo_semest = read.csv2(unzip( "abruzzo_sem.zip")) %>%
  select(DataAccadimento, DataMorte, Genere, Eta, LuogoNascita, SettoreAttivitaEconomica)%>%
  filter(DataMorte !="")

abruzzo_semest$DataAccadimento = 
  as.Date(abruzzo_semest$DataAccadimento,format ="%d/%m/%Y")
abruzzo_semest$DataMorte = 
  as.Date(abruzzo_semest$DataMorte,format ="%d/%m/%Y")

#unisco i dataset e calcolo andamento mensile
abruzzo_morti_lavoro = bind_rows(abruzzo_semest,abruzzo_mese) %>%
  mutate(decessi=as.numeric(1))%>% 
  group_by(month = lubridate::floor_date(DataMorte, "month")) %>%
  summarize(decessi_lavoro = sum(decessi)) %>%
  rename(mese=month)

#nb: provare a distinguera tra maschi e femmine


#API
res = GET("https://dati.inail.it/api/OpenData/DatiConCadenzaSemestraleInfortuni",
          query = list(Regione = "Abruzzo", AnnoAccadimento="2021",MeseAccadimento="7" ))