# US Dam Safety and HUC-8 Runoff

The results of the analysis can be found at Output/Mishra_FinalProject_ENV872.pdf

## Summary

This repository contains the files pertaining to the hydrologic analysis of dams and their safety in US and specifically, North Carolina. Despite their socio-economic benefits, dams are prone to failure which can cause massive loss of life and property. According to the National Inventory of Dams (NID), currently, there are 14,254 dams that are classified as having high risk of failure. Therefore, my first goal is to study the variables related to dams that can affect their classification of failure risk. For such purpose, I use the 2019 National Inventory of Dams dataset released by the US Army Corps of Engineers. 

Moreover, I also plan to investigate the effect of precipitation and/or discharge on dam failure risk. Climate Change is increasing frequency of heaviest precipitation events across the US that can stress the physical structure of dams. For such purpose, I use USGS North Carolina stream gage data for the period of record in order to determine hydrologic trends.

## Investigators

Pierre Mishra, Masters of Environmental Management, 2021, Nicholas School of the Environment, Duke University

Contact: prashank.mishra@duke.edu

## Keywords

dam safety, precipitation, water infrastructure, hydrology, north carolina, national inventory of dams, usgs gage data, climate change

## Database Information

* 2019 National Inventory of Dams, US Army Corps of Engineers

The NID dataset contains US dam inventory of approximately 90,000 dams. It has been further processed to contain columns of relevant variables. Source: <https://nid.sec.usace.army.mil/ords/f?p=105:21:7801154475967::NO:::>

Accessed: March 23, 2020

* WaterWatch, United States Geological Survey

This platform provids computed annual run-off for all hydrologic units since 1901. The dataset comes with a PDF file named 'huc_8_readme.pdf' located in Data/Raw folder describing the methodology behind calculating annual run-off for the HUCs. The data was further cleaned and subsetted for North Carolina HUC-8 sub-basins. Source: <https://waterwatch.usgs.gov/index.php?id=romap3&sid=w__download>

Accessed: April 3, 2020

* 8-digits HUC sub-basins, NC Department of Environmental Quality Online GS 

This data contains shapefiles of all HUC-8 sub basins for NC. The data was originated from USGS database. Source: <http://data-ncdenr.opendata.arcgis.com/datasets/8-digit-huc-subbasins?geometry=-85.940%2C33.597%2C-73.899%2C36.739&orderBy=HUC_8&orderByAsc=false>

Accessed: April 3, 2020

* States Boundary, Bureau of Transportation Statistics

This a shapefile of all state boundaries. Source: <http://osav-usdot.opendata.arcgis.com/datasets/c6717a90c9fe4f1986ba40789cbe124f_0>

Accessed: April 5, 2020

## Folder structure, file formats, and naming conventions 

* Code - Contains .R file for the analysis
* Data - Contains raw and processed data sets in comma separated values and shapefile formats/
  + Raw - Contains unedited csv and shapefiles
  + Processed - Contains edited csv file
* Output - Contains .rmd file for developing the report and presenting results of the analysis

File names are in the following format: final_project_env872_<title>(dot)<file_format>

## Metadata

