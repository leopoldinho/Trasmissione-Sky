library(eurostat)
tmp <- search_eurostat("mortality")
head(tmp)

fertility_ue_index = search_eurostat("fertility")
fertility_ue=get_eurostat("demo_r_find3")