library(devtools) 
library(tidyverse)
library(googlesheets4)
library(readxl)
library(eurostat)

#cerco dati su Eurostat
fertility_ue_index = search_eurostat("fertility")

#Scarico i dati
fertilita_ue =read.csv("https://raw.githubusercontent.com/leopoldinho/Trasmissione-Sky/main/tps00199_page_linear_feritlita_09_20.csv")
proiezioni_fertilita_paesi =get_eurostat("proj_19naasfr")
proiezioni_fertilita_province =get_eurostat("proj_19raasfr3")