Source: <https://nid.sec.usace.army.mil/ords/f?p=105:21:7801154475967::NO:::>
Column Header | Description | .R Data Type
--------------|-------------|-----------
dam_name | Official name of the dam | Character
nidid | Official identification number for the dam | Character
longitude | Longitude at dam centerline as a single value in decimal degrees, NAD83 | Number
latitude |   Latitude at dam centerline as a single value in decimal degrees, NAD83 | Number
county | Name of the county in which dam is located | Alphanumeric | Character
river | Official name of the river or stream on or near which the dam is built | Character
city | Name of the nearest downstream city, town, or village that is most likely to be affected by floods resulting from the failure of the dam | Character
distance | Distance from the dam to the nearest affected downstream city/town/village in miles | Number
owner_type | Code to indicate the type of owner: F for Federal;S for State; L for Local Government (defined as have taxing authority or is supported by taxes); U for Public Utility; P for Private; X for Not Listed. Codes are concatenated if the dam is owned by more than one type | Factor
private_dam | Code indicating whether this dam is a non-federal dam located on federal property | Factor
dam_type |  Codes, in order of importance, to indicate the type of dam: RE for Earth; ER for Rockfill; PG for Gravity; CB for Buttress; VA for Arch; MV for Multi-Arch; RC for Roller-Compacted Concrete; CN for Concrete; MS for Masonry; ST for Stone; TC for Timber Crib; OT for Other. Codes are concatenated if the dam is a combination of several types | Factor
core | Code to indicate the position, type of watertight member and certainty, Position:F for upstream facing; H for homogeneous dam;I for core; X for unlisted/unknown; Type:A for bituminous concrete; C for concrete; E for earth; M for metal; P for plastic; X for unlisted/unknown; Certainty:K for known; Z for estimated | Factor
foundation | Code for the material upon which dam is founded, and certainty, Foundation:R for rock; RS for rock and soil; S for soil; U for unlisted/unknown. Certainty:K for known; Z for estimated | Factor
puroposes | Codes to indicate the current purpose(s) for which the reservoir is used:I for Irrigation; H for Hydroelectric; C for Flood Control and Storm Water Management; N for Navigation; S for Water Supply; R for Recreation; P for Fire Protection, Stock, Or Small Farm Pond; F for Fish and Wildlife Pond; D for Debris Control; T for Tailings; G for Grade Stabilization; O for Other. The order should indicate the relative decreasing importance of the purpose. Codes are concatenated if the dam has multiple purposes | Factor
year_completed | Year (four digits) when the original main dam structure was completed.  If unknown, and reasonable estimate is unavailable, “0000” is used | Number
dam_length | Length of the dam, in feet, which is defined as the length along the top of the dam.  This also includes the spillway, powerplant, navigation lock, fish pass, etc., where these form part of the length of the dam | Number
dam_heigth | Height of the dam, in feet to the nearest foot , which is defined as the vertical distance between the lowest point on the crest of the dam and the lowest point in the original streambed | Number
structural_height | Structural height of the dam, in feet to the nearest foot, which is defined as the vertical distance from the lowest point of the excavated foundation to the top of the dam | Number
hydraulic_height |  Hydraulic height of the dam, in feet to the nearest foot , which is defined as the vertical difference between the maximum design water level and the lowest point in the original streambed | Number
nid_height | Maximum value of dam height, structural height, and hydraulic height, in feet. Accepted as the general height of the dam | Number
max_discharge | Number of cubic feet per second (cu ft/sec) which the spillway is capable of discharging when the reservoir is at its maximum designed water surface elevation | Number
max_storage | Maximum storage, in acre-feet, which is defined as the total storage space in a reservoir below the maximum attainable water surface elevation, including any surcharge storage | Number
normal_storage | Normal storage, in acre-feet, which is defined as the total storage space in a reservoir below the normal retention level, including dead and inactive storage and excluding any flood control or surcharge storage.  For normally dry flood control dams, the normal storage will be a zero value | Number
nid_storage | Maximum value of normal storage and maximum storage.  Accepted as the general storage of the dam | Number
surface_area | Surface area, in acres, of the impoundment at its normal retention level | Number
drainage_area |  Drainage area of the dam, in square miles, which is defined as the area that drains to a particular point (in this case, the dam) on a river or stream | Number
hazard | Code to indicate the potential hazard to the downstream area resulting from failure or mis-operation of the dam or facilities:L for Low; S for Significant; H for High U for Undetermined | Factor
eap | Whether this dam has an Emergency Action Plan (EAP) developed by the dam owner. Y for Yes;N for No; NR for Not Required by submitting agency | Factor
inspection_frequency | The scheduled frequency interval for periodic inspections, in years | Number
state_reg_dam | Calculated field based on Permitting Authority, Inspection Authority and Enforcement Authority.  If Yes to all three authority criteria, then dam is state regulated and will be listed as Yes | Integer
spillway_type | Code that describes the type of spillway:C for Controlled; U for Uncontrolled; N for None | Factor
spillway_width | Width of the spillway, to the nearest foot, available for discharge when the reservoir is at its maximum designed water surface elevation.  Typically for an open channel spillway, this is the bottom width | Integer
volume |   Total number of cubic yards occupied by the materials used in the dam structure.  Portions of powerhouse, locks, and spillways are included only if they are an integral part of the dam and required for structural stability | Number
state | State where dam is located | Character
enforcementauthority | Yes if the state regulatory organization has the authority to issue notices, when applicable, to require owners of dams to perform necessary maintenance or remedial work, revise operating procedures, or take other actions, including breaching dams when necessary (from the Dam Safety Act of 2006) | Factor 
age | Years since a dams's construction completed | Number

## Scripts and code

The following code was used to make the processed data set 'dam.csv'.

```R
# Removing irrelevant columns
# Lowercase column headers
colnames(df) <- tolower(colnames(df))

# Removing unnecessary columns
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

# Removing dam records with undetermined or NA risk
dam <- droplevels(dam[!(dam$hazard=="U" | dam$hazard=="N"),])

# Making dam hazard column into ordinal categorical type
dam$hazard <- factor(dam$hazard, order = TRUE, levels = c("L", "S", "H"))

# Calculating the age of dams
dam$age <- 2019 - dam$year_completed

# Export 
write.csv(dam, "Data/Processed/dam.csv")
``` 

The following code was used to make the processed data set 'log_dam_characteristics.csv'.

```R
# Log transforming data to improve skewness
# count NAs in each column
summary(is.na(dam_characteristics)) 

# To prevent log transforming errors
dam_characteristics[dam_characteristics==0] = 1 
log_dam_characteristics <- log(dam_characteristics)
log_dam_characteristics$hazard <- dam$hazard

# Export
write.csv(log_dam_characteristics, "Data/Processed/log_dam_characteristics.csv" )
```

The following code was used to make the processed data set 'huc8_runoff_nc.csv'.

```R
# Importing gage time series data
huc8 <- read.csv("../Data/Raw/wy01d_col_data.txt", 
                 sep = "\t")
                 
# Importing NC sub-basins shapefile
basin_nc <- st_read("../Data/Raw/8Digit_HUC_Subbasins.shp")

# renaming columns of gage dataset
colnames(huc8) <- sub("X", "", colnames(huc8))

# selecting gage columns for North Carolina by matching with NC basin shapefile
huc8_nc <- huc8 %>%
  select(date, one_of(as.character(basin_nc$HUC_8)))
ncolumns <- ncol(huc8_nc)
huc8_nc$date <- as.Date(huc8_nc$date, origin = "1901-01-01")
huc8_nc_ts <- ts(huc8_nc[2:ncolumns]) 

# Saving run-off time series for NC 
write.csv(huc8_nc, "Data/Processed/huc8_runoff_nc.csv")
```

## Quality assurance/quality control

The NID dataset was checked for erroneous data entry. Scatterplots were plotted for continuous variables to check for outliers. The values for each column were made consistent with relevant data type of that column. 
