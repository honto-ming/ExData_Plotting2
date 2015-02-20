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

## Group data
plot1<- group_by(NEI, year)
plot1<- summarize(plot1, totalpm25 = sum(Emissions))
plot1<- mutate(plot1, totalpm25=totalpm25/1000)

## plot
par(mar=c(4.5,4.5,4.5,4.5))
with(plot1, {
    barplot(totalpm25, names.arg=year, xlab="Year", ylab="Total PM2.5 (x1000 tons)",
            main="Total PM2.5 in USA", col="blue",
            space=c(2,2,2), axis.lty=1)
})
    
# copy to png
dev.copy(png, file="./plots/plot1.png")
dev.off()
