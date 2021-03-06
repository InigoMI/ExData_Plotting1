# RAM Required Estimation:
# 2,075,259 � 9 columns � 8 bytes/numeric = 149,418,648 bytes / 2^20 bytes/MB = 142.50 MB
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

# Plot Histogram
png(file = "plot1.png")
hist(Filtered_HPC$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)" )
dev.off()
