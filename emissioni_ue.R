
library(eurostat)
library(rlang)
library(tidyverse)

emissioni_ue = get_eurostat("env_air_gge") 

totali= c("TOTX4_MEMO","TOTX4_MEMONIA","TOTX4_MEMONIT","TOTXMEMO","TOTXMEMONIA","TOTXMEMONIT")

emissioni_ue_GHG = emissioni_ue %>%
  filter(airpol=="GHG") %>%
  filter(geo=="EU27_2020") %>%
  filter(TIME_PERIOD=="2021-01-01")%>%
  filter(!(src_crf %in% totali))%>%
  filter(unit=="THS_T")%>%
  àfilter(str_length(src_crf) > 4)


