#Libraries
library(devtools) 
library(tidyverse)
library(googlesheets4)
library(readxl)
library(eurostat)
library(httr)
library(jsonlite)
library(R.utils)
library(sf)
library(sp)
library(geojsonR)
library(geojsonio)




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


#Dati geografici province e regioni Ue
geodata = get_eurostat_geospatial(
  output_class = "sf",
  resolution = "20",
  nuts_level = 3,
  crs = 4326,
  year = 2021
)


geodata_nuts_2 = get_eurostat_geospatial(
  output_class = "sf",
  resolution = "20",
  nuts_level = 2,
  crs = 4326,
  year = 2021
)




#Scarico i dati sulla fertilità
natalita_ue_nuts3=get_eurostat("demo_r_find3") 

#Fertilita Paesi
fertilita_ue_isto = natalita_ue_nuts3 %>%
  filter(str_length(geo) == 2) %>%
  filter(time=="2020-01-01", indic_de=="TOTFERRT")

fertilita_ue_andamento = natalita_ue_nuts3 %>%
  filter(str_length(geo) == 2) %>%
  filter(indic_de=="TOTFERRT")%>%
  pivot_wider(names_from = geo, values_from = values)%>%
  arrange(time)


#Statistiche varie su fertilità per PAese
# the proportion of live births outside marriage
# total fertility rate
# the mean age of women at childbirth
# the mean age of women at the birth of first / second / third / fourth and higher child
# the median age of women at childbirth
# the percentage of first / second / third / fourth and higher live births Fertility rates by age (demo_frate)

stat_fertilita_ue=get_eurostat("demo_find") 

#Statistiche aborti
stat_aborti_ue=get_eurostat("demo_fabortind")

#Eta mediana popolazione 
#MEDAGEPOP: età mediana della popolazione
#FMEDAGEPOP: età mediana pop femminile
#MMEDAGEPOP: età mediana popolazione maschile

eta_mediana_ue=get_eurostat("demo_pjanind")

#mappa eta' media madri e fertilita' province
fertilita_ue_nuts3=natalita_ue_nuts3 %>%
  group_by(geo) %>%
  filter(time == max(time), indic_de=="TOTFERRT") %>%
  rename(NUTS_ID=geo)

fertilita_ue_nuts3_mappa=left_join(geodata, fertilita_ue_nuts3,
                                         by="NUTS_ID")

fertilita_IT_nuts3_mappa = fertilita_ue_nuts3_mappa %>%
  filter(CNTR_CODE=="IT")

fertilita_ue_nuts3_mappa = geojson_write(fertilita_ue_nuts3_mappa, file="mappa_fertilita.geojson")

fertilita_IT_nuts3_mappa = geojson_write(fertilita_IT_nuts3_mappa, file="mappa_fertilita_IT.geojson")


#mappa eta' media madri e fertilita' regioni

fertilita_ue_nuts3=natalita_ue_nuts3 %>%
  group_by(geo) %>%
  filter(time == max(time), indic_de=="TOTFERRT") %>%
  rename(NUTS_ID=geo)

fertilita_ue_nuts2_mappa=left_join(geodata_nuts_2, fertilita_ue_nuts3,
                                   by="NUTS_ID")

fertilita_ue_nuts2_mappa = geojson_write(fertilita_ue_nuts2_mappa, file="mappa_fertilita.geojson")


#proiezioni fertilita
proiezioni_fertilita_paesi =get_eurostat("proj_19naasfr")
proiezioni_fertilita_province =get_eurostat("proj_19raasfr3")

write_sheet(fertilita_ue_isto, ss = Trasmissione_Sky, sheet = "Fertilita_Ue")
write_sheet(fertilita_ue_andamento, ss = Trasmissione_Sky, sheet = "Fertilita_Ue_andamento")



