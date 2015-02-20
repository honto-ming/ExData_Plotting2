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

## Looks like the SCC table is already in factors.However, we need to look for
## all coal-combustion related emissions. After some research, I have found  
## a description of what each level of the SCC represents (see page 2 of the
## following doc: http://www.state.nj.us/dep/aqm/es/scc.pdf). From that document, 
## it seems that SCC Level 3 is the best descriptor to use. 
## 
## Hence, I have decided to filter the SCC table by the following criteria for
## SCC Level 3:
## contains "coal" 
## AND NOT contains "charcoal" 
## AND NOT contains "coal mining"
## AND NOT contains "coal bed"
SCC.coal<- filter(SCC, grepl("coal", SCC$SCC.Level.Three, ignore.case=TRUE)&
                 !grepl("charcoal", SCC$SCC.Level.Three, ignore.case=TRUE)&
                 !grepl("coal mining", SCC$SCC.Level.Three, ignore.case=TRUE)&
                 !grepl("coal bed", SCC$SCC.Level.Three, ignore.case=TRUE))
SCC.coal<-select(SCC.coal, SCC)

## group data
plot4<- filter(NEI, SCC %in% SCC.coal$SCC)
plot4<- group_by(plot4, year)
plot4<- summarize(plot4, totalpm25 = sum(Emissions))
plot4<- mutate(plot4, totalpm25=totalpm25/1000)

## plot
library(ggplot2)
g <- ggplot(plot4, aes(year, totalpm25))
g + geom_bar(width=1, stat="identity", col="blue", fill="blue") + 
    scale_x_continuous(breaks=c(1999, 2002, 2005, 2008)) + xlab("Year") +
    ylab("Total PM2.5 (x1000 tons)") + ggtitle("Total Coal PM2.5\nfor USA")


# copy to png
dev.copy(png, file="./plots/plot4.png", width=720, height=480)
dev.off()
