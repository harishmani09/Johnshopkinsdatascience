## Exploratory Data Analysis Project 1

This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets. In particular, we will be using the “Individual household electric power consumption Data Set” which I have made available on the course web site:

Dataset:
[Electric power consumption](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip) [20Mb]
</br>Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.
```R
library(data.table)
library(dplyr)
library(lubridate)
#download data
url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(url,destfile = 'household_power_consumption.zip',method='curl')

#unzip file
unzip(zipfile = 'household_power_consumption.zip')

powerdata <- fread('household_power_consumption.txt',na.strings = "?")
head(powerdata)
#selecting the target dates 2007-02-01 and 2007-02-02
power <- powerdata |> mutate(Date = dmy(Date))
reldata <- power |> filter(between(Date, as.Date('2007-02-01'),as.Date('2007-02-02')))

png('plot1.png',width = 480,height = 480)
#plot 1
hist(reldata[,Global_active_power],main="Global Active Power",col='red',xlab = 'Global Active Power(kilowatts)',ylab='Frequency')
dev.off()
```

```R
library(data.table)
library(dplyr)
library(lubridate)
#download data
url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(url,destfile = 'household_power_consumption.zip',method='curl')

#unzip file
unzip(zipfile = 'household_power_consumption.zip')

powerdata <- fread('household_power_consumption.txt',na.strings = "?")
head(powerdata)
#selecting the target dates 2007-02-01 and 2007-02-02
power <- powerdata |> mutate(Date = dmy(Date))
reldata <- power |> filter(between(Date, as.Date('2007-02-01'),as.Date('2007-02-02')))

png('plot1.png',width = 480,height = 480)
#plot 1
hist(reldata[,Global_active_power],main="Global Active Power",col='red',xlab = 'Global Active Power(kilowatts)',ylab='Frequency')
dev.off()
```

```R
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


```

```R
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

```
