library(data.table)
library(tidyverse)

NEI <- readRDS('exdata_data_NEI_data/summarySCC_PM25.rds')
setDT(NEI)
SCC <- readRDS('exdata_data_NEI_data/Source_Classification_Code.rds')
setDT(SCC)


baltimore <- subset(NEI,fips=='24510')
balt_emissions <- tapply(baltimore$Emissions, baltimore$year, sum)

#set png parameters
png(filename='plot2.png',width=480,height=480)

#plot the graph using base method
barplot(balt_emissions,xlab='year',ylab='PM2.5 Emissions(tons)',main='Total PM2.5 Emissions in Baltimore by Year')

dev.off()
