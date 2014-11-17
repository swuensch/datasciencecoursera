NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot 2)
baltimore_filter <- NEI$fips == "24510"
d <- NEI[baltimore_filter, ]
d_agg <- aggregate(d$Emissions, list(d$year), sum)
png("plot2.png")
plot(d_agg, main = 'total emissions, Baltimore City',
     xlab = 'year', ylab = 'pm_2.5 [tons]', col = 'cornflowerblue', type = 'h', lwd = 2)
dev.off()