library(data.table)
library(tidyverse)
library(ggplot2)


NEI <- readRDS('exdata_data_NEI_data/summarySCC_PM25.rds')
balt_type <- NEI |> 
    select(type,fips,Emissions,year) |>
    filter(fips=='24510')

png('plot3.png',width = 480,height = 480)
ggplot(balt_type,aes(factor(year),Emissions,fill=type)) + 
    facet_grid(.~type,scales='free',space='free') + geom_bar(stat='identity')+
    ggtitle('Total emissions in Baltimore by source type') +
    theme(axis.text.x=element_text(angle = 90, vjust = 0.5, hjust = 1)) +
    xlab('Year') + ylab('PM2.5 emissions in Tons')

dev.off()
