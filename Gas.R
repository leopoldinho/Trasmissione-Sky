library(devtools) 
library(tidyverse)
library(googlesheets4)
library(readxl)
library(lubridate)


#Credentials
google_auth_credentials <- Sys.getenv("GOOGLE_AUTH_CREDENTIALS")

#Send to Google Spreadsheet
if (google_auth_credentials != '') {
  gs4_auth(path = google_auth_credentials, scopes = "https://www.googleapis.com/auth/spreadsheets")
} else {
  gs4_auth(email = "raffaele.mastrolonardo@gmail.com")
}
Trasmissione_Sky <- Sys.getenv("TRASMISSIONE_SKY_OUTPUT")
if (Trasmissione_Sky == '') {
  Trasmissione_Sky <- "https://docs.google.com/spreadsheets/d/13QtJVyJDr8s-sWl0P44LDH394X_2z9ycg161Ptk7ias/edit#gid=0"
}


#Scarico i file dei bilanci del Gas

download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2021/bilancio_202101-IT.xls", "bilancio_202101-IT.xls", mode="wb")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2021/bilancio_202102-IT.xls", "bilancio_202102-IT.xls", mode="wb")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2021/bilancio_202103-IT.xls", "bilancio_202103-IT.xls", mode="wb")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2021/bilancio_202104-IT.xls", "bilancio_202104-IT.xls", mode="wb")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2021/bilancio_202105-IT.xls", "bilancio_202105-IT.xls", mode="wb")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2021/bilancio_202106-IT.xls", "bilancio_202106-IT.xls", mode="wb")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2021/bilancio_202107-IT.xls", "bilancio_202107-IT.xls", mode="wb")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2021/bilancio_202108-IT.xls", "bilancio_202108-IT.xls", mode="wb")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2021/bilancio_202109-IT.xls", "bilancio_202109-IT.xls", mode="wb")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2021/bilancio_202110-IT.xls", "bilancio_202110-IT.xls", mode="wb")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2021/bilancio_202111-IT.xls", "bilancio_202111-IT.xls", mode="wb")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2021/bilancio_202112-IT.xls", "bilancio_202112-IT.xls", mode="wb")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2022/bilancio_202201-IT.xls", "Bilancio_202201-IT.xls", mode="wb")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2022/bilancio_202202-IT.xls", "Bilancio_202202-IT.xls", mode="wb")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2022/bilancio_202203-IT.xls", "bilancio_202203-IT.xls", mode="wb")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2022/bilancio_202204-IT.xls", "bilancio_202204-IT.xls", mode="wb")
#provvisori
download.file("https://github.com/leopoldinho/Trasmissione-Sky/blob/main/bilancio_202205-IT.xlsx?raw=true", "Bilancio_202205_14-IT_prov.xlsx", mode="wb")
download.file("https://github.com/leopoldinho/Trasmissione-Sky/blob/main/bilancio_202206-IT.xlsx?raw=true", "Bilancio_202206_14-IT_prov.xlsx", mode="wb")



#NB:  https://jarvis.snam.it/public-data?lang=it


#Formatto i file dei bilanci del gas in  milioni di Sm3 da PCS 10,57275 kWh/Sm3)

#2021


Bilancio_gen_21 = read_xls("bilancio_202101-IT.xls",3,range = "A14:AE45") 
Bilancio_gen_21$GG=as.Date(Bilancio_gen_21$GG <- paste0('2021-01-', Bilancio_gen_21$GG))
Bilancio_feb_21 = read_excel("bilancio_202102-IT.xls",3,range = "A14:AE44")  %>%
  slice_head(n = 28)
