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
<<<<<<< HEAD
library("viridis")
library("RColorBrewer")
library("colormap")
library('mapdata')
library("modifiedmk")
library("forecast")
library("trend")
library("Kendall")
library("tseries")
library("scico")
library("corrplot")
library("GGally")

=======
>>>>>>> 649baf41350e87761aafd6dbf815263a201968ff

# setting ggplot theme
peaceful.theme <- theme_classic(base_size = 14) +
  theme(axis.text = element_text(color = "black"), 
        legend.position = "right")

# Loading tabular dataset
df <- read.csv("Data/Raw/NID2019_U.csv")
colnames(df) <- tolower(colnames(df)) # lowecase column headers

<<<<<<< HEAD
# Removing irrelevant columns
=======
# Removing absolutely unnecessary columns
>>>>>>> 649baf41350e87761aafd6dbf815263a201968ff
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

<<<<<<< HEAD
# Cleaning certian columns

#----------------------------------------------------Exploratory data analysis

# Checking NAs
colSums(is.na(dam))

# dam safety hazards
ggplot(dam, aes(x=hazard)) +
  geom_bar() + peaceful.theme

  # hazard vs owner type ####PROBABLY NOT
ggplot(dam) +
  geom_bar(aes(x=hazard, fill = owner_type), position = "dodge") +
  peaceful.theme

# hazard vs private dam
ggplot(dam) +
  geom_bar(aes(x=hazard, fill = private_dam), position = "dodge") +
  peaceful.theme 
#### there are different levels with same name 'N', empty value

# hazard vs dam height #### YES
ggplot(data = dam) +
  geom_point(aes(x = hazard, y = dam_height))

#### hazard vs primary purpose
#### only keep the first alphabet of the column "purpose"

# hazard vs distance #### YES
ggplot(dam) +
  geom_boxplot(aes(x=hazard, y = log(distance)))

# hazard vs dam length ### YES
ggplot(dam) +
  geom_boxplot(aes(x=hazard, y = log(dam_length)))

# hazard vs structural height #### YES
ggplot(dam) +
  geom_boxplot(aes(x=hazard, y = log(structural_height)))

# hazard vs hydraulic height #### YES
ggplot(dam) +
  geom_boxplot(aes(x=hazard, y = log(hydraulic_height)))
 
# hazard vs surface area #### YES
ggplot(dam) +
  geom_boxplot(aes(x=hazard, y = log(surface_area)))

# hazard vs drainage area #### YES
ggplot(dam) +
  geom_boxplot(aes(x=hazard, y = log(drainage_area)))

# hazard vs eap #### DATA EXPLORATORY ANALYSIS
ggplot(dam) +
  geom_bar(aes(x=hazard, fill = eap), position = "dodge")

# hazard vs inspection frequency #### YES
ggplot(dam) +
  geom_density(aes(x=inspection_frequency, group = hazard, fill = hazard),
               alpha = 0.5) + peaceful.theme

# hazard vs state regulated dam #### NOPE
ggplot(dam) +
  geom_bar(aes(x=hazard, fill = state_reg_dam), position = "dodge")

# hazard vs spillway type
ggplot(dam) +
  geom_bar(aes(x=hazard, fill = spillway_type), position = "dodge") +
  peaceful.theme
# spillway type: one value is blank

# hazard vs spillway width #### YES
ggplot(dam) +
  geom_boxplot(aes(x=hazard, y = log(spillway_width))) +
  peaceful.theme

