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
library(countrycode)
library(viridis)
library(showtext)
library(XLConnect)


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


#Dati geografici province e regioni Ue
geodata = get_eurostat_geospatial(
  output_class = "sf",
  resolution = "20",
  nuts_level = 3,
  crs = 4326,
  year = 2021
)


geodata_nuts_2 = get_eurostat_geospatial(
  output_class = "sf",
  resolution = "20",
  nuts_level = 2,
  crs = 4326,
  year = 2021
)



#Scarico i dati sulla fertilità
natalita_ue_nuts3=get_eurostat("demo_r_find3") 

#Fertilita Paesi
fertilita_ue_isto = natalita_ue_nuts3 %>%
  filter(str_length(geo) == 2) %>%
  filter(time=="2021-01-01", indic_de=="TOTFERRT") %>% 
  mutate(Paese = countrycode(geo, "eurostat", "country.name.it"))%>%
  select(Paese, values, time)%>%
  arrange(desc(values))

write.csv2(fertilita_ue_isto, "fertilita_ue.csv")

#statistiche fertilità regione

eta_mediana_ue_reg=get_eurostat("demo_r_pjanind2") %>%
  filter(indic_de=="MEDAGEPOP")%>%
  filter(time>="2022-01-01")%>%
  label_eurostat(
  eta_mediana_ue_reg,fix_duplicated = TRUE, code = "geo"
)%>%
  arrange(desc(values))

write.csv2(eta_mediana_ue_reg, "eta_mediana_regioni_ue.csv")

#statistiche fertilità opaesi

eta_mediana_ue_Pa=get_eurostat("demo_pjanind") %>%
  filter(indic_de=="MEDAGEPOP")%>%
  filter(time>="2022-01-01")%>%
  label_eurostat(
    eta_mediana_ue_reg,fix_duplicated = TRUE, code = "geo"
  )%>%
  arrange(desc(values))

write_sheet(eta_mediana_ue_Pa, ss = Trasmissione_Sky, sheet = "Mediana_Ue")

#statistiche pop under 14 regione

prop_pop_under_14=get_eurostat("demo_r_pjanind2") %>%
  filter(indic_de=="PC_Y0_14")%>%
  filter(time>="2022-01-01")%>%
  label_eurostat(
    prop_pop_under_14,fix_duplicated = TRUE, code = "geo"
  )

write.csv2(prop_pop_under_14, "under_14_regioni_ue.csv")

#proiezione popolazione
proj_pop_ue = get_eurostat("proj_23np", time_format = "raw")%>%
  filter(age=="TOTAL" & sex=="T")

proiezioni_ue27 = proj_pop_ue %>%
  filter(geo=="EU27_2020")%>%
  select(projection, TIME_PERIOD, values)%>%
  pivot_wider(names_from = projection, values_from = values)



write.csv(proiezioni_ue27, "proiezioni_ue27.csv")

proiezioni_italia = proj_pop_ue %>%
  filter(geo=="IT")%>%
  select(projection, TIME_PERIOD, values)%>%
  pivot_wider(names_from = projection, values_from = values)

write.csv2(proj_pop_ue, "proiez_pop.csv")

proj_pop_ue_over_60 = get_eurostat("proj_23np", time_format = "raw")%>%
  filter(sex=="T" & geo=="IT") %>%
  filter(age !="TOTAL")

proj_pop_ue_over_60$age <- replace(proj_pop_ue_over_60$age, proj_pop_ue_over_60$age== "Y_GE100","Y100")
proj_pop_ue_over_60$age <- replace(proj_pop_ue_over_60$age, proj_pop_ue_over_60$age== "Y_LT1","Y0")

proj_pop_ue_over_60_a = proj_pop_ue_over_60 %>%
  separate(age, c("Y","eta"), sep="Y") %>%
  select(-Y) %>%
  mutate(eta=as.numeric(eta))%>%
  filter(eta>=60)%>%
  group_by(projection, time) %>%
  summarise(values_over=sum(values))

proj_pop_ue_over_60_b = proj_pop_ue_over_60 %>%
  separate(age, c("Y","eta"), sep="Y") %>%
  select(-Y) %>%
  mutate(eta=as.numeric(eta))%>%
  #filter(eta<60)%>%
  group_by(projection, time) %>%
  summarise(values_under=sum(values))%>%
  ungroup()%>%
  select(-projection, -time)

