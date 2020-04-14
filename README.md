# US Dam Safety and Climate Change

## Summary

This repository contains the files pertaining to the hydrologic analysis of dams and their safety in US and specifically, North Carolina. Despite their socio-economic benefits, dams are prone to failure which can cause massive loss of life and property. According to the National Inventory of Dams (NID), currently, there are 14,254 dams that are classified as having high risk of failure. Therefore, my first goal is to study the variables related to dams that can affect their classification of failure risk. For such purpose, I use the 2019 National Inventory of Dams dataset released by the US Army Corps of Engineers. 

Moreover, I also plan to investigate the effect of precipitation and/or discharge on dam failure risk. Climate Change is increasing frequency of heaviest precipitation events across the US that can stress the physical structure of dams. For such purpose, I use USGS North Carolina stream gage data for the period of record in order to determine hydrologic trends.

<describe the purpose of this repository, the information it contains, and any relevant analysis goals. What, why, where, when, how?>

## Investigators

Pierre Mishra
Masters of Environmental Management, 2021
Nicholas School of the Environment, Duke University
Contact: prashank.mishra@duke.edu

## Keywords

dam safety, precipitation, water infrastructure, hydrology, north carolina

## Database Information

* 2019 National Inventory of Dams, US Army Corps of Engineers,
The NID dataset contains US dam inventory of approximately 90,000 dams. It has been further processed to contain columns of relevant variables.

Accessed: March 23, 2020

* North Carolina Daily Streamflow Conditions, United States Geological Survey
Daily streamflow data obtained from USGS will be grouped to monthly data for the stations that fall within 5 miles of dams.

Accessed: TBD


## Folder structure, file formats, and naming conventions 

* Code - Contains .R file for the analysis
* Data - Contains raw and processed data sets in comma separated values and shapefile formats/
  + Raw - Contains unedited csv and shapefiles
  + Processed - Contains edited csv file
* Output - Contains .rmd file for developing the report and presenting results of the analysis

File names are in the following format: final_project_env872_<title>.<extension>

## Metadata

Source: <https://nid.sec.usace.army.mil/ords/f?p=105:21:7801154475967::NO:::>
Column Header | Description | Data Type
--------------|-------------|-----------
dam_name | Official name of the dam | Alphanumeric
nidid | Official identification number for the dam | Alphanumeric


<For each data file in the repository, describe the data contained in each column. Include the column name, a description of the information, the class of data, and any units associated with the data. Create a list or table for each data file.> 

## Scripts and code

The following code was used to make the processed data set. Further edits will be updated.

```R
# Removing irrelevant columns
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
``` 

## Quality assurance/quality control

<describe any relevant QA/QC procedures taken with your data. Some ideas can be found here:>
<https://www.dataone.org/best-practices/develop-quality-assurance-and-quality-control-plan>
<https://www.dataone.org/best-practices/ensure-basic-quality-control>
<https://www.dataone.org/best-practices/communicate-data-quality>
<https://www.dataone.org/best-practices/identify-outliers>
<https://www.dataone.org/best-practices/identify-values-are-estimated>
