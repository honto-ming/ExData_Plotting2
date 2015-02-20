# ExData_Plotting2
Course Project 2 for Coursera Getting and Cleaning Data - PM2.5 data

## Scripts
* download.R: Contains the script to download and unzip the raw data found at: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
    + Contains the download.PM25(url) function. This function will create a "./download" directory if it doesn't exist and then download the source file supplied by url to the directory, and rename it "data.zip". It will then create a "./data" directory if it doesn't exist and unzip the contents of the source file to this directory
* plotN.R (N = 1-6): There are 6 R script files that produce 6 plots answering the following questions, respectively:
    1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
    2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
    3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
    4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
    5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
    6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
    


    





