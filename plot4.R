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



###4 
plot4 <- function() {
  par(mfrow=c(2,2))
  
  ##PLOT 1
  plot(pwRange$timestamp,pwRange$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  ##PLOT 2
  plot(pwRange$timestamp,pwRange$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  ##PLOT 3
  plot(pwRange$timestamp,pwRange$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(pwRange$timestamp,pwRange$Sub_metering_2,col="red")
  lines(pwRange$timestamp,pwRange$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub Metering 1  ","Sub Metering 2  ", "Sub Metering 3  "),lty=c(1,1), bty="n", cex=.5) 
  
  
  #PLOT 4
  plot(pwRange$timestamp,pwRange$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  #OUTPUT
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
  cat("plot4.png has been saved:", getwd())
}
plot4()