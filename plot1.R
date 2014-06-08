file_name <- "household_power_consumption.txt"

## Find which rows of the large file should be read in
date_col <- read.table(file="household_power_consumption.txt",head=T, sep=";",
                       na.strings=";", nrow=-1, colClasses=c("character", rep("NULL",8)))
rows_in_range <- grepl("^[1-2]/2/2007",date_col[[1]])
first <- match(TRUE,rows_in_range)
total <- sum(rows_in_range)
# RESULT: first=66637, total=2880

#Input file and clean up formats
col_classes <- c("character", "character", rep("numeric",7))
mydata <- read.table(file=file_name, head=F, sep=";", 
                     na.strings="?", skip=first, nrow=total, colClasses=col_classes)
names(mydata) <- unlist(read.table(file=file_name,colClasses="character", nrows=1,sep=';'))
mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")
date_time <- paste(mydata$Date,mydata$Time)
mydata$Time <-strptime(date_time, format="%Y-%m-%d %H:%M:%S")

# Create plot 1
png(filename="plot1.png",width=480,height=480)
par(cex.lab=1, cex.axis=0.8)
hist(mydata$Global_active_power, col="RED",
     xlab="Global Active Power (kilowatts)",ylab="Frequency", main="Global Active Power")
dev.off()
