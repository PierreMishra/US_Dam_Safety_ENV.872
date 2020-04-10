# Setting working directory
getwd()
#setwd("./")

# Loading packages
library("ggplot2")
library("plyr")
library("tidyverse")
library("sf")
library("ggmap")
library("here")

# setting ggplot theme
peaceful.theme <- theme_classic(base_size = 14) +
  theme(axis.text = element_text(color = "black"), 
        legend.position = "right")

# Loading tabular dataset
df <- read.csv("Data/Raw/NID2019_U.csv")
colnames(df) <- tolower(colnames(df)) # lowecase column headers

# Removing absolutely unnecessary columns
dam <- df %>%   
  select(-c("other_dam_name","dam_former_name", "section",
            "stateid", "owner_name", "dam_designer",
            "year_modified", "inspection_date",
            "state_reg_agency", "outlet_gates",
            "number_of_locks", "length_of_locks",
            "width_of_locks", "fed_funding",
            "fed_design", "fed_construction",
            "fed_regulatory", "fed_inspection",
            "fed_operation", "fed_owner", 
            "fed_other", "source_agency",
            "submit_date","url_address","cong_name",
            "party", "cong_dist", "otherstructureid",
            "numseparatestructures", "permittingauthority",
            "inspectionauthority", "jurisdictionaldam",
            "eap_last_rev_date")) 

# Correcting data types
dam$dam_name <- as.character(dam$dam_name)
dam$nidid <- as.character(dam$nidid)
dam$county <- as.character(dam$county)
dam$river <- as.character(dam$river)
dam$city <- as.character(dam$city)
dam$state <- as.character(dam$state)

# Removing dam records for which risk potential is undetermined or 
# not available
dam <- droplevels(dam[!(dam$hazard=="U" | dam$hazard=="N"),])

# Calculating the age of dams
dam$age <- 2019 - dam$year_completed

#-------------Exploratory data analysis
# Dam safety hazards
ggplot(dam) +
  geom_boxplot(aes(hazard))

# exploring variables that explain dam safety

# Map

# Importing gage data for NC


#information about each column http://files.hawaii.gov/dbedt/op/gis/data/nid_dams_data_dictionary.htm#Dam_type
#nformation on how can dams collapse https://www.fema.gov/dam-failure-information 
#git push -f origin master