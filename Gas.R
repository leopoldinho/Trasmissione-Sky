library(devtools) 
library(tidyverse)
library(googlesheets4)
library(readxl)

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
download.file("https://github.com/leopoldinho/Trasmissione-Sky/blob/main/bilancio_202201-IT%20(1).xls?raw=true", "Bilancio_202201_14-IT.xls", mode="wb")
download.file("https://github.com/leopoldinho/Trasmissione-Sky/blob/main/bilancio_202202-IT%20(2).xls?raw=true", "Bilancio_202202_14-IT.xls", mode="wb")
download.file("https://github.com/leopoldinho/Trasmissione-Sky/blob/main/bilancio_202203-IT_prov.xlsx?raw=true", "Bilancio_202203_14-IT_prov.xls", mode="wb")
download.file("https://github.com/leopoldinho/Trasmissione-Sky/blob/main/bilancio_202204-IT_prov.xlsx?raw=true", "Bilancio_202204_14-IT_prov.xls", mode="wb")

#Formatto i file dei bilanci del gas

#2021


Bilancio_gen_21 = read_excel("bilancio_202101-IT.xls",1,range = "A14:AE44") 
Bilancio_gen_21$GG=as.Date(Bilancio_gen_21$GG <- paste0('2021-01-', Bilancio_gen_21$GG))
Bilancio_feb_21 = read_excel("bilancio_202102-IT.xls",1,range = "A14:AE44") 
Bilancio_feb_21$GG=as.Date(Bilancio_feb_21$GG <- paste0('2021-02-', Bilancio_feb_21$GG))
Bilancio_mar_21 = read_excel("bilancio_202103-IT.xls",1,range = "A14:AE44") 
Bilancio_mar_21$GG=as.Date(Bilancio_mar_21$GG <- paste0('2021-03-', Bilancio_mar_21$GG))
Bilancio_apr_21 = read_excel("bilancio_202104-IT.xls",1,range = "A14:AE44") 
Bilancio_apr_21$GG=as.Date(Bilancio_apr_21$GG <- paste0('2021-04-', Bilancio_apr_21$GG))
Bilancio_mag_21 = read_excel("bilancio_202105-IT.xls",1,range = "A14:AE44") 
Bilancio_mag_21$GG=as.Date(Bilancio_mag_21$GG <- paste0('2021-05-', Bilancio_mag_21$GG))
Bilancio_giu_21 = read_excel("bilancio_202106-IT.xls",1,range = "A14:AE44") 
Bilancio_giu_21$GG=as.Date(Bilancio_giu_21$GG <- paste0('2021-06-', Bilancio_giu_21$GG))
Bilancio_lug_21 = read_excel("bilancio_202107-IT.xls",1,range = "A14:AE44") 
Bilancio_lug_21$GG=as.Date(Bilancio_lug_21$GG <- paste0('2021-07-', Bilancio_lug_21$GG))
Bilancio_ago_21 = read_excel("bilancio_202108-IT.xls",1,range = "A14:AE44") 
Bilancio_ago_21$GG=as.Date(Bilancio_ago_21$GG <- paste0('2021-08-', Bilancio_ago_21$GG))
Bilancio_set_21 = read_excel("bilancio_202109-IT.xls",1,range = "A14:AE44") 
Bilancio_set_21$GG=as.Date(Bilancio_set_21$GG <- paste0('2021-09-', Bilancio_set_21$GG))
Bilancio_ott_21 = read_excel("bilancio_202110-IT.xls",1,range = "A14:AE44") 
Bilancio_ott_21$GG=as.Date(Bilancio_ott_21$GG <- paste0('2021-10-', Bilancio_ott_21$GG))
Bilancio_nov_21 = read_excel("bilancio_202111-IT.xls",1,range = "A14:AE44") 
Bilancio_nov_21$GG=as.Date(Bilancio_nov_21$GG <- paste0('2021-11-', Bilancio_nov_21$GG))
Bilancio_dic_21 = read_excel("bilancio_202112-IT.xls",1,range = "A14:AE44") 
Bilancio_dic_21$GG=as.Date(Bilancio_dic_21$GG <- paste0('2021-12-', Bilancio_dic_21$GG))

#Unisco i file 2021
Bilancio_Gas_2021 = bind_rows(Bilancio_gen_21,Bilancio_feb_21,Bilancio_mar_21,
                              Bilancio_apr_21,Bilancio_mag_21,Bilancio_giu_21,
                              Bilancio_lug_21,Bilancio_ago_21,Bilancio_sett_21,
                              Bilancio_ott_21,Bilancio_dic_21,Bilancio_nov_21,
                              )


#2022
Bilancio_gennaio_22 = read_excel("Bilancio_202201_14-IT.xls",1,range = "A14:AE44") 
Bilancio_gennaio_22$GG=as.Date(Bilancio_gennaio_22$GG <- paste0('2022-01-', Bilancio_gennaio_22$GG))
  
Bilancio_febbraio_22 = read_xls("Bilancio_202202_14-IT.xls",1, range = "A14:AE44") %>%
  slice_head(n = 28)
Bilancio_febbraio_22$GG=as.Date(Bilancio_febbraio_22$GG <- paste0('2022-02-', Bilancio_febbraio_22$GG))

Bilancio_marzo_22_prov = read_xlsx("Bilancio_202203_14-IT_prov.xls",1, range = "A14:AE44")
Bilancio_marzo_22_prov$GG=as.Date(Bilancio_marzo_22_prov$GG <- paste0('2022-03-', Bilancio_marzo_22_prov$GG))

Bilancio_aprile_22_prov <- read_xlsx("Bilancio_202204_14-IT_prov.xls",1, range = "A14:AE44")
Bilancio_aprile_22_prov$GG=as.Date(Bilancio_aprile_22_prov$GG <- paste0('2022-04-', Bilancio_aprile_22_prov$GG))

#Unisco i file 2022
Bilancio_Gas_2022 = bind_rows(Bilancio_nov_21,Bilancio_dic_21,Bilancio_gennaio_22,Bilancio_febbraio_22,
                              Bilancio_marzo_22_prov,Bilancio_aprile_22_prov)