Bilancio_feb_21$GG=as.Date(Bilancio_feb_21$GG <- paste0('2021-02-', Bilancio_feb_21$GG))
Bilancio_mar_21 = read_excel("bilancio_202103-IT.xls",3,range = "A14:AE45") 
Bilancio_mar_21$GG=as.Date(Bilancio_mar_21$GG <- paste0('2021-03-', Bilancio_mar_21$GG))
Bilancio_apr_21 = read_excel("bilancio_202104-IT.xls",3,range = "A14:AE44") 
Bilancio_apr_21$GG=as.Date(Bilancio_apr_21$GG <- paste0('2021-04-', Bilancio_apr_21$GG))
Bilancio_mag_21 = read_excel("bilancio_202105-IT.xls",3,range = "A14:AE45") 
Bilancio_mag_21$GG=as.Date(Bilancio_mag_21$GG <- paste0('2021-05-', Bilancio_mag_21$GG))
Bilancio_giu_21 = read_excel("bilancio_202106-IT.xls",3,range = "A14:AE44") 
Bilancio_giu_21$GG=as.Date(Bilancio_giu_21$GG <- paste0('2021-06-', Bilancio_giu_21$GG))
Bilancio_lug_21 = read_excel("bilancio_202107-IT.xls",3,range = "A14:AE45") 
Bilancio_lug_21$GG=as.Date(Bilancio_lug_21$GG <- paste0('2021-07-', Bilancio_lug_21$GG))
Bilancio_ago_21 = read_excel("bilancio_202108-IT.xls",3,range = "A14:AE45") 
Bilancio_ago_21$GG=as.Date(Bilancio_ago_21$GG <- paste0('2021-08-', Bilancio_ago_21$GG))
Bilancio_set_21 = read_excel("bilancio_202109-IT.xls",3,range = "A14:AE44") 
Bilancio_set_21$GG=as.Date(Bilancio_set_21$GG <- paste0('2021-09-', Bilancio_set_21$GG))
Bilancio_ott_21 = read_excel("bilancio_202110-IT.xls",3,range = "A14:AE45") 
Bilancio_ott_21$GG=as.Date(Bilancio_ott_21$GG <- paste0('2021-10-', Bilancio_ott_21$GG))
Bilancio_nov_21 = read_excel("bilancio_202111-IT.xls",3,range = "A14:AE44") 
Bilancio_nov_21$GG=as.Date(Bilancio_nov_21$GG <- paste0('2021-11-', Bilancio_nov_21$GG))
Bilancio_dic_21 = read_excel("bilancio_202112-IT.xls",3,range = "A14:AE45") 
Bilancio_dic_21$GG=as.Date(Bilancio_dic_21$GG <- paste0('2021-12-', Bilancio_dic_21$GG))

#Unisco i file 2021
Bilancio_Gas_2021 = bind_rows(Bilancio_gen_21,Bilancio_feb_21,Bilancio_mar_21,
                              Bilancio_apr_21,Bilancio_mag_21,Bilancio_giu_21,
                              Bilancio_lug_21,Bilancio_ago_21,Bilancio_set_21,
                              Bilancio_ott_21,Bilancio_nov_21,Bilancio_dic_21
                              )%>% 
  select(GG, "2021"=Import., "Entrata Tarvisio 21"="Entrata Tarvisio",
         "Entrata Gela 21"="Entrata Gela","Entrata Gorizia 21"="Entrata Gorizia",
         "Entrata Mazara 21"="Entrata Mazara","Entrata P.Gries 21"="Entrata P.Gries",
         "Entrata Melendugno 21"="Entrata Melendugno","GNL Cavarzere 21"="GNL Cavarzere",
         "GNL Livorno 21"="GNL Livorno","GNL Panigaglia 21"="GNL Panigaglia",
         "Prod Nazionale 21"="Produzione Nazionale","Sistemi di stoccaggio 21"="Sistemi di stoccaggio*")

#Elaboro il conteggio per settimana 2021
Bilancio_Gas_2021_Set =Bilancio_Gas_2021 %>% 
  mutate(Settimana = cut.Date(GG, breaks = "1 week", labels = FALSE)) %>% 
  arrange(GG) %>% select(-GG) %>% mutate_if(is.numeric, round, 1)

