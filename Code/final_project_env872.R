# Setting working directory
getwd()
#setwd("./")

# Loading packages
#library(plyr)
library(tidyverse)

# Setting ggplot theme


# Loading tabular dataset
df <- read.csv("Data/Raw/Dams.csv")
colnames(df) <- tolower(colnames(df)) # lowecase column headers
dam <- df[,-c(1,2,4)]
dam <- dam %>%
  select(-c(other_name,own_name,  )
colnames(dam)
head(dam)
