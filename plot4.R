library(data.table)
library(tidyverse)

NEI <- readRDS('exdata_data_NEI_data/summarySCC_PM25.rds')
setDT(NEI)
head(NEI)
head(scc_coal)
SCC <- readRDS('exdata_data_NEI_data/Source_Classification_Code.rds')
setDT(SCC)

coal_fired <- grepl('coal', SCC$EI.Sector, ignore.case=TRUE)
scc_coal <- SCC[coal_fired,]
scc_coal <- scc_coal[,as.character(SCC)]

combustionNEI <- NEI[NEI[,SCC] %in% scc_coal]

png("plot4.png")
ggplot(combustionNEI, aes(x=factor(year),y=Emissions/10^5))+
    geom_bar(stat='identity',fill="#FF9999") +
    xlab("Year") + ylab("Total PM.25 Emissions (tons)") + 
    ggtitle("Total PM2.5 Emissions from Coal Combustion-Related Sources by Year")
dev.off()