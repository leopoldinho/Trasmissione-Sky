#Libraries
library(devtools) 
library(tidyverse)
library(googlesheets4)
library(httr)
library(jsonlite)
library(lubridate)

#Scarico dati Abruzzo e basilicata

url_mese = c("https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniAbruzzo_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniBasilicata_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniCalabria_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniCampania_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniEmiliaRomagna_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniFriuliVeneziaGiulia_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniLazio_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniLiguria_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniLombardia_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniMarche_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniMolise_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniPiemonte_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniPuglia_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniSardegna_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniSicilia_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniToscana_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniTrentinoAltoAdige_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniUmbria_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniValledAosta_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniVeneto.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniAltro_csv.zip"
         )
         
url_semestre = c("https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniAbruzzo_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniBasilicata_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniCalabria_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniCampania_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniEmiliaRomagna_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniFriuliVeneziaGiulia_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniLazio_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniLiguria_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniLombardia_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniMarche_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniMolise_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniPiemonte_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniPuglia_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniSardegna_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniSicilia_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniToscana_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniTrentinoAltoAdige_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniUmbria_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniValledAosta_csv.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniVeneto.zip",
                 "https://dati.inail.it/opendata/downloads/daticoncadenzaSemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniAltro_csv.zip"
)


download.file("https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniAbruzzo_csv.zip",
              "abruzzo.zip")
download.file("https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniBasilicata_csv.zip",
              "basilicata.zip")

download.file("https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniAbruzzo_csv.zip",
              "abruzzo_sem.zip")

download.file("https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniBasilicata_csv.zip",
              "basilicata_sem.zip")


my_files <- list.files(path = "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniAbruzzo_csv.zip")


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
  pivot_wider(names_from = Genere, values_from = decessi, values_fn=mean) 

abruzzo_morti_lavoro$M= abruzzo_morti_lavoro$M %>%replace_na(0)
abruzzo_morti_lavoro$F= abruzzo_morti_lavoro$F %>%replace_na(0)

abruzzo_morti_lavoro= abruzzo_morti_lavoro %>%
  mutate(Tot=M+F) %>%
  group_by(month = lubridate::floor_date(DataMorte, "month")) %>%
  summarize(decessi_M=sum(M), decessi_F=sum(F), decessi_lavoro = sum(Tot)) %>%
  rename(mese=month)

 


#API
res = GET("https://dati.inail.it/api/OpenData/DatiConCadenzaSemestraleInfortuni",
          query = list(Regione = "Abruzzo", AnnoAccadimento="2021",MeseAccadimento="7" ))