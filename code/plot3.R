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
## convert chrs to factors 
NEI<- mutate(NEI, fips = as.factor(NEI$fips))
NEI<- mutate(NEI, SCC = as.factor(NEI$SCC))
NEI<- mutate(NEI, Pollutant = as.factor(NEI$Pollutant))
NEI<- mutate(NEI, type = as.factor(NEI$type))

## group data
plot3<-filter(NEI, fips=="24510")
plot3<- group_by(plot3, type, year)
plot3<- summarize(plot3, totalpm25 = sum(Emissions))

## plot
library(ggplot2)
g <- ggplot(plot3, aes(year, totalpm25, col=type, fill=type))
g + geom_bar(width=1, stat="identity") + 
    facet_grid(. ~ type) + scale_x_continuous(breaks=c(1999,2002,2005,2008)) + 
    xlab("Year") + ylab("Total PM2.5 (tons)") + 
    theme(axis.text.x=element_text(angle=45, hjust=1)) +
    ggtitle("Total PM2.5 by type of source\n for Baltimore City, Maryland")


# copy to png
dev.copy(png, file="./plots/plot3.png", width=720, height=480)
dev.off()
