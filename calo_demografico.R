library(devtools) 
library(tidyverse)
library(googlesheets4)
library(readxl)
library(eurostat)
library(httr)
library(jsonlite)
library(R.utils)

temp <- tempfile()
download.file("https://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?file=data/tgs00100.tsv.gz",temp)
data <- read_tsv(gunzip(temp, "tgs00100.tsv"))
unlink(temp)

prova = gunzip("https://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?file=data/tgs00100.tsv.gz")

prova_1 = read_tsv(prova)

#cerco dati su Eurostat
fertility_ue_index = search_eurostat("fertility")

#Scarico i dati
fertilita_ue =read.csv("https://raw.githubusercontent.com/leopoldinho/Trasmissione-Sky/main/tps00199_page_linear_feritlita_09_20.csv")
proiezioni_fertilita_paesi =get_eurostat("proj_19naasfr")
proiezioni_fertilita_province =get_eurostat("proj_19raasfr3")

gzfi
# API INAIL PROVE
prova= GET("https://dati.inail.it/api/OpenData/DatiConCadenzaSemestraleInfortuni")
rawToChar(prova$content)