# hazard vs volume #### HELL YEAH
ggplot(dam) +
  geom_boxplot(aes(x=hazard, y = log(volume)) +
  peaceful.theme

# hazard vs state  #### NO
ggplot(dam) +
  geom_bar(aes(x=hazard, fill = state), position = "dodge") +
  peaceful.theme

# hazard vs enforcementauthority
ggplot(dam) +
  geom_bar(aes(x=hazard, fill = enforcementauthority), position = "dodge") +
  peaceful.theme

# hazard vs age
ggplot(dam) +
  geom_boxplot(aes(x=hazard, y = age)) +
  peaceful.theme

# distribution of dam characteristics
dam_characteristics <- dam %>%
  select(volume, spillway_width, drainage_area, hydraulic_height,
         surface_area, structural_height, dam_height, dam_length)

for (i in ncols(dam_characteristics)) {
  ggplot(dam)
}

ggplot(dam) +
  geom_hist (aes(x=volume))

#-------------------------------------Cleaning some columns



#-------------------------------------Multinomial (Ordinal) Logistic Model
# age, enforcementauthority, volume, spillway width, inspection frequency,
# distance, drainage area, hydraulic height, surface area, structural height,
# dam height, dam length

# do correlation matrix
# dam_characteristics <- dam %>%
#   select(volume, spillway_width, drainage_area, hydraulic_height,
#          surface_area, structural_height, dam_height, dam_length)
# volume is not that important but lets see
# nid height has the least missing values so lets use that

dam_characteristics <- dam %>% 
  select(volume, nid_storage, spillway_width, drainage_area, nid_height, surface_area, dam_length)

# To improve skewed distribution into more of a normal distribution
summary(is.na(dam_characteristics)) # count NA in each column
dam_characteristics[dam_characteristics==0] = 1 # to prevent log transforming errors
log_dam_characteristics <- log(dam_characteristics)
log_dam_characteristics$hazard <- dam$hazard
summary(is.na(log_dam_characteristics))

log_dam_characteristics_subset <- log_dam_characteristics %>%
  select(volume, nid_storage, spillway_width) %>%
  drop_na

# Convert Inf or Nan to NA
# log_dam_characteristics[sapply(log_dam_characteristics, is.infinite)] <- NA


#ggpairs(log_dam_characteristics) 
# Strong correlation:
# hydraulic_height & structural_height
# hydraulic height & dam_height
# dam height & structural height
# log and check volume and anyone height 

# Checking logged dstribution of each potential predictor variable
for (i in length(log_dam_characteristics)) {
  ggplot (log_dam_characteristics) +
    geom_histogram(aes(x = colnames(log_dam_characterisitcs)[i]))
}


corrplot(as.matrix(log_dam_characteristics), is.corr = FALSE, upper = "ellipse")

# Ordinal Logistic Regression

library("MASS")
model_1 <- polr(hazard ~ volume+nid_storage+spillway_width+drainage_area+nid_height+surface_area+dam_length, data = log_dam_characteristics, na.action = na.exclude)
# model_2 <- polr(hazard ~ volume+nid_storage+spillway_width+drainage_area+nid_height+surface_area, data = log_dam_characteristics, na.action = na.exclude)
# model_3 <- polr(hazard ~ volume+nid_storage+spillway_width+drainage_area+nid_height, data = log_dam_characteristics, na.action = na.exclude)
# model_4 <- polr(hazard ~ volume+nid_storage+spillway_width+drainage_area, data = log_dam_characteristics, na.action = na.exclude)
# model_5 <- polr(hazard ~ volume+nid_storage+spillway_width, data = log_dam_characteristics, na.action = na.exclude)

summary(model_1)
# summary(model_2)
# summary(model_3)
# summary(model_4)
# summary(model_5)

summary_table <- coef(summary(model_1))
pval <- pnorm(abs(summary_table[, "t value"]),lower.tail = FALSE)* 2
summary_table <- cbind(summary_table, "p value" = round(pval,3))
summary_table


head(dam)
head(dam)
#-------------------------------------Monotonic trend analysis

# importing gage data
huc8 <- read.csv("Data/Raw/wy01d_col_data.txt", 
                 sep = "\t")
basin_nc <- st_read(here("Data", "Raw", "8Digit_HUC_Subbasins.shp"))

# renaming columns
colnames(huc8) <- sub("X", "", colnames(huc8))

# selecting columns for North Carolina
huc8_nc <- huc8 %>%
  select(date, one_of(as.character(basin_nc$HUC_8)))
ncolumns <- ncol(huc8_nc)
huc8_nc$date <- as.Date(huc8_nc$date, origin = "1901-01-01")
huc8_nc_ts <- ts(huc8_nc[2:ncolumns]) 
plot.ts(huc8_nc_ts[,23])

for (i in 1:ncol(huc8_nc_ts)){
  test_results <- mk.test(huc8_nc_ts[,i])
  if (test_results$p.value < 0.05) {
    basin_nc$trend[i] <- test_results$estimates[3]*100
  }
  else {
    basin_nc$trend[i] <- 0
  }
}
#-------------------------------------Geospatial analysis

# subsetting north carolina dams
dam_nc <- dam[which(dam$state == "NC"),]
dam_nc$river <- tolower(dam_nc$river)
dam_nc <- select(dam_nc, nidid, longitude, latitude, county, river, city, hazard, state)
dam_nc$huc8 <- 

# importing NC boundary shapefile and streams shapefile
stream_nc_raw <- st_read(here("Data", "Raw", "2014_IR_ Overall_Cat.shp"))
stream_nc_raw$AU_NAME <- tolower(stream_nc_raw$AU_NAME)
#colnames(stream_nc_raw)[3] <- "river"
#### +proj=lcc +lat_1=36.16666666666666 +lat_2=34.33333333333334 +lat_0=33.75 +lon_0=-79 +x_0=609601.22 +y_0=0 +datum=NAD83 +units=m +no_defs
state_bound_raw <- st_read(here("Data","Raw", "state_bounds.shp"))
state_bound_raw_nc <- state_bound_raw[which(state_bound_raw$NAME == "North Carolina"),]
#### +proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs

# selecting rivers with dams
stream_nc_raw <- subset(stream_nc_raw, AU_NAME %in% dam_nc$river)


# setting CRS for shapefiles
stream_nc <- stream_nc_raw
st_crs(stream_nc) <- "+proj=lcc +lat_1=36.16666666666666 +lat_2=34.33333333333334 +lat_0=33.75 +lon_0=-79 +x_0=609601.22 +y_0=0 +datum=NAD83 +units=m +no_defs"
stream_nc <- stream_nc %>%
  st_set_crs(32119)
stream_nc <- sf::st_transform(stream_nc, crs = "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs") %>%
  st_set_crs(5070)

state_bound_nc <- state_bound_raw_nc
st_crs(state_bound_nc) <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs"
state_bound_nc <- state_bound_nc %>%
  st_set_crs(5070)

# projecting CRS for shapefiles
na_albers_proj4 <- "+proj=aea +lat_1=20 +lat_2=60 +lat_0=40 +lon_0=-96 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs"
na_albers_epsg <- 102008

state_bound_nc_albers <- sf::st_transform(state_bound_nc, crs = na_albers_proj4) %>%
  st_set_crs(na_albers_epsg)

# checking CRS code
st_crs(stream_nc)
st_crs(state_bound_nc)
st_crs(state_bound_nc_albers)

# converting tabular data to sf format
dam_nc_geo <- st_as_sf (dam_nc, coords = c("longitude", 
                                     "latitude"),
                     crs = 4326, dim = "XY")


# plotting all the shapefile layers
# limit <- max(abs(basin_nc$trend)) * c(-1,1)
# pdf(here("Output", "newest.pdf"), width = 11, height = 8.5)
# ggplot() +
#   geom_sf(data = state_bound_nc_geom, fill = NA) +
#   geom_sf(data = basin_nc, aes(fill = trend), color = "black") +
#   scale_fill_scico (palette = "broc", limit = limit, direction = -1) +
#   geom_sf(data = dam_nc_geo, aes(color = hazard), size = 1.5, alpha = 0.5, show.legend = "point") +
#   scale_color_manual(values = c("red", "green", "orange")) + 
#   labs(x = 'Longitude', y='Latitude', title = "NC Dam Hazard and Monotonic Trend Analysis of subbasin (HUC8) annual water \nrun-off (1901-2018)\n", 
#        color = "Dam Hazard", fill = "Trend Coefficient (%)") +
#   theme_bw() + theme(legend.key = element_blank()) + 
#                        peaceful.theme
# dev.off()

# 
huc8_dam <- st_intersection(dam_nc_geo, basin_nc)

ggplot(subset(huc8_dam, hazard == 'L')) +
  geom_point(aes(x=hazard, y = trend),
               alpha = 0.5) + peaceful.theme

l <- subset(huc8_dam, hazard == 'L')
s <- subset(huc8_dam, hazard == 'S')
h <- subset(huc8_dam, hazard == 'H')

count(l[which(l$trend == 0),]) #841
count(l[which(l$trend > 0),]) #6
count(l[which(l$trend < 0),]) # 484

count(s[which(s$trend == 0),]) #319
count(s[which(s$trend > 0),]) #9
count(s[which(s$trend < 0),]) #225

count(h[which(h$trend == 0),]) #776
count(h[which(h$trend > 0),]) #17
count(h[which(h$trend < 0),]) #514





# to identify crs and epsg

state_bound <- st_read(here("Data","Raw", "state_bounds.shp"))
state_bound_nc <- state_bound[which(state_bound$NAME == "North Carolina"),]
st_crs(state_bound_nc)



proj4string













#-----------------------------------------------------BS
us_map <- map_data("state")
ggplot() + geom_polygon(data = us_map, aes(x = long, y = lat, fill = region, group = group),
               color = "white") +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
  guides (fill = FALSE) + theme_void()

nc <- subset(us_map, region %in% "north carolina")
ggplot(data = nc) +
  geom_polygon(aes(x = long, y = lat), color='white') +
  coord_map(projection = "albers", lat0 = 35.7596, lat1 = 79.0913) +
  guides (fill = FALSE) + theme_void()

map()
ggplot(data = us_states,
       mapping = aes(x = long, y = lat)) + #, group = group, fill = coefficient
  geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45)+
  theme_void() + theme(legend.position = c(0.90, 0.20))

# Line plot for each state
plot_ly(final_data, x=~begin_year, y=~acute_health_based, mode = 'lines',
        color = final_data$state_name) %>%
  add_lines() %>%
  layout(xaxis = list(title = "Year",
                      zeroline = FALSE),
         yaxis = list(title = "Acute SDWA Violations",
                      zeroline = FALSE))


pdf(here("outputs", "pdf_test.pdf"), width = 11, height = 8.5)
ggplot(data = cars) +
  geom_point(aes(x = dist, y = speed))
dev.off()

# identifying outliers in continuous data
ggplot()
=======
#-------------Exploratory data analysis
# Dam safety hazards
ggplot(dam) +
  geom_boxplot(aes(hazard))
>>>>>>> 649baf41350e87761aafd6dbf815263a201968ff

# exploring variables that explain dam safety

# Map

# Importing gage data for NC


#information about each column http://files.hawaii.gov/dbedt/op/gis/data/nid_dams_data_dictionary.htm#Dam_type
#nformation on how can dams collapse https://www.fema.gov/dam-failure-information 
#git push -f origin master
