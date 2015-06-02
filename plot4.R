# RAM Required Estimation:
# 2,075,259 × 9 columns × 8 bytes/numeric = 149,418,648 bytes / 2^20 bytes/MB = 142.50 MB
# checked with pryr::object_size = 133 MB; mem_used = 152 MB

# Read five lines to calculate classes to accelerate the read.table execution 
Initial_HPC <- read.table("household_power_consumption.txt", header = TRUE, nrows = 5, sep = ";", na.strings = "?")
Field_Classes <- sapply(Initial_HPC, class)

HPC <- read.table("household_power_consumption.txt", header = TRUE, colClasses = Field_Classes, sep = ";", na.strings = "?")
Filtered_HPC = HPC[HPC$Date %in% c("1/2/2007","2/2/2007"),]
rm(HPC)

# Alternatively in case of RAM problems: 
# comment the previuos 5 lines and load only the required data using the next 2 lines    
# library(sqldf)
# Filtered_HPC <- read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";", sql = "select * from file where Date in ('1/2/2007','2/2/2007')") 

x_axis = strptime(paste(Filtered_HPC$Date,Filtered_HPC$Time), format ="%d/%m/%Y %H:%M:%S")
png(file = "plot4.png")

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 1, 0))
#Graph 1
plot(x_axis, Filtered_HPC$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", col = "black")
#Graph 2
plot(x_axis, Filtered_HPC$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", col = "black")

#Graph 3
plot(x_axis, Filtered_HPC$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering" )
par(new=TRUE)
points(x_axis, Filtered_HPC$Sub_metering_2, type = "l", col = "red")
points(x_axis, Filtered_HPC$Sub_metering_3, type = "l", col = "blue")
legend("topright",
       pch = c(NA, NA, NA),
       col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1),
       bty = "n"
       )

#Graph 4
plot(x_axis, Filtered_HPC$Global_reactive_power, type = "l", col = "black", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
