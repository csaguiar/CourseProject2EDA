require(dplyr)
require(ggplot2)

## Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- tbl_df(NEI)
SCC <- tbl_df(SCC)

## Filter SCC for coal related emissions 
SCC <- filter(SCC,grepl("vehicle",EI.Sector,ignore.case=TRUE))

## Subsetting NEI by coal related SCC
NEI <- NEI[NEI$SCC %in% SCC$SCC,]

## Filter for Baltimore City 
NEI <- filter(NEI,fips=="24510")

## Grouping table by year
NEI <- group_by(NEI,year)

## Summarizing data using group above and getting total of each group (year)
NEI_sum <- summarize(NEI,total = sum(Emissions))

## Redirecting plot output to png
png(filename = "plot5.png",width = 480, height = 480, units = "px",bg = "white")

g <- ggplot(NEI_sum, aes(year, total))
g <- g + 
  geom_point() + # Adding points
  geom_smooth(method="lm") + # Linear model
  labs(x = "Year") + # X label
  labs(y = "Total of emissions (ton)") + # Y label
  labs(title = "Emissions from motor vehicles sources in Baltimore City") # Title

print(g)
dev.off()





