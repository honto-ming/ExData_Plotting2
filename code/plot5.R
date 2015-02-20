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
plot5<- filter(NEI, SCC %in% SCC.vehicles$SCC, fips=="24510")
plot5<- group_by(plot5, year)
plot5<- summarize(plot5, totalpm25 = sum(Emissions))
plot5<-mutate(plot5, totalpm25=totalpm25/1000)

## plot
library(ggplot2)
g <- ggplot(plot5, aes(year, totalpm25))
g + geom_bar(width=1, stat="identity", col="blue", fill="blue") + 
    scale_x_continuous(breaks=c(1999, 2002, 2005, 2008)) + xlab("Year") +
    ylab("Total PM2.5 (x1000 tons)") + 
    ggtitle("Total PM2.5\nfor Motor Vehicles\nin Baltimore City, Maryland")


# copy to png
dev.copy(png, file="./plots/plot5.png")
dev.off()
