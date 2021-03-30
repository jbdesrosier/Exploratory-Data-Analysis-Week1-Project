

library(dplyr)
library(lubridate)

electricity_consumption <- as_tibble(read.csv2("household_power_consumption.txt",
                        header=T)) 

electricity_consumption$Date <- dmy(electricity_consumption$Date)
electricity_consumption$Time <- hms(electricity_consumption$Time)

cols.num <- c("Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity",
              "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
electricity_consumption[cols.num] <- sapply(electricity_consumption[cols.num],as.numeric)

subset <- electricity_consumption[electricity_consumption$Date >= "2007-02-01" & 
                                   electricity_consumption$Date <= "2007-02-02",]

png("plot1.png", width=480, height=480)
hist(subset$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")
dev.off()