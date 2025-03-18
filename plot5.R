library(data.table)
library(tidyverse)
library(ggplot2)
NEI <- readRDS('exdata_data_NEI_data/summarySCC_PM25.rds')
SCC <- readRDS('exdata_data_NEI_data/Source_Classification_Code.rds')

motorscc <- grepl('vehicle',SCC$EI.Sector, ignore.case = TRUE)
newscc <- SCC[motorscc,]
mv_NEI <- merge(NEI,newscc,by='SCC')

motor_year <- mv_NEI |> 
    filter(fips=='24510') |>
    group_by(year) |>
    summarise(total = sum(Emissions))

png('plot5.png')
ggplot(motor_year, aes(x=year,y=total))+
    geom_line() + geom_point() +
    xlab('Year') + ylab("PM2.5 in tonnes") + 
    ggtitle('Motor Vehicle Emissions in Baltimore over the years')

dev.off()

    