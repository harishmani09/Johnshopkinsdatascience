library(data.table)
library(dplyr)
library(lubridate)

#download data
url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(url,destfile = 'household_power_consumption.zip',method='curl')

#unzip file
unzip(zipfile = 'household_power_consumption.zip')

#read data using data.table::fread
powerdata <- fread('household_power_consumption.txt',na.strings = "?")

#subsetting the data bewteen dates 2007-02-01 and 2007-02-02
reldata <- powerdata[power$Date %in% c("2007-02-01","2007-02-02"),]

#converting date column as POSIXct datetime column
reldata[,dateTime := as.POSIXct(paste(Date,Time),format="%d/%m/%Y %H:%M:%S")] 

#getting the plot 
png("plot2.png",width = 480,height = 480)
plot(x=reldata[,dateTime],y=reldata[,Global_active_power],type = "l",xlab="",ylab="Global_active_power(kilowatts)")

dev.off()
