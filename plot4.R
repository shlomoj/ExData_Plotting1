# Input file and clean up forats
file_name <- "household_power_consumption.txt"
col_classes <- c("character", "character", rep("numeric",7))
mydata <- read.table(file=file_name, head=F, sep=";", 
                     na.strings="?", skip=66637, nrow=2880, colClasses=col_classes)
names(mydata) <- unlist(read.table(file=file_name,colClasses="character", nrows=1,sep=';'))
mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")
date_time <- paste(mydata$Date,mydata$Time)
mydata$Time <-strptime(date_time, format="%Y-%m-%d %H:%M:%S")

# Create 4 plots

png(filename="plot4.png",width=480,height=480)
#par(cex.lab=1, cex.axis=0.8)
par(mfcol=c(2,2))
## plot 1
plot(mydata$Time,mydata$Global_active_power,type="l",
     xlab="",ylab="Global Active Power(kilowatts)")
#plot 2 
with(mydata,plot(Time, Sub_metering_1, type="l",ylab="Energy sub metering",xlab=""))
with(mydata,lines(Time,Sub_metering_2,col="Red"))
with(mydata,lines(Time,Sub_metering_3,col="Blue"))
legend("topright",lty=c(1,1),col=c("Black","Red","Blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n")
# plot 3
with(mydata, plot(Time,Voltage, type="l", xlab="datetime"))

# plot4
with(mydata, plot(Time, Global_reactive_power, type="l",xlab="datetime"))
dev.off()
