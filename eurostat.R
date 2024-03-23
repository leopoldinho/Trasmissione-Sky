install.packages("eurostat")
library(eurostat)
tmp <- search_eurostat("mortality")
head(tmp)

install.packages("rlang")

fertility_ue_index = search_eurostat("fertility")
fertility_ue=get_eurostat("demo_r_find3")


emissioni_ue = get_eurostat("env_air_gge")
