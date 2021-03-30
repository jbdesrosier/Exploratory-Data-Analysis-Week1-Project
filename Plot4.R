

library(dplyr)
library(lubridate)

electricity_consumption <- as_tibble(read.csv2("household_power_consumption.txt",
                                               header=T)) 


electricity_consumption$datetime <- as.POSIXct(paste(electricity_consumption$Date, electricity_consumption$Time),
                                               format="%d/%m/%Y %H:%M:%S")
electricity_consumption$Date <- dmy(electricity_consumption$Date)
electricity_consumption$Time <- hms(electricity_consumption$Time)

cols.num <- c("Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity",
              "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
electricity_consumption[cols.num] <- sapply(electricity_consumption[cols.num],as.numeric)

subset <- electricity_consumption[electricity_consumption$Date >= "2007-02-01" & 
                                    electricity_consumption$Date <= "2007-02-02",]

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subset, {
  plot(Global_active_power~datetime,
       type='l', ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~datetime, type='l',
       ylab="Voltage (volts)", xlab='')
  plot(Sub_metering_1~datetime, type='l',
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~datetime, col='Red')
  lines(Sub_metering_3~datetime, col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~datetime, type='l',
       ylab="Global Rective Power (Kilowatts)", xlab='')
})
dev.off()