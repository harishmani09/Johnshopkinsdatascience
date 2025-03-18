library(data.table)
library(tidyverse)
library(ggplot2)
NEI <- readRDS('exdata_data_NEI_data/summarySCC_PM25.rds')
SCC <- readRDS('exdata_data_NEI_data/Source_Classification_Code.rds')

motorscc <- grepl('vehicle',SCC$EI.Sector, ignore.case = TRUE)
newscc <- SCC[motorscc,]

motor_scc <- unique(newscc$SCC)
motor_emi <- NEI[(NEI$SCC %in% motor_scc),]

motor_year <- motor_emi |> 
    filter(fips == '24510'| fips=='06037') |>
    group_by(fips,year) |>
    mutate( Unit = ifelse(fips == "24510", "Baltimore City",
                          ifelse(fips == "06037", "Los Angeles County",Unit)))
    

png('plot6.png')

ggplot(motor_year, aes(x=factor(year),y=Emissions)) +
    geom_bar(aes(fill=year),stat='identity') + 
    facet_grid(scales='free',space='free',.~Unit) +
    xlab('Year') + ylab('PM2.5 Emissions in tons') + ggtitle('Emissions in Baltimore & Losangles county')

dev.off()