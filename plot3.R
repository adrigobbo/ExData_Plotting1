## Find a file in path
if(file.exists("data/household_power_consumption.txt")) {
  print('File Missing!')
}


##Get File
pwFile = 'data/household_power_consumption.txt'
pw <- read.table(pwFile, header=T, sep=";")

#Get Date
pw$Date <- as.Date(pw$Date, format="%d/%m/%Y")

#Get Range
pwRange <- pw[(pw$Date=="2007-02-01") | (pw$Date=="2007-02-02"),]

#Get Active Power
pwRange$Global_active_power <- as.numeric(as.character(pwRange$Global_active_power))

#Get Reactive Power
pwRange$Global_reactive_power <- as.numeric(as.character(pwRange$Global_reactive_power))

#Get Voltage
pwRange$Voltage <- as.numeric(as.character(pwRange$Voltage))

#Transforme date - Brazilian DateTime
pwRange <- transform(pwRange, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

#Get Metrics
pwRange$Sub_metering_1 <- as.numeric(as.character(pwRange$Sub_metering_1))
pwRange$Sub_metering_2 <- as.numeric(as.character(pwRange$Sub_metering_2))
pwRange$Sub_metering_3 <- as.numeric(as.character(pwRange$Sub_metering_3))


### Plot 3
plot3 <- function() {
  plot(pwRange$timestamp,pwRange$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(pwRange$timestamp,pwRange$Sub_metering_2,col="red")
  lines(pwRange$timestamp,pwRange$Sub_metering_3,col="blue")
  legend("topright", col=c("red","blue","black"), c("Sub Metering 1  ","Sub Metering 2  ", "Sub Metering 3  "),lty=c(1,1), lwd=c(1,1))
  dev.copy(png, file="plot3.png", width=480, height=480)
  dev.off()
  cat("plot3.png has been saved:", getwd())
}
plot3()