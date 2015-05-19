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

## Filter for Baltimore City or Los Angeles County
NEI <- filter(NEI,fips=="24510" | fips=="06037")

## Grouping table by year
NEI <- group_by(NEI,year,fips)

## Summarizing data using group above and getting total of each group (year)
NEI_sum <- summarize(NEI,total = sum(Emissions))

## Changing code to name
NEI_sum[which(NEI_sum$fips=="24510"),"fips"] <- "Baltimore"
NEI_sum[which(NEI_sum$fips=="06037"),"fips"] <- "Los Angeles"

## Redirecting plot output to png
png(filename = "plot6.png",width = 480, height = 480, units = "px",bg = "white")

g <- ggplot(NEI_sum, aes(year, total))
g <- g + 
  geom_point(aes(color=fips)) + # Adding points
  geom_line(aes(color=fips)) +
  labs(x = "Year") + # X label
  labs(y = "Total of emissions (ton)") + # Y label
  labs(title = "Emissions from motor vehicles sources") + # Title
  theme(legend.title=element_blank()) 
  

print(g)
dev.off()





