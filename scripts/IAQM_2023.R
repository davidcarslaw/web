library(openair)
library(tidyverse)
library(ggthemes)

meta <- importMeta(c("aurn", "saqn", "ni", "aqe", "local"))

meta_all <- importMeta(c("aurn", "saqn", "waqn",  "ni", "aqe", "local"), all = TRUE)


combine_meta <- function(year) {
  
  meta <- importMeta(c("aurn", "saqn", "waqn", "ni", "aqe", "local"), year = year)
  meta$year <- as.character(year)
  meta$source <- toupper(meta$source)
  meta$source <- factor(meta$source, levels = c("AURN", "SAQN", "WAQN", "NI", "AQE", "LOCAL"))
  return(meta)
  
}

all_meta <- map_df(2000:2023, combine_meta)



ggplot(all_meta, aes(year, fill = source)) +
  geom_bar(position = "stack", stat = "count") +
  scale_fill_tableau() +
  theme_minimal() +
  theme(legend.position = "top") +
  ylab("Number of sites")

