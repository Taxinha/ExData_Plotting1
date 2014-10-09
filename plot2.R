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

## Get the data from the filw and returns the rows for 2007-02-01 and 2007-02-02 only
getSubSetData <- function(){
  dt <- readDataFile(localFile, sep = ";", header = TRUE, na.strings = "?") %>%
    transform(DateTime = strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), 
              Date = as.Date(Date, format = "%d/%m/%Y")) %>%
    filter(Date == "2007-02-01" | Date == "2007-02-02")
  
  dt
}

main <- function(){
  downloadAndExtractZipFile()
  
  data <- getSubSetData()
    
  png(filename = outputFile, width = 480, height = 480, bg = "transparent")
  with(data, plot(DateTime, Global_active_power, type = "l", 
                  ylab = "Global Active Power (kilowatts)", xlab = ""))
  dev.off()
  
  print(paste("Plot 2 created -", outputFile))
}

main()
