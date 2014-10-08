## plot2.R -> plot2.png

library(dplyr)

fileURL      <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
localZipFile <- "./data/household_power_consumption.zip"
localFile    <- "./data/household_power_consumption.txt"
outputFile   <- "plot2.png"

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

## Reads the data file
readDataFile <- function(fileName, ...){
  if(! file.exists(fileName)){
    stop(paste("readDataFile: File ", fileName, " doesn't exist"))
  }
  
  print(paste("Reading file ", fileName))
  read.table(fileName, ...)
}

main <- function(){
  downloadAndExtractZipFile()
  
  ## TODO
  ## Merge Date + Time variables and convert to Date/Time class
  data <- 
    readDataFile(localFile, sep = ";", header = TRUE, na.strings = "?") %>%
    transform(Date = as.Date(Date, format = "%d/%m/%Y")) %>% ##, Time = strptime(Time, format = "%H:%M:%S")) %>%
    filter(Date == "2007-02-01" | Date == "2007-02-02")
  
  
  #png(filename = outputFile, width = 480, height = 480)
  #with(data, plot(Time2, Global_active_power, type = "l"))
  
  print(paste("Plot 2 created - ", outputFile))

data
}

