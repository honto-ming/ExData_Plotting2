## download the data file
download.PM25 <- function(sourceUrl) {
    ## Create download directory if it doesn't exist
    if(!file.exists("./downloads")) { dir.create("./downloads/") }
    ## download & unzip the file
    download.file(sourceUrl, destfile="./downloads/data.zip", method ="curl")
    
    ## Create download directory if it doesn't exist
    if(!file.exists("./data")) { dir.create("./data/") }
    ## unzip the file
    unzip("./downloads/data.zip", exdir="./data/")
}