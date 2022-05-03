library(eurostat)
tmp <- search_eurostat("mortality")
head(tmp)

fertility_ue = search_eurostat("fertility")