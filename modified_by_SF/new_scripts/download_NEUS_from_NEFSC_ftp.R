#download NEFSC trawls from ftp

library(curl)


#lots of good info (including important notes for QAQC here: https://www.fisheries.noaa.gov/inport/item/22557)

#children items are at bottom
# https://www.fisheries.noaa.gov/inport/item/22560 #fall
# https://www.fisheries.noaa.gov/inport/item/22561 #spring
# https://www.fisheries.noaa.gov/inport/item/22562 #summer
# https://www.fisheries.noaa.gov/inport/item/22563 #winter

urls <- c("ftp://ftp.nefsc.noaa.gov/pub/dropoff/PARR/PEMAD/ESB/SVDBS/",
          "ftp://ftp.nefsc.noaa.gov/pub/dropoff/PARR/PEMAD/ESB/22560/",
          "ftp://ftp.nefsc.noaa.gov/pub/dropoff/PARR/PEMAD/ESB/22561/",
          "ftp://ftp.nefsc.noaa.gov/pub/dropoff/PARR/PEMAD/ESB/22562/",
          "ftp://ftp.nefsc.noaa.gov/pub/dropoff/PARR/PEMAD/ESB/22563/"
          )

url_list <- lapply(urls, function(x){

  h = new_handle(dirlistonly=TRUE)
  con = curl(x, "r", h)
  tbl = read.table(con, stringsAsFactors=TRUE, fill=TRUE)
  close(con)
  paste0(x, tbl$V1)
  
}) %>% unlist()

lapply(url_list, function(x){
  download.file(x, destfile = paste0("modified_by_SF/raw_data/neus/", basename(x)))
})


#These conversion factors: NEFSC_conv <- read_csv(
"https://github.com/pinskylab/OceanAdapt/raw/master/data_raw/NEFSC_conversion_factors.csv",
col_types = "_ddddddd")

#Seem to be available from this document: https://repository.library.noaa.gov/view/noaa/3726