NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot 4)
scc_filter <- NEI$SCC %in% SCC[grep("Comb.*Coal.*", SCC$Short.Name), "SCC"]
d <- NEI[scc_filter, ]
d_agg <- aggregate(d$Emissions, list(d$year), sum)
png("plot4.png")
plot(d_agg, main = 'total emissions due to coal',
     xlab = 'year', ylab = 'pm_2.5 [tons]', col = 'cornflowerblue', type = 'h', lwd = 2)
dev.off()