require(dplyr)
require(ggplot2)

## Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- tbl_df(NEI)
SCC <- tbl_df(SCC)

## Filter SCC for coal related emissions 
SCC$Short.Name <- tolower(SCC$Short.Name)
SCC <- filter(SCC,grepl("coal",Short.Name))

## Subsetting NEI by coal related SCC
NEI <- NEI[NEI$SCC %in% SCC$SCC,]

## Grouping table by year
NEI <- group_by(NEI,year)

## Summarizing data using group above and getting total of each group (year)
NEI_sum <- summarize(NEI,total = sum(Emissions))

## Redirecting plot output to png
png(filename = "plot4.png",width = 480, height = 480, units = "px",bg = "white")

g <- ggplot(NEI_sum, aes(year, total))
g <- g + 
  geom_point() + # Adding points
  geom_smooth(method="lm") + # Linear model
  labs(x = "Year") + # X label
  labs(y = "Total of emissions (ton)") + # Y label
  labs(title = "Coal combustion-related sources in United States") # Title

print(g)
dev.off()