proj_pop_ue_over_60_tot = bind_cols(proj_pop_ue_over_60_a,proj_pop_ue_over_60_b)%>%
  mutate(perc=values_over/values_under*100)%>% 
  mutate_if(is.numeric, round, 1)%>%
  mutate(perc_under=100-perc)%>%
  rename("Over 60"=perc, "Under 60"=perc_under)
  

write.csv2(proj_pop_ue_over_60_tot, "proiez_pop_over_60.csv")

#sostituire Y_GE100   

#MAPPE

#font

font_add("SkyText", "Sky-Text-Regular.ttf")
showtext_auto()
font = "SkyText"

#età mediana

#territori di oltremare
oltremare=c("FRY1","FRY2","FRY3","FRY4","FRY5","ES70","PT20","PT30","NO0B")

#unisco file geografico e dati
eta_mediana_reg_mappa = left_join(geodata_nuts_2,
                                 eta_mediana_ue_reg,
                                 by = c("NUTS_ID"="geo_code")
                                 ) %>%
  filter(!NUTS_ID %in% oltremare)

st_write(eta_mediana_reg_mappa, "eta_mediana.geojson")

#realizzo la mappa
eta_mediana_reg_mappa_choro <- eta_mediana_reg_mappa  %>%
  ggplot(aes(fill = values))+ 
  geom_sf() + # Adding 'colour = NA' removes boundaries
  #around each comune (lasciare solo geom_Sf se voglio far vedere i confini dei comuni)
  
  #Opzioni di scale
  
  scale_fill_viridis("values",option="magma", direction= -1,limits=c(30,55)) + #puoi specificare limiti con , limits=c(30,50)
  
  #scale_fill_met_c(
   # "Hokusai2",
   #override.order = TRUE,
  #breaks = c(30, 35, 40, 45,50,55)) +
  
  #Apparato testuale
  
  labs(title = "Ue, le regioni più vecchie e quelle più giovani",
       subtitle = "Età mediana (anno 2022)",
       caption = "Fonte: Elaborazione Sky TG24 su dati Eurostat") +
  guides(fill=guide_legend(
    direction = "horizontal",
    keyheight = unit(2, units = "mm"),
    keywidth = unit(20, units = "mm"),
    title.position = 'top',
    title.hjust = 0.5,
    label.hjust = .5,
    nrow = 1,
    byrow = T,
    reverse = F,
    label.position = "bottom"
  ))+
  theme_minimal() +
  theme(panel.background = element_blank(),
        legend.background = element_blank(),
        legend.position = "top",
        panel.border = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_line(color = "white", size = 0),
        plot.title = element_text(size=25, color="grey30", hjust=0, vjust=0,family = font, face="bold"),
        plot.subtitle = element_text(size=16, color="grey30", hjust=0, vjust=0,family = font),
        plot.caption = element_text(size=10, color="grey30", hjust=0, vjust=0,family = font),
        axis.title.x = element_text(size=8, color="grey30", hjust=0, vjust=5,family = font),
        legend.text = element_text(size=8, color="grey30"),
        legend.title = element_blank(),
        strip.text = element_text(size=12),
        #plot.margin = unit(c(5, 5, 5, 5), "mm"),
        axis.title.y = element_blank(),
        axis.ticks = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank()
  )

eta_mediana_reg_mappa_choro

#salvo la mappa
map1 <- eta_mediana_reg_mappa_choro
ggsave(
  map1,
  filename = "eta_mediana_ue_viridis.jpg",
  width = 1500,
  height = 1500,
  units = "px",
  bg="white", dpi = 140
)


#Altre mappe
#mappa eta' media madri e fertilita' province
fertilita_ue_nuts3=natalita_ue_nuts3 %>%
  group_by(geo) %>%
  filter(time == max(time), indic_de=="TOTFERRT") %>%
  rename(NUTS_ID=geo)

fertilita_ue_nuts3_mappa=left_join(geodata, fertilita_ue_nuts3,
                                         by="NUTS_ID")

fertilita_IT_nuts3_mappa = fertilita_ue_nuts3_mappa %>%
  filter(CNTR_CODE=="IT") 

fertilita_ue_nuts3_mappa = geojson_write(fertilita_ue_nuts3_mappa, file="mappa_fertilita.geojson")

fertilita_IT_nuts3_mappa = geojson_write(fertilita_IT_nuts3_mappa, file="mappa_fertilita_IT.geojson")


#mappa eta' media madri e fertilita' regioni

