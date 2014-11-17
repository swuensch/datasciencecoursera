NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot 5)
vehicles_filter <- NEI$SCC %in% SCC[grep("Vehicles", SCC$SCC.Level.Two), "SCC"]
baltimore_filter <- NEI$fips == "24510"
d <- NEI[vehicles_filter & baltimore_filter, ]
d_agg <- aggregate(d$Emissions, list(d$year), sum)
png("plot5.png")
plot(d_agg, main = 'total emissions due to vehicles in Baltimore',
     xlab = 'year', ylab = 'pm_2.5 [tons]', col = 'cornflowerblue', type = 'h', lwd = 2)
dev.off()
