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
         "https://dati.inail.it/opendata/downloads/daticoncadenzamensileinfortuni/zip/DatiConCadenzaMensileInfortuniVeneto_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniAbruzzo_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniBasilicata_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniCalabria_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniCampania_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniEmiliaRomagna_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniFriuliVeneziaGiulia_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniLazio_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniLiguria_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniLombardia_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniMarche_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniMolise_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniPiemonte_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniPuglia_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniSardegna_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniSicilia_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniToscana_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniTrentinoAltoAdige_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniUmbria_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniValledAosta_csv.zip",
         "https://dati.inail.it/opendata/downloads/daticoncadenzasemestraleinfortuni/zip/DatiConCadenzaSemestraleInfortuniVeneto_csv.zip"
)

for (url in url_mese) {
  download.file(url, destfile = basename(url))
} #scarico i file

my_files = list.files(pattern = "\\_csv.zip$") #infilo i file in una lista

my_files = lapply(my_files, unzip) #estraggo i file

my_data = lapply(my_files, read.csv2) # li leggo come CSV

my_data_selecton = lapply(my_data, function(x) x%>% select(DataAccadimento, 
                                                            DataMorte, Genere, 
                                                            Eta, LuogoNascita, 
                                                            SettoreAttivitaEconomica)) #selezion le variabili che mi interessano

my_data_selection_new = bind_rows(my_data_selecton) %>%
  filter(DataMorte !="") #unisco i dataset in un unico dataset e considero solo i morti

my_data_selection_new$DataAccadimento = 
  as.Date(my_data_selection_new$DataAccadimento,format ="%d/%m/%Y")
my_data_selection_new$DataMorte = 
  as.Date(my_data_selection_new$DataMorte,format ="%d/%m/%Y")

my_data_selection_new = my_data_selection_new %>%
  mutate(decessi=as.numeric(1))%>% 
  pivot_wider(names_from = Genere, values_from = decessi, values_fn=mean) 

my_data_selection_new$M= my_data_selection_new$M %>%replace_na(0)
my_data_selection_new$F= my_data_selection_new$F %>%replace_na(0)

my_data_selection_new= my_data_selection_new %>%
  mutate(Tot=M+F) %>%
  group_by(month = lubridate::floor_date(DataMorte, "month")) %>%
  summarize(decessi_M=sum(M), decessi_F=sum(F), decessi_lavoro = sum(Tot)) %>%
  rename(mese=month)

write_sheet(my_data_selection_new, ss = Trasmissione_Sky, sheet = "Morti_lavoro")

#controllare ultimi 6 mesi 2021: mancano dati


#API
res = GET("https://dati.inail.it/api/OpenData/DatiConCadenzaSemestraleInfortuni",
          query = list(Regione = "Abruzzo", AnnoAccadimento="2021",MeseAccadimento="7" ))

#non ho capito se usare o no questi
names(my_data) <- gsub("\\.csv$", "", my_files)
names(my_data) <- stringr::str_replace(my_files, pattern = ".csv", replacement = "")
