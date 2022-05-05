library(devtools) 
library(tidyverse)
library(googlesheets4)
library(readxl)

#Scarico i file dei bilanci del Gas
download.file("https://github.com/leopoldinho/Trasmissione-Sky/blob/main/bilancio_202201-IT%20(1).xls?raw=true", "Bilancio_202201_14-IT.xls", mode="wb")
download.file("https://github.com/leopoldinho/Trasmissione-Sky/blob/main/bilancio_202202-IT%20(2).xls?raw=true", "Bilancio_202202_14-IT.xls", mode="wb")
download.file("https://github.com/leopoldinho/Trasmissione-Sky/blob/main/bilancio_202203-IT_prov.xlsx?raw=true", "Bilancio_202203_14-IT_prov.xls", mode="wb")
download.file("https://github.com/leopoldinho/Trasmissione-Sky/blob/main/bilancio_202204-IT_prov.xlsx?raw=true", "Bilancio_202204_14-IT_prov.xls", mode="wb")

#Formatto i file dei bilanci del gas
Bilancio_gennaio_22 = read_excel("Bilancio_202201_14-IT.xls",1,range = "A14:AE44") 
Bilancio_gennaio_22$GG=as.Date(Bilancio_gennaio_22$GG <- paste0('2022-01-', Bilancio_gennaio_22$GG))
  
Bilancio_febbraio_22 = read_xls("Bilancio_202202_14-IT.xls",1, range = "A14:AE44") %>%
  slice_head(n = 28)
Bilancio_febbraio_22$GG=as.Date(Bilancio_febbraio_22$GG <- paste0('2022-02-', Bilancio_febbraio_22$GG))

Bilancio_marzo_22_prov = read_xlsx("Bilancio_202203_14-IT_prov.xls",1, range = "A14:AE44")
Bilancio_marzo_22_prov$GG=as.Date(Bilancio_marzo_22_prov$GG <- paste0('2022-03-', Bilancio_marzo_22_prov$GG))

Bilancio_aprile_22_prov <- read_xlsx("Bilancio_202204_14-IT_prov.xls",1, range = "A14:AE44")
Bilancio_aprile_22_prov$GG=as.Date(Bilancio_aprile_22_prov$GG <- paste0('2022-04-', Bilancio_aprile_22_prov$GG))

#Unisco i file
Bilancio_Gas_2022 = bind_rows(Bilancio_gennaio_22,Bilancio_febbraio_22,
                              Bilancio_marzo_22_prov,Bilancio_aprile_22_prov)