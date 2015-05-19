require(dplyr)
require(ggplot2)

## Load Data
NEI <- readRDS("summarySCC_PM25.rds")
NEI <- tbl_df(NEI)

## Filtering data for Baltimore City (fips = "24510") 
NEI <- filter(NEI,fips=="24510")

## Grouping table by year
NEI <- group_by(NEI,year,type)

## Summarizing data using group above and getting total of each group (year)
NEI_sum <- summarize(NEI,total = sum(Emissions))

## Redirecting plot output to png
png(filename = "plot3.png",width = 480, height = 480, units = "px",bg = "white")

g <- ggplot(NEI_sum, aes(year, total))
g <- g + 
  geom_point() + # Adding points
  facet_wrap( ~ type) + # Panels by type
  geom_smooth(method="lm") + # Linear model
  labs(x = "Year") + # X label
  labs(y = "Total of emissions (ton)") + # Y label
  labs(title = "Total emissions of PM2.5 in Baltimore City") # Title

print(g)
dev.off()





