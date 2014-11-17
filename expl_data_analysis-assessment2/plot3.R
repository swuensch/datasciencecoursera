NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot 3)
library(ggplot2)
baltimore_filter <- NEI$fips == "24510"
d <- NEI[baltimore_filter, ]
d_agg <- aggregate(d$Emissions, list(d$year, d$type), sum)
png("plot3.png")
qplot(Group.1, x, data = d_agg, facets = . ~ Group.2,
      main = 'total emission', xlab = 'year')
dev.off()