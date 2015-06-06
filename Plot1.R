## ------------------------------------------------------------------------------------------- ##
## Exploratory Data Analysis -- Project 1
## Dataset: Individual household electric power consumption
## Source:  UC Irvine Machine Learning Repository (http://archive.ics.uci.edu/ml/)
##
## Plot1.R: R code to plot histogram of variable 'Global Active Power' over a period of 2-days 
##          in Februray 2007.
##          Creates and saves plot as plot1.png file.
## 
## Note:    when sourcing using a Mac OS platform, specify argument 'method=curl' in the
##          download.file() function. 
## -------------------------------------------------------------------------------------------- ##


library(utils)
library(sqldf)

## Step1: download data file to local directory
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "exdata-data-household_power_consumption.zip"

# First check if file already downloaded. Else download & save download date.
if(file.exists(zipFile)){
  msg <- sprintf("Data file: %s %s",zipFile,"*Status*: already downloaded")
  print(msg)
} else {
  print("Downloading data file ...")
  download.file(fileURL, destfile = zipFile)
  dateDownloaded <- date()
  msg <- sprintf("Download date: %s",dateDownloaded)
  print(msg)
} 


## Step2: unzip downloaded file & read dataset for Date range of interest [01/02/2007:02/02/2007].
dataFile  <- "household_power_consumption.txt"
unzip(zipFile, exdir = ".")

dataset <- read.csv.sql(dataFile, 
                        sql = "select * from file where Date in ('1/2/2007','2/2/2007')",
                        header = TRUE, sep = ";")


## Step3: generate & save Plot1 histogram as 'plot1.png' with 480 width X 480 height pixels. 
par.defaults <- par(no.readonly = TRUE)
par(cex.axis = 0.86, cex.lab = 0.86, cex.main = 0.86)

hist(dataset$Global_active_power, col = "red", main = "Global Active Power", 
                                 xlab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()


##Step last: delete Date.Time column as previously created for plotting purpose
dataset$Date.Time <- NULL
par(par.defaults)
closeAllConnections()
