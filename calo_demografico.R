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


#Dati geografici
geodata = get_eurostat_geospatial(
  output_class = "sf",
  resolution = "20",
  nuts_level = 3,
  crs = 4326,
  year = 2021
)


#Scarico i dati
natalita_ue_nuts3=get_eurostat("demo_r_find3") 

#Istogramma fertilita
fertilita_ue_isto = fertilita_ue %>%
  filter(TIME_PERIOD=="2020")

#mappa eta' media madri e fertilita' province
fertilita_ue_nuts3=natalita_ue_nuts3 %>%
  group_by(geo) %>%
  filter(time == max(time), indic_de=="TOTFERRT") %>%
  rename(NUTS_ID=geo)

fertilita_ue_nuts3_mappa=left_join(geodata, fertilita_ue_nuts3,
                                         by="NUTS_ID")

fertilita_ue_nuts3_mappa = geojson_write(fertilita_ue_nuts3_mappa, file="mappa_fertilita.geojson")



#proiezioni fertilita
proiezioni_fertilita_paesi =get_eurostat("proj_19naasfr")
proiezioni_fertilita_province =get_eurostat("proj_19raasfr3")

write_sheet(fertilita_ue_isto, ss = Trasmissione_Sky, sheet = "Fertilita_Ue")

write_sheet(eta_media_madri_ue_nuts3_mappa, ss = Trasmissione_Sky, sheet = "Eta_media_Mappa")
