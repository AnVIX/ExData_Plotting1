## ------------------------------------------------------------------------------------------- ##
## Exploratory Data Analysis -- Project 1
## Dataset: Individual household electric power consumption
## Source:  UC Irvine Machine Learning Repository (http://archive.ics.uci.edu/ml/)
##
## Plot2.R: R code to plot variable 'Global Active Power' as function of a continous date-time 
##          variable for a period of 2-days in Februray 2007.
##          Creates and saves plot as plot2.png file.
##
## Note:    when sourcing using a Mac OS platform, specify argument 'method=curl' in the
##          download.file() function. 
## -------------------------------------------------------------------------------------------- ##


library(utils)
library(sqldf)
library(lubridate)

## Step1: download data file to local directory.
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


## Step3: combine Date & Time data columns/variables into a new single column/variable Date.Time
#         then convert Date.Time to a POSIXct date-time object.
dataset$Date.Time <- paste(dataset$Date,dataset$Time) 
dataset$Date.Time <- parse_date_time(dataset$Date.Time,orders="%d/%m/%Y %H:%M:%S")


## Step4: generate & save Plot2 as 'plot2.png' with 480 width X 480 height pixels. 
par.defaults <- par(no.readonly=TRUE)
par(bg = "transparent", cex.axis = 0.86, cex.lab = 0.86)

plot(x = dataset$Date.Time, y = dataset$Global_active_power, 
         xlab = "", ylab = "Global Active Power (kilowatts)", type="l")
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()


#Step last: delete Date.Time column as previously created for plotting purpose.
dataset$Date.Time <- NULL
par(par.defaults)
closeAllConnections()









