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