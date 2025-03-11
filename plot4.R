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

#getting a posixct datetime time column for filtering data table
powerdata[,dateTime := as.POSIXct(paste(Date,Time),format="%d/%m/%Y %H:%M:%S")]

#filtering the requisite dates 2007-02-01 and 2007-02-02
reqdata <- powerdata[(dateTime>="2007-02-01") & (dateTime <= "2007-02-02")]


#png object
png('plot4.png',width=480,height=480)

par(mfrow=c(2,2))

#plot 1
plot(reqdata[,dateTime],reqdata[,Global_active_power],xlab="",ylab="Global Active Power",type='l')

#plot 2
plot(reqdata[,dateTime],reqdata[,Voltage],xlab = 'datetime',ylab='Voltage',type = 'l')

#plot3 
plot(x=reqdata[,dateTime],y=reqdata[,Sub_metering_1],type='l',xlab='',ylab='Energy sub metering')
lines(x=reqdata[,dateTime],y=reqdata[,Sub_metering_2],col='red')
lines(x=reqdata[,dateTime],y=reqdata[,Sub_metering_3],col='blue')
legend("topright",col=c('black','red','blue'),c("sub_metering_1","sub_metering_2","sub_metering_3"),lty=c(1,1),lwd=c(1,1))

#plot3
plot(reqdata[,dateTime],reqdata[,Global_reactive_power],type='l',xlab='datetime',ylab='Global_reactive_power')

dev.off()
