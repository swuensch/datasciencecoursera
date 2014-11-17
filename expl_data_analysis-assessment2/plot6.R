NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot 6)
vehicles_filter <- NEI$SCC %in% SCC[grep("Vehicles", SCC$SCC.Level.Two), "SCC"]
baltimore_filter <- NEI$fips == "24510"
la_filter <- NEI$fips == "06037"
d <- NEI[(vehicles_filter & baltimore_filter) | (vehicles_filter & la_filter), ]
d_agg <- aggregate(d$Emissions, list(d$year, d$fips), sum)
png("plot6.png")
qplot(Group.1, x, data = d_agg, facets = . ~ Group.2,
      main = 'total emission', xlab = 'year')
dev.off()