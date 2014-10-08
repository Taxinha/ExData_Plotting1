## plot4.R -> plot4.png


fileURL      <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
localZipFile <- "./data/household_power_consumption.zip"
localFile    <- "household_power_consumption.txt"

## Download and Extract Zip data file
downloadAndExtractZipFile <- function(){
  ## check if the data folder exists
  if(!file.exists("data")){
    dir.create("data")
  }
  
  ## check if file exists - if not download the zip file with the data
  if(!file.exists(localZipFile)){
    download.file(fileURL, destfile = localZipFile, method = "curl")
    
    ## extract the zip file
    unzip(localZipFile, overwrite = TRUE, exdir = "./data")
  }
}

main <- function(){
  downloadAndExtractZipFile()
  
  
}