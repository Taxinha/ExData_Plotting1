## plot4.R -> plot4.png

library(dplyr)

fileURL      <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
localZipFile <- "./data/household_power_consumption.zip"
localFile    <- "./data/household_power_consumption.txt"
outputFile   <- "plot4.png"

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
  par(mfrow = c(2, 2))
  ## 1st graphic
  with(data, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))
  
  ## 2nd graphic
  with(data, plot(DateTime, Voltage, type = "l", xlab = "datetime"))
  
  ## 3rd graphic
  with(data, plot(DateTime, Sub_metering_1, type = "n", xlab = "", 
                  ylab = "Energy sub metering"))
  with(data, lines(DateTime, Sub_metering_1, col = "black"))
  with(data, lines(DateTime, Sub_metering_2, col = "red"))
  with(data, lines(DateTime, Sub_metering_3, col = "blue"))
  legend("topright", lty = c(1, 1, 1), bty = "n", col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  ## 4th graphic
  with(data, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"))
  
  dev.off()
  
  print(paste("Plot 4 created -", outputFile))
}

main()
