#SET UP
rm(list = ls())
source("../pct-scripts/00_setup_and_funs.R")
memory.limit(size=1000000)

# SET INPUT PARAMETERS
purpose <- "commute"
purpose_private <- paste0(purpose, "_private")
geography <- "lsoa"  

build_params <- read_csv(file.path("list_pct_region.csv"))

#########################
### READ IN REGIONS AND RUN BUILD MASTER FOR EACH
#########################

# DEFINE WHICH REGIONS TO BUILD [modify in input csv file]
regions_tobuild <- as.character(build_params$region_name[build_params$to_rebuild==1])

for(k in 1:length(regions_tobuild)){

  # SUBSET TO THE SELECTED REGION
  region <- regions_tobuild[k]
  
  rf <- readRDS(file.path(paste0("../pct-outputs-regional-R/", purpose, "/", geography, "/",  region, "/rf.RDS")))
  rf <- rf[rf@data$rf_dist_km<=10,]
  saveRDS(rf, (file.path(paste0(purpose, "/", geography, "/",  region, "/rf.RDS"))))

  rq <- readRDS(file.path(paste0("../pct-outputs-regional-R/", purpose, "/", geography, "/",  region, "/rq.RDS")))
  rq <- rq[rq@data$rf_dist_km<=10,]
  saveRDS(rq, (file.path(paste0(purpose, "/", geography, "/",  region, "/rq.RDS"))))

  l <- readRDS(file.path(paste0("../pct-outputs-regional-R/", purpose, "/", geography, "/",  region, "/l.RDS")))
  l <- l[l@data$rf_dist_km<=10,]
  saveRDS(l, (file.path(paste0(purpose, "/", geography, "/",  region, "/l.RDS"))))

 #file.remove(paste0(purpose, "/", geography, "/",  region, "/rnet_full.RDS"))

    message(paste0("Finished ", region," at ",Sys.time()))
}
