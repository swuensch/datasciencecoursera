NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot 1)
em_by_year <- aggregate(NEI$Emissions, list(NEI$year), sum)
png("plot1.png")
plot(em_by_year, main = 'total emissions', xlab = 'year', ylab = 'pm_2.5 [tons]', col = 'cornflowerblue', type = 'h', lwd = 2)
dev.off()