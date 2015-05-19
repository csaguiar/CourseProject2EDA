require(dplyr)

## Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- tbl_df(NEI)
SCC <- tbl_df(SCC)
## Grouping table by year
NEI <- group_by(NEI,year)

## Summarizing data using group above and getting total of each group (year)
NEI_sum <- summarize(NEI,total = sum(Emissions))

## Linear model 
model <- lm(NEI_sum$total ~ NEI_sum$year)

## Redirecting plot output to png
png(filename = "plot1.png",width = 480, height = 480, units = "px",bg = "white")
with(NEI_sum, {
  ## Plottting points of each year
  plot(year,total,
       ylab="Total of emissions (ton)",
       xlab="Year",
       col="red",
       main="Total emissions of PM2.5 in United States",
       pch = 16)
  ## Adding a line through all points
  lines(year,total,
        col="red",
        lwd=3)
  ## Adding a linear model showing emissions tendency
  abline(model,lty="dashed")
})
dev.off()





