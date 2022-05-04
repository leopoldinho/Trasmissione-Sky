library(devtools) 
library(tidyverse)
library(googlesheets4)
library(readxl)

download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/nomine/2022/Nomine_202201_14-IT.xls", "Nomine_202201_14-IT.xls")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/nomine/2022/Nomine_202202_14-IT.xls", "Nomine_202202_14-IT.xls")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/nomine/2022/Nomine_202203_14-IT.xls", "Nomine_202203_14-IT.xls")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/nomine/2022/Nomine_202204_14-IT.xls", "Nomine_202204_14-IT.xls")
download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/nomine/2022/Nomine_202205_14-IT.xls", "Nomine_202205_14-IT.xls")

bilancio_def_gen_22 <-download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2022/bilancio_202201-IT.xls", "bilancio_202201-IT.xls")
bilancio_def_feb_22 <- download.file("https://www.snam.it/exchange/quantita_gas_trasportato/andamento/bilancio_definitivo/2022/bilancio_202202-IT.xls", "bilancio_202202-IT.xls")

  
Nomine_gennaio_22 <- read_xls("Nomine_202201_14-IT.xls",1)
Nomine_febbraio_22 <- read_xls("C:/Users/Raffo/Documents/Nomine_202202_14-IT.xls",1, range = "A14:AE44")
Nomine_marzo_22 <- read_xls("C:/Users/Raffo/Downloads/Nomine_202203_14-IT.xls",1, range = "A14:AE44")
Nomine_aprile_22 <- read_xls("C:/Users/Raffo/Downloads/Nomine_202204_14-IT.xls",1, range = "A14:AE44")
Nomine_maggio_22 <- read_xls("C:/Users/Raffo/Downloads/Nomine_202205_14-IT.xls",1, range = "A14:AE44")