# Input file and clean up formats
file_name <- "household_power_consumption.txt"
mydata <- read.table(file=file_name, head=F, sep=";", 
                     na.strings="?", skip=66637, nrow=2880,
                     colClasses=c("character", "character", rep("numeric",7)))

names(mydata) <- unlist(read.table(file=file_name,colClasses="character", nrows=1,sep=';'))
mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")
date_time <- paste(mydata$Date,mydata$Time)
mydata$Time <-strptime(date_time, format="%Y-%m-%d %H:%M:%S")

# Create plot2
png(filename="plot2.png",width=480,height=480)
#par(cex.lab=1, cex.axis=0.8)
plot(mydata$Time,mydata$Global_active_power,type="l",
     xlab="",ylab="Global Active Power(kilowatts)")
dev.off()
