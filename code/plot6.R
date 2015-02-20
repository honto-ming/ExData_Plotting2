## Please set the working directory to the top level directory from the git clone.
## This should be the ExData_Plotting2 directory
setwd("/home/honto/Coursera/Exploratory_Data_Analysis/Asn2/ExData_Plotting2/")
## downlaod the file
source("./code/download.R")
download.PM25("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip")

## Assuming you have downloaded and unzipped the contents of the data file into
## a subdiretcory named "data" under your working directory.
## read into data frames
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Load dplyr
library(dplyr)

## convert chrs to factors in NEI
NEI<- mutate(NEI, fips = as.factor(NEI$fips))
NEI<- mutate(NEI, SCC = as.factor(NEI$SCC))
NEI<- mutate(NEI, Pollutant = as.factor(NEI$Pollutant))
NEI<- mutate(NEI, type = as.factor(NEI$type))

## Looks like the SCC table is already in factors. However, we need to look for
## all vehicle emissions. I am making the assumption that they include all 
## vehicles legally allowed onroad since road vehicles represent the majority of
## pollution
## 
## Hence, I have decided to filter the SCC table by Data.Category = Onroad
SCC.vehicles<-filter(SCC, Data.Category=="Onroad")
SCC.vehicles<-select(SCC.vehicles, SCC)

## group data
plot6<- filter(NEI, SCC %in% SCC.vehicles$SCC, fips%in%c("24510","06037"))
plot6<- group_by(plot6, fips, year)
plot6<- summarize(plot6, totalpm25 = sum(Emissions))
plot6<-mutate(plot6, totalpm25=totalpm25/1000)

## plot
library(ggplot2)
## For this plot, we'd like to have both counties' data on one plot rather than
## using facets to facilitate easy comparison. Both color and shape will
## be used to distinguish data between counties
g <- ggplot(plot6, aes(year, totalpm25, color=fips, shape=fips))
## will use a point and line graph to depict the PM2.5 levels AND how dramatic 
## the change is between time periods (steeper the line, more dramatic the 
## change).
g <- g + geom_point(size=3) + geom_line()
## Also will use a regression line to depict the general trend of change in 
## PM2.5 for the time periods provided
g <- g + geom_smooth(method=lm,se=FALSE, size=0.5, col="black", linetype=2)
## set axes, labels, legends
g <- g + scale_x_continuous(breaks=c(1999, 2002, 2005, 2008)) + xlab("Year") +
    ylab("Total PM2.5 (x1000 tons)") + 
    ggtitle("Total PM2.5 for\nBaltimore City, Maryland and\nL.A. County, California") + 
    scale_color_discrete(name="Counties", breaks=c("06037", "24510"), 
                         labels=c("LA County", "Baltimore")) +
    scale_shape_discrete(name="Counties", breaks=c("06037", "24510"), 
                         labels=c("LA County", "Baltimore"))
print(g)

## copy to png
dev.copy(png, file="./plots/plot6.png")
dev.off()
