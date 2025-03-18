library(data.table)
library(tidyverse)

NEI <- readRDS('exdata_data_NEI_data/summarySCC_PM25.rds')
setDT(NEI)
SCC <- readRDS('exdata_data_NEI_data/Source_Classification_Code.rds')
setDT(SCC)



# Question1

#prevents histogram from printing in scientific notaitons
NEI[,Emissions := lapply(.SD,as.numeric), .SDcols = c('Emissions')]

totalNEI <- NEI[,lapply(.SD,sum,na.rm=TRUE),.SDcols = c('Emissions'),by=year]

png(filename='plot1.png')

barplot(totalNEI[,Emissions], 
        names=totalNEI[,year],
        xlab='Years',ylab='Emissions',
        main='Emissions over the year'
)
dev.off()
