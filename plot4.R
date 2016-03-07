#Course Project 1
#Plot 4
#Download the dataset
if(!file.exists("cp1d1.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}
dateDownloadedcp1d1 <- date()
#create the variables to use
gap <- read.table(file, header=T, sep=";")
gap$Date <- as.Date(gap$Date, format="%d/%m/%Y")
df <- gap[(gap$Date=="2007-02-01") | (gap$Date=="2007-02-02"),]
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

#Create plots one by one
plot1f <- function(x,title){
  hist(x,main=title,col="red", xlab="Global Active Power (kilowatts)")
}
plot2f <- function(x,y){
  plot(x,y, type="l", xlab="", ylab="Global Active Power (kilowatts)")
}
plot3f <- function(x,y1,y2,y3){
  plot(x,y1,type="l", xlab="", ylab="Energy sub metering")
  lines(x,y2,col="red")
  lines(x,y3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
}
plot4 <- function(x,y){
  plot(x,y, type="l", xlab="datetime", ylab="Global_reactive_power")
}

plotfinal <- function(){
  par(mfrow=c(2,2))
  plot1f(df$Global_active_power, "Global Active Power")
  plot2f(df$timestamp, df$Global_active_power)
  plot3f(df$timestamp, df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3)
  plot4(df$timestamp, df$Global_reactive_power)
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
  cat("File saved in ", getwd())
}
plotfinal()
