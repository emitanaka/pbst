## code to prepare `DATASET` dataset goes here
library(readxl)
library(tidyverse)

# Data supplied by Manigben Kulai Amadu

scores_df <- read_excel("~/Downloads/OP_Stability.xlsx", range = "A1:E316")
# is this rotated loadings??
loadings_df <- read_excel("~/Downloads/OP_Stability.xlsx", range = "P1:W9")

loadings <- loadings_df %>%
  select(starts_with("Load")) %>%
  as.matrix()
rownames(loading) <- loadings_df$Environment

scores <- scores_df %>%
  select(starts_with("Score")) %>%
  as.matrix()
rownames(scores) <- scores_df$Variety


usethis::use_data(loadings, overwrite = TRUE)
usethis::use_data(scores, overwrite = TRUE)