Bilancio_Gas_2021_Set = Bilancio_Gas_2021_Set %>%
  group_by(Settimana) %>% summarise_all(sum)


#2022
Bilancio_gennaio_22 = read_excel("Bilancio_202201_14-IT.xls",3,range = "A14:AE45") 
Bilancio_gennaio_22$GG=as.Date(Bilancio_gennaio_22$GG <- paste0('2022-01-', Bilancio_gennaio_22$GG))
  
Bilancio_febbraio_22 = read_xls("Bilancio_202202_14-IT.xls",3, range = "A14:AE44") %>%
  slice_head(n = 28)
Bilancio_febbraio_22$GG=as.Date(Bilancio_febbraio_22$GG <- paste0('2022-02-', Bilancio_febbraio_22$GG))

Bilancio_marzo_22 = read_xls("bilancio_202203-IT.xls",3, range = "A14:AE45")
Bilancio_marzo_22$GG=as.Date(Bilancio_marzo_22$GG <- paste0('2022-03-', Bilancio_marzo_22$GG))

Bilancio_aprile_22 <- read_xls("Bilancio_202204-IT.xls",3, range = "A14:AE44")
Bilancio_aprile_22$GG=as.Date(Bilancio_aprile_22$GG <- paste0('2022-04-', Bilancio_aprile_22$GG))

Bilancio_maggio_22_prov <- read_xlsx("Bilancio_202205_14-IT_prov.xlsx",3, range = "A14:AE45")
Bilancio_maggio_22_prov$GG=as.Date(Bilancio_maggio_22_prov$GG <- paste0('2022-05-', Bilancio_maggio_22_prov$GG))

Bilancio_giugno_22_prov <- read_xlsx("Bilancio_202206_14-IT_prov.xlsx",3, range = "A14:AE44")
Bilancio_giugno_22_prov$GG=as.Date(Bilancio_giugno_22_prov$GG <- paste0('2022-06-', Bilancio_giugno_22_prov$GG))



#Unisco i file 2022
Bilancio_Gas_2022 = bind_rows(Bilancio_gennaio_22,Bilancio_febbraio_22,
                              Bilancio_marzo_22,Bilancio_aprile_22,Bilancio_maggio_22_prov,
                              Bilancio_giugno_22_prov)%>% 
  select(GG, "2022"=Import., "Entrata Tarvisio 22"="Entrata Tarvisio",
         "Entrata Gela 22"="Entrata Gela","Entrata Gorizia 22"="Entrata Gorizia",
         "Entrata Mazara 22"="Entrata Mazara","Entrata P.Gries 22"="Entrata P.Gries",
         "Entrata Melendugno 22"="Entrata Melendugno","GNL Cavarzere 22"="GNL Cavarzere",
         "GNL Livorno 22"="GNL Livorno","GNL Panigaglia 22"="GNL Panigaglia",
         "Prod Nazionale 22"="Produzione Nazionale", "Sistemi di stoccaggio 22"="Sistemi di stoccaggio*")

#Elaboro il conteggio per settimana 2022
Bilancio_Gas_2022_Set =Bilancio_Gas_2022 %>% 
  mutate(Settimana = cut.Date(GG, breaks = "1 week", labels = FALSE)) %>% 
  arrange(GG) %>% select(-GG) %>% mutate_if(is.numeric, round, 1)

Bilancio_Gas_2022_Set = Bilancio_Gas_2022_Set %>%
  group_by(Settimana) %>% summarise_all(sum)

write.csv2(Bilancio_Gas_2022_Set, "Gas_2022.csv")

#Costruisco i dataset per le viz

Bilancio_Gas_21_22_Set = left_join(Bilancio_Gas_2021_Set,
                                   Bilancio_Gas_2022_Set,by="Settimana")


write_sheet(Bilancio_Gas_21_22_Set, ss = Trasmissione_Sky, sheet = "Impostazioni gas")  



#Dati energia elettrica
#Fonte: https://www.terna.it/it/sistema-elettrico/transparency-report/download-center

