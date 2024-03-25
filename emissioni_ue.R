
library(eurostat)
library(rlang)
library(tidyverse)

#recupero i dati
emissioni_ue = get_eurostat("env_air_gge") 

#elimino i totali
totali= c("TOTX4_MEMO","TOTX4_MEMONIA","TOTX4_MEMONIT","TOTXMEMO","TOTXMEMONIA","TOTXMEMONIT")

#emissioni totali

emissioni_ue_tot = emissioni_ue %>%
  filter(src_crf %in% totali)%>%
  filter(airpol=="GHG") %>%
  filter(geo=="EU27_2020") %>%
  filter(TIME_PERIOD=="2021-01-01")%>%
  filter(unit=="THS_T")

#emissioni gas serra per macro settori
emissioni_ue_GHG = emissioni_ue %>%
  filter(airpol=="GHG") %>%
  filter(geo=="EU27_2020") %>%
  filter(TIME_PERIOD=="2021-01-01")%>%
  #filter(!(src_crf %in% totali))%>%
  filter(unit=="THS_T")%>%
  filter(str_length(src_crf) == 4)%>%
  replace(is.na(.), 0)

#estraggo le emissioni indirette
indirette = emissioni_ue %>%
  filter(airpol=="GHG") %>%
  filter(geo=="EU27_2020") %>%
  filter(TIME_PERIOD=="2021-01-01")%>%
  filter(unit=="THS_T")%>%
  filter(src_crf=="CRF_INDCO2")%>%
  select(values)

#somma emissioni
emissioni_ue_GHG_sum = emissioni_ue_GHG %>% group_by(freq )%>% 
  summarise(tot=sum(values))%>% select(tot)
  




#Legenda macro settori
#[CRF1] Energy
#[CRF2] Industrial processes and product use
#[CRF3] Agriculture
#[CRF4] Land use, land use change, and forestry (LULUCF)
#[CRF5] Waste management
#[CRF6] Other sectors

#emissioni settore trasporti

emissioni_ue_GHG_trasporti = emissioni_ue %>%
  filter(airpol=="GHG") %>%
  filter(geo=="EU27_2020") %>%
  filter(TIME_PERIOD=="2021-01-01")%>%
  filter(!(src_crf %in% totali))%>%
  filter(unit=="THS_T")%>%
  filter(str_detect(src_crf, "^CRF1A3"))
  
#Legenda trasporti
#[CRF1A3] Fuel combustion in transport
#[CRF1A3A] Fuel combustion in domestic aviation
#[CRF1A3B] Fuel combustion in road transport
#[CRF1A3B1] Fuel combustion in cars
#[CRF1A3B2] Fuel combustion in light duty trucks
#[CRF1A3B3] Fuel combustion in heavy duty trucks and buses
#[CRF1A3B4] Fuel combustion in motorcycles
#[CRF1A3B5] Fuel combustion in other road transportation
#[CRF1A3C] Fuel combustion in railways
#[CRF1A3D] Fuel combustion in domestic navigation
#[CRF1A3E] Fuel combustion in other transport