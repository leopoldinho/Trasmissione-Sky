#Libraries
library(devtools) 
library(tidyverse)
library(googlesheets4)

#Scarico i dati italiani da OpenPolis
OP_Missioni <- read.csv2("https://openpnrr.openpolis.io/csv/missioni.csv", encoding = "UTF-8")
OP_Componenti <- read.csv2("https://openpnrr.openpolis.io/csv/componenti.csv", encoding = "UTF-8")
OP_Misure <- read.csv2("https://openpnrr.openpolis.io/csv/misure.csv", encoding = "UTF-8")
OP_scadenze <- read.csv2("https://openpnrr.openpolis.io/csv/scadenze.csv", encoding = "UTF-8")
OP_organizzazioni <- read.csv2("https://openpnrr.openpolis.io/csv/organizzazioni.csv", encoding = "UTF-8")