fertilita_ue_nuts3=natalita_ue_nuts3 %>%
  group_by(geo) %>%
  filter(time == max(time), indic_de=="TOTFERRT") %>%
  rename(NUTS_ID=geo)

fertilita_ue_nuts2_mappa=left_join(geodata_nuts_2, fertilita_ue_nuts3,
                                   by="NUTS_ID")

fertilita_ue_nuts2_mappa = geojson_write(fertilita_ue_nuts2_mappa, file="mappa_fertilita.geojson")


#proiezioni fertilita
proiezioni_fertilita_paesi =get_eurostat("proj_19naasfr")%>%
  filter(age=="TOTAL")


proiezioni_fertilita_province =get_eurostat("proj_19raasfr3")

write_sheet(fertilita_ue_isto, ss = Trasmissione_Sky, sheet = "Fertilita_Ue")
write_sheet(fertilita_ue_andamento, ss = Trasmissione_Sky, sheet = "Fertilita_Ue_andamento")

#popolazione
pop_ue = get_eurostat("demo_pjangroup")

#proiezione popolazione
proj_pop_ue = get_eurostat("proj_19np", time_format = "raw")%>%
  filter(age=="TOTAL" & sex=="T" & geo=="IT") %>%
  pivot_wider(names_from = projection, values_from = values) %>%
  arrange(time)

write.csv2(proj_pop_ue, "proiez_pop.csv")

#mortalita eccesso

mortalita_ex_ue =get_eurostat("demo_mexrt") %>%
  pivot_wider(names_from = geo,
              values_from = values) %>%
  arrange(time)

write_sheet(mortalita_ex_ue, ss = Covid_Sky, sheet = "Ex mort Ue")


#Tutti i comuni

popolazione_Comuni_tot = read.csv("Tutti i comuni per singola età (IT1,22_289_DF_DCIS_POPRES1_24,1.0) (1).csv")

popolazione_Comuni = popolazione_Comuni_tot %>%
  filter(AGE == "TOTAL", SEX == "9", OBS_VALUE > 150000) %>%
  select(REF_AREA, TIME_PERIOD, OBS_VALUE) %>%
  filter(!startsWith(REF_AREA, "IT")) %>%
  filter(TIME_PERIOD != "2020", TIME_PERIOD != "2021") %>%
  pivot_wider(names_from = TIME_PERIOD, values_from = OBS_VALUE, names_prefix = "a") %>%
  mutate(Var_perc = (a2022 - a2019)/a2019*100) %>% 
  mutate_if(is.numeric, round, 2) %>%
  mutate(start=0)

write.csv(popolazione_Comuni, "pop_grandi_comuni.csv")
  

fertilita_ue_andamento = natalita_ue_nuts3 %>%
  filter(str_length(geo) == 2) %>%
  filter(indic_de=="TOTFERRT")%>%
  pivot_wider(names_from = geo, values_from = values)%>%
  arrange(time)


#Statistiche varie su fertilità per PAese
# the proportion of live births outside marriage
# total fertility rate
# the mean age of women at childbirth
# the mean age of women at the birth of first / second / third / fourth and higher child
# the median age of women at childbirth
# the percentage of first / second / third / fourth and higher live births Fertility rates by age (demo_frate)

stat_fertilita_ue=get_eurostat("demo_find") 

#Statistiche aborti
stat_aborti_ue=get_eurostat("demo_fabortind")

#Eta mediana popolazione 
#MEDAGEPOP: età mediana della popolazione
#FMEDAGEPOP: età mediana pop femminile
#MMEDAGEPOP: età mediana popolazione maschile

#Statostiche fertilità per  provincia


eta_mediana_ue_prov=get_eurostat("demo_r_pjanind3") %>%
  filter(indic_de=="MEDAGEPOP")%>%
  filter(time>="2022-01-01")

#### FRANCIA ####

#Scarico file fertilit da WB
download.file("https://api.worldbank.org/v2/en/indicator/SP.DYN.TFRT.IN?downloadformat=excel", "fertilita_WB.xls", mode="wb")
fertilita_wb = read_xls("fertilita_WB.xls",1,range = "A4:BM270")

#andamento popolzione

download.file("https://api.worldbank.org/v2/en/indicator/SP.POP.TOTL?downloadformat=excel", "popolazione_WB.xls", mode="wb")
pop_wb = read_xls("popolazione_WB.xls",1,range = "A4:BM270")
