# read source data file
powerData <- read.table("data\\household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", colClasses=c("character", "character", "numeric", "numeric","numeric","numeric","numeric","numeric","numeric") )

# convert date and time strings to a single POSIXct field
powerData <- cbind(strptime(paste(powerData$Date, powerData$Time), "%d/%m/%Y %H:%M:%S"), powerData[,c(3,4,5,6,7,8,9)])
names(powerData)[1] <- "DateTime"

# extract data only for 2007-02-01 and 2007-02-02
smallPowerData <- subset(powerData, DateTime >= as.POSIXct('2007-02-01 00:00') & DateTime <=  as.POSIXct('2007-02-02 23:59') )

# free memory for unused larger dataset
rm(powerData)

# output as png initially in this case because dev.copy doesn't handle scaling appropriately
png("plot3.png", width=480, height=480)

# draw line plot as specified
plot(smallPowerData$Sub_metering_1 ~ smallPowerData$DateTime, type="l", ylab="Energy sub metering", xlab="")
lines(smallPowerData$Sub_metering_2 ~ smallPowerData$DateTime, type="s", col="red")
lines(smallPowerData$Sub_metering_3 ~ smallPowerData$DateTime, type="s", col="blue")

legend("topright", lwd=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# close file
dev.off()