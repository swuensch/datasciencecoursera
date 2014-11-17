# 0-0) get data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "NEI_data.zip", "curl")
unzip("NEI_data.zip")

# 0-1) load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot 1)
em_by_year <- aggregate(NEI$Emissions, list(NEI$year), sum)
png("plot1.png")
plot(em_by_year, main = 'total emissions', xlab = 'year', ylab = 'pm_2.5 [tons]', col = 'cornflowerblue', type = 'h', lwd = 2)
dev.off()

# plot 2)
baltimore_filter <- NEI$fips == "24510"
d <- NEI[baltimore_filter, ]
d_agg <- aggregate(d$Emissions, list(d$year), sum)
png("plot2.png")
plot(d_agg, main = 'total emissions, Baltimore City',
     xlab = 'year', ylab = 'pm_2.5 [tons]', col = 'cornflowerblue', type = 'h', lwd = 2)
dev.off()

# plot 3)
library(ggplot2)
baltimore_filter <- NEI$fips == "24510"
d <- NEI[baltimore_filter, ]
d_agg <- aggregate(d$Emissions, list(d$year, d$type), sum)
png("plot3.png")
qplot(Group.1, x, data = d_agg, facets = . ~ Group.2,
      main = 'total emission', xlab = 'year')
dev.off()

# plot 4)
scc_filter <- NEI$SCC %in% SCC[grep("Comb.*Coal.*", SCC$Short.Name), "SCC"]
d <- NEI[scc_filter, ]
d_agg <- aggregate(d$Emissions, list(d$year), sum)
png("plot4.png")
plot(d_agg, main = 'total emissions due to coal',
     xlab = 'year', ylab = 'pm_2.5 [tons]', col = 'cornflowerblue', type = 'h', lwd = 2)
dev.off()

# plot 5)
vehicles_filter <- NEI$SCC %in% SCC[grep("Vehicles", SCC$SCC.Level.Two), "SCC"]
baltimore_filter <- NEI$fips == "24510"
d <- NEI[vehicles_filter & baltimore_filter, ]
d_agg <- aggregate(d$Emissions, list(d$year), sum)
png("plot5.png")
plot(d_agg, main = 'total emissions due to vehicles in Baltimore',
     xlab = 'year', ylab = 'pm_2.5 [tons]', col = 'cornflowerblue', type = 'h', lwd = 2)
dev.off()

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