# JHU 04 - Exploratory Data Analysis
# Course Project 1


# Read in data directly from the UCI website
temp <- tempfile()
download.file("http://archive.ics.uci.edu/ml/machine-learning-databases/00235/
              household_power_consumption.zip", temp)
data <- read.table(unz(temp, 'household_power_consumption.txt'), sep = ";", header = T)
unlink(temp)


# Data cleaning and format change
summary(data)
class(data$Date)
test <- data[data$Date == ";",]

name <- names(data)

newData <- lapply(1:9, function(x) {replace(z <- data[, x], z == ";", NA)})
newData <- as.data.frame(newData)
names(newData) <- name

summary(newData)
newData$Date <- as.Date(newData$Date, "%d/%m/%Y")
newData$Global_active_power <- as.numeric(as.character(newData$Global_active_power))
newData$Global_reactive_power <- as.numeric(as.character(newData$Global_reactive_power))
newData$Voltage <- as.numeric(as.character(newData$Voltage))
newData$Global_intensity <- as.numeric(as.character(newData$Global_intensity))
newData$Sub_metering_1 <- as.numeric(as.character(newData$Sub_metering_1))
newData$Sub_metering_2 <- as.numeric(as.character(newData$Sub_metering_2))
newData$Sub_metering_3 <- as.numeric(as.character(newData$Sub_metering_3))


# Take a subset of data for dates 2007-02-01 and 2007-02-02
subData <- newData[(newData$Date > "2007-01-31") & (newData$Date < "2007-02-03"), ]

# Create a new variable putting date time together
dt <- paste(subData$Date, subData$Time)
subData$DT <- as.POSIXct(dt)
str(subData)
head(subData$DT)

# Create plot 1 
png(file = "plot1.png", bg = "transparent", width = 480, height = 480, units = "px",
    type = "windows")
hist(subData$Global_active_power, xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main = "Global Active Power", col = "red")
dev.off()