#Formatto i dati 2021
Prod_Elet_2021 = read_xlsx("data_energia_elettrica_21.xlsx",1) %>% 
  slice(1:(n()-2)) %>%
  mutate(Giorno=yday(Date))

Prod_Elet_2021$Date = as.Date (Prod_Elet_2021$Date)

Prod_Elet_2021 = Prod_Elet_2021 %>% 
  pivot_wider(names_from="Primary Source", 
              values_from="Actual Generation [GWh]", values_fn = sum) %>% 
  mutate(Settimana = cut.Date(Date, breaks = "1 week", labels = FALSE)) %>% 
  arrange(Date) %>% select(-Date) %>% mutate_if(is.numeric, round, 1)%>%
  group_by(Settimana) %>% summarise_all(sum) %>%
  slice_head(n = 53) %>%
  rename("Geotermico_21"=Geothermal, "Idroelettrico_21"=Hydro,
         "Fotovoltaico_21"=Photovoltaic, "Auto-consumo_21"="Self-consumption",
         "Termico_21"=Thermal,"Eolico_21"=Wind) %>%
  select(-Giorno)
  

#Formatto i dati 2022
Prod_Elet_2022 = read_xlsx("data_energia_elettrica_22.xlsx",1) %>% 
  slice(1:(n()-2)) %>%
  mutate(Giorno=yday(Date))

Prod_Elet_2022$Date = as.Date (Prod_Elet_2022$Date)

Prod_Elet_2022 = Prod_Elet_2022 %>% 
  pivot_wider(names_from="Primary Source", 
              values_from="Actual Generation [GWh]", values_fn = sum) %>% 
  mutate(Settimana = cut.Date(Date, breaks = "1 week", labels = FALSE)) %>% 
  arrange(Date) %>% select(-Date) %>% mutate_if(is.numeric, round, 1)%>%
  group_by(Settimana) %>% summarise_all(sum) %>%
  slice_head(n = 53) %>%
  rename("Geotermico_22"=Geothermal, "Idroelettrico_22"=Hydro,
         "Fotovoltaico_22"=Photovoltaic, "Auto-consumo_22"="Self-consumption",
         "Termico_22"=Thermal,"Eolico_22"=Wind) %>%
  select(-Giorno)

#Costruisco i dataset per le viz

Produzione_Elettrica_21_22 = left_join(Prod_Elet_2021,
                                   Prod_Elet_2022,by="Settimana")

Produzione_Elettrica_21_22 = Produzione_Elettrica_21_22%>%
  mutate(Diff_Termo_Perc=(Termico_22-Termico_21)/Termico_21*100,
         Diff_Termo=(Termico_22-Termico_21),
         Diff_Idro_Perc=(Idroelettrico_22-Idroelettrico_21)/Idroelettrico_21*100,
         Diff_Idro=(Idroelettrico_22-Idroelettrico_21))%>% 
  rename("Geotermico 21"="Geotermico_21", "Idroelettrico 21"="Idroelettrico_21",
         "Fotovoltaico 21"="Fotovoltaico_21", "Auto-consumo 21"="Auto-consumo_21",
         "Termoelettrico 21"="Termico_21","Eolico 21"="Eolico_21",
         "Geotermico 22"="Geotermico_22", "Idroelettrico 22"="Idroelettrico_22",
         "Fotovoltaico 22"="Fotovoltaico_22", "Auto-consumo 22"="Auto-consumo_22",
         "Termoelettrico 22"="Termico_22","Eolico 22"="Eolico_22",
         "Termo Diff %"=Diff_Termo_Perc,"Diff Termo"=Diff_Termo,
         "Idro Diff %"=Diff_Idro_Perc, "Diff Idro"=Diff_Idro) %>% 
  mutate_if(is.numeric, round, 1)

write_sheet(Produzione_Elettrica_21_22, ss = Trasmissione_Sky, sheet = "Produzione elettrica")  