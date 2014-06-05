# read source data file
powerData <- read.table("data\\household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", colClasses=c("character", "character", "numeric", "numeric","numeric","numeric","numeric","numeric","numeric") )

# convert date and time strings to a single POSIXct field
powerData <- cbind(strptime(paste(powerData$Date, powerData$Time), "%d/%m/%Y %H:%M:%S"), powerData[,c(3,4,5,6,7,8,9)])
names(powerData)[1] <- "DateTime"

# extract data only for 2007-02-01 and 2007-02-02
smallPowerData <- subset(powerData, DateTime >= as.POSIXct('2007-02-01 00:00') & DateTime <=  as.POSIXct('2007-02-02 23:59') )

# free memory for unused larger dataset
rm(powerData)

# draw histogram as specified to screen
hist(smallPowerData$Global_active_power, main= "Global Active Power", col="red", xlab= "Global Active Power (kilowatts)")

# copy histogram to png device and close file
dev.copy(png, "plot1.png", width=480, height=480)
dev.off()