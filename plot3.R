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

#converting date from char to Date
powerdata$Date <- as.Date(powerdata$Date,format = "%d/%m/%Y") 


#subsetting the data between 2007-02-01 and 2007-02-02
reqdata <- subset(powerdata, Date>="2007-02-01" & Date < "2007-02-03" )
rm(powerdata)

#creating datetime
datetime <- paste(as.Date(reqdata$Date),reqdata$Time,sep=" ")
reqdata$dateTime <- as.POSIXct(datetime)

#png object
png("plot3.png",width = 480, height = 480)

#plot 3
plot(x=reqdata[,dateTime],y=reqdata[,Sub_metering_1],type='l',xlab='',ylab='Energy sub metering')
lines(x=reqdata[,dateTime],y=reqdata[,Sub_metering_2],col='red')
lines(x=reqdata[,dateTime],y=reqdata[,Sub_metering_3],col='blue')
legend("topright",col=c('black','red','blue'),c("sub_metering_1","sub_metering_2","sub_metering_3"),lty=c(1,1),lwd=c(1,1))
dev.off()

