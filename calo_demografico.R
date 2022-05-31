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
  resolution = "60",
  nuts_level = 3,
  year = 2021
)
#Scarico i dati
fertilita_ue =read.csv("https://raw.githubusercontent.com/leopoldinho/Trasmissione-Sky/main/tps00199_page_linear_feritlita_09_20.csv")
eta_media_madri_ue_nuts3=get_eurostat("demo_r_find3")

#Istogramma fertilita
fertilita_ue_isto = fertilita_ue %>%
  filter(TIME_PERIOD=="2020")

#mappa eta media madri province
eta_media_madri_ue_nuts3=eta_media_madri_ue_nuts3 %>%
  filter(time == max(time)) %>%
  rename(NUTS_ID=geo)

eta_media_madri_ue_nuts3_mappa=left_join(eta_media_madri_ue_nuts3, geodata, by="NUTS_ID")

#proiezioni fertilita
proiezioni_fertilita_paesi =get_eurostat("proj_19naasfr")
proiezioni_fertilita_province =get_eurostat("proj_19raasfr3")


write_sheet(fertilita_ue_isto, ss = Trasmissione_Sky, sheet = "Fertilita_Ue")

write_sheet(eta_media_madri_ue_nuts3_mappa, ss = Trasmissione_Sky, sheet = "Eta_media_Mappa")
