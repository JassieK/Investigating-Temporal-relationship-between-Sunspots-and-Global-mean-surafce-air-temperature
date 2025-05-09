library(seasonal)

# Load the data set
data <- read.csv("combined_data.csv")

# Combine Year and Month into a Date column
data$Date <- as.Date(paste(data$Year, data$Month, "01", sep = "-"))

# Assuming data has 'Year' and 'Month' columns
data$Date <- as.Date(paste(data$Year, data$Month, "01", sep = "-"), format = "%Y-%m-%d")

# View the first few rows to confirm changes
head(data)

# Convert data to a time series object 
# Assuming monthly data with a start year and month
data_ts <- ts(data$No.of.Sunspots, start = c(1954, 1), frequency = 12)


temperature_ts%>% seas(x11="") -> fit
autoplot(fit) +
  ggtitle("X11 decomposition of surface temperature index")
autoplot(temperature_ts, series="Data") +
  autolayer(trendcycle(fit), series="Trend") +
  autolayer(seasadj(fit), series="Seasonally Adjusted") +
  xlab("Year") + ylab("New orders index") +
  ggtitle("Surface air temperature through years") +
  scale_colour_manual(values=c("gray","blue","red"),
                      breaks=c("Data","Seasonally Adjusted","Trend"))


# If focused on just the temperature value
temperature_ts <- ts(data$Temperature, start = c(min(data$Year)), frequency = 12)

# Decomposing the time series
decomposition <- decompose(temperature_ts)

# Plotting the decomposition
plot(decomposition)

# Plotting seasonal sub-series plot
library(ggplot2)
ggplot(data, aes(x = factor(Month), y = Temperature, group = Year, color = as.factor(Year))) +
  geom_line() +
  labs(title = "Seasonal Subseries Plot of Surface Temperature ", x = "Month", y = "Temperature in Celcius") +
  theme_minimal()

# Calculating monthly averages
monthly_avg <- aggregate(Temperature ~ Month, data, mean)

# Plotting the monthly averages
ggplot(monthly_avg, aes(x = factor(Month), y = Temperature)) +
  geom_line(group = 1) +
  geom_point() +
  labs(title = "Average Surface Temperature by Month", x = "Month", y = "Average Temperature") +
  theme_minimal()


TSI_ts %>%
  stl(t.window=11, s.window="periodic", robust=TRUE) %>%
  autoplot()

#For TSI
# If focused on just the temperature value
TSI_ts <- ts(data$Tsi, start = c(min(data$Year)), frequency = 12)

# Decomposing the time series
decomposition <- decompose(TSI_ts)

# Plotting the decomposition
plot(decomposition)

# Plotting seasonal subseries plot
library(ggplot2)
ggplot(data, aes(x = factor(Month), y = Tsi, group = Year, color = as.factor(Year))) +
  geom_line() +
  labs(title = "Seasonal Subseries Plot of Total Solar Irradiance", x = "Month", y = "Total Solar Irradiance") +
  theme_minimal()

# Calculating monthly averages
monthly_avg <- aggregate(Tsi ~ Month, data, mean)

# Plotting the monthly averages
ggplot(monthly_avg, aes(x = factor(Month), y = Tsi)) +
  geom_line(group = 1) +
  geom_point() +
  labs(title = "Average Total Solar Irradiance by Month", x = "Month", y = "Average Total solar irradiance") +
  theme_minimal()









#For Sunspots
# If focused on just the temperature value
Sunspots_ts <- ts(data$No.of.Sunspots, start = c(min(data$Year)), frequency = 12)
Sunspots_ts %>%
  stl(t.window=11, s.window="periodic", robust=TRUE) %>%
  autoplot()
# Decomposing the time series
decomposition <- decompose(Sunspots_ts)

# Plotting the decomposition
plot(decomposition)

# Plotting seasonal sub-series plot
library(ggplot2)
ggplot(data, aes(x = factor(Month), y = No.of.Sunspots, group = Year, color = as.factor(Year))) +
  geom_line() +
  labs(title = "Seasonal Subseries Plot of Number of Sunspots", x = "Month", y = "Number of Sunspots") +
  theme_minimal()

# Calculating monthly averages
monthly_avg <- aggregate(No.of.Sunspots ~ Month, data, mean)

# Plotting the monthly averages
ggplot(monthly_avg, aes(x = factor(Month), y = No.of.Sunspots)) +
  geom_line(group = 1) +
  geom_point() +
  labs(title = "Average Number of Sunspots", x = "Month", y = "Average Number of Sunspots") +
  theme_minimal()






#For Lyman Alpha
# If you focus on just the temperature value
Lyman_Alpha_ts <- ts(data$L.alpha, start = c(min(data$Year)), frequency = 12)
Lyman_Alpha_ts %>%
  stl(t.window=11, s.window="periodic", robust=TRUE) %>%
  autoplot()

# Decomposing the time series
decomposition <- decompose(Lyman_Alpha_ts)

# Plotting the decomposition
plot(decomposition)

# Plotting seasonal subseries plot
library(ggplot2)
ggplot(data, aes(x = factor(Month), y = L.alpha, group = Year, color = as.factor(Year))) +
  geom_line() +
  labs(title = "Seasonal Subseries Plot of Lyman Alpha irradiance", x = "Month", y = "Lyman Alpha irradiance") +
  theme_minimal()

# Calculating monthly averages
monthly_avg <- aggregate(L.alpha ~ Month, data, mean)

# Plotting the monthly averages
ggplot(monthly_avg, aes(x = factor(Month), y = L.alpha)) +
  geom_line(group = 1) +
  geom_point() +
  labs(title = "Average Lyman Alpha irradiance", x = "Month", y = "Lyman Alpha irradiance") +
  theme_minimal()




# Load the dplyr package
library(dplyr)

# Create lagged variables using dplyr's mutate function
data <- data %>%
  mutate(Sunspots_Lag0 = lag(No.of.Sunspots, 0),
         Sunspots_Lag1 = lag(No.of.Sunspots, 1),
         Sunspots_Lag2 = lag(No.of.Sunspots, 2),
         Sunspots_Lag3 = lag(No.of.Sunspots, 3),
         Sunspots_Lag4 = lag(No.of.Sunspots, 4),
         Sunspots_Lag370 = lag(No.of.Sunspots, 370),
         Sunspots_Lag400 = lag(No.of.Sunspots, 400),
         Sunspots_Lag50 = lag(No.of.Sunspots, 50))

# View the resulting data with lagged variables
View(data)

#Remove rows with NA values introduced by lagging
data <- na.omit(data)




#LAG ANALYSIS between sunspots and TSI 
# Create lagged variables for sunspots
data$Sunspots_Lag0 <- lag(data$No.of.Sunspots, 0)
data$Sunspots_Lag1 <- lag(data$No.of.Sunspots, 1)
data$Sunspots_Lag2 <- lag(data$No.of.Sunspots, 2)  # 2-month lag
data$Sunspots_Lag3 <- lag(data$No.of.Sunspots, 3)  # 3-month lag
data$Sunspots_Lag4 <- lag(data$No.of.Sunspots, 4)  # 4-month lag


# Correlation between lagged sunspots and TSI
cor_lag0 <- cor(data$Sunspots_Lag0, data$Tsi, use = "complete.obs")
cor_lag1 <- cor(data$Sunspots_Lag1, data$Tsi, use = "complete.obs")
cor_lag2 <- cor(data$Sunspots_Lag2, data$Tsi, use = "complete.obs")
cor_lag3 <- cor(data$Sunspots_Lag3, data$Tsi, use = "complete.obs")
cor_lag4 <- cor(data$Sunspots_Lag4, data$Tsi, use = "complete.obs")
# Repeat for other lags and for temperature if needed

# Print results
cor_lag0
cor_lag1
cor_lag2
cor_lag3
cor_lag4

# Calculate correlations for a range of lags
max_lag <- 12 #up to a 12-month lag
correlations <- sapply(1:max_lag, function(lag) cor(lag(data$No.of.Sunspots, lag), data$Tsi, use = "complete.obs"))

# Plot the correlations
plot(1:max_lag, correlations, type = "b", xlab = "Lag (months)", ylab = "Correlation with TSI",
     main = "Correlation Between Sunspots and TSI at Different Lags")








#LAG ANALYSIS between sunspots and Temperature 
# Correlation between lagged sunspots and TSI
cor_lag0 <- cor(data$Sunspots_Lag0, data$Temperature, use = "complete.obs")
cor_lag1 <- cor(data$Sunspots_Lag1, data$Temperature, use = "complete.obs")
cor_lag2 <- cor(data$Sunspots_Lag2, data$Temperature, use = "complete.obs")
cor_lag3 <- cor(data$Sunspots_Lag3, data$Temperature, use = "complete.obs")
cor_lag4 <- cor(data$Sunspots_Lag4, data$Temperature, use = "complete.obs")
cor_lag250 <- cor(data$Sunspots_Lag250, data$Temperature, use = "complete.obs")
cor_lag370 <- cor(data$Sunspots_Lag370, data$Temperature, use = "complete.obs")
cor_lag400 <- cor(data$Sunspots_Lag400, data$Temperature, use = "complete.obs")
cor_lag50 <- cor(data$Sunspots_Lag50, data$Temperature, use = "complete.obs")

# Print results
cor_lag0
cor_lag1
cor_lag2
cor_lag3
cor_lag4
cor_lag250
cor_lag370
cor_lag400


# Correlation between lagged sunspots and TSI
cor_lag1 <- cor(data$Sunspots_Lag1, data$Temperature, use = "complete.obs")
cor_lag2 <- cor(data$Sunspots_Lag2, data$Temperature, use = "complete.obs")
cor_lag3 <- cor(data$Sunspots_Lag3, data$Temperature, use = "complete.obs")

# Print results
cor_lag1
cor_lag2
cor_lag3


# Enhanced plot with a smooth curve
max_lag <- 500  # Maximum lag in months
correlations <- sapply(1:max_lag, function(lag) cor(lag(data$No.of.Sunspots, lag), data$Temperature, use = "complete.obs"))

# Use loess smoothing for a smoother curve
smoothed_curve <- loess(correlations ~ I(1:max_lag), span = 0.1)  # Adjusting the 'span' for smoothness
smoothed_values <- predict(smoothed_curve)

# Plot the smooth curve
plot(1:max_lag, smoothed_values, type = "l", col = "black", lwd = 3,
     xlab = "Lag (months)", ylab = "Correlation with GMSAT", 
     main = "Correlation Between Sunspots and GMSAT at Different Lags",
     cex.main = 1.7, cex.lab = 1.4, cex.axis = 1.3)

# Add grid for visual clarity
grid()
# Adding larger and bolder axis ticks
axis(1, at = seq(0, max_lag, by = 100), labels = seq(0, max_lag, by=100), cex.axis = 1.3, font = 2)
axis(2, cex.axis = 1.3, font = 2)


#LAG ANALYSIS between sunspots and Lyman Alpha
# Calculate correlations for a range of lags
max_lag <- 12 #
correlations <- sapply(1:max_lag, function(lag) cor(lag(data$No.of.Sunspots, lag), data$L.alpha, use = "complete.obs"))

# Plot the correlations
plot(1:max_lag, correlations, type = "b", xlab = "Lag (months)", ylab = "Correlation with Temperature",
     main = "Correlation Between Sunspots and Lyman Alpha at Different Lags")



# Lag analysis between Temperature and TSI
max_lag <- 800  # Maximum lag in months
correlations <- sapply(1:max_lag, function(lag) cor(lag(data$Temperature, lag), data$Tsi, use = "complete.obs"))

# Use loess smoothing for a smoother curve
smoothed_curve <- loess(correlations ~ I(1:max_lag), span = 0.1)  # Adjust the 'span' for smoothness
smoothed_values <- predict(smoothed_curve)

# Plot the smooth curve with enhanced aesthetics
plot(1:max_lag, smoothed_values, type = "l", col = "black", lwd = 3,
     xlab = "Lag (months)", ylab = "Correlation with GMSAT", 
     main = "Correlation Between GMSAT and TSI at Different Lags",
     cex.main = 1.7, cex.lab = 1.4, cex.axis = 1.3)

# Add grid lines for better readability
grid()

# Adding larger and bolder axis ticks
axis(1, at = seq(0, max_lag, by = 100), labels = seq(0, max_lag, by=100), cex.axis = 1.3, font = 2)
axis(2, cex.axis = 1.3, font = 2)




# Load the dplyr package
library(dplyr)

# Create lagged variables for TSI
data <- data %>%
  mutate(TSI_Lag0 = lag(Tsi, 0),
         TSI_Lag1 = lag(Tsi, 1),
         TSI_Lag2 = lag(Tsi, 2),
         TSI_Lag3 = lag(Tsi, 3),
         TSI_Lag4 = lag(Tsi, 4))

# View the resulting data with lagged TSI variables
View(data)
# Calculate correlations
cor_TSI_Lag0 <- cor(data$Temperature, data$TSI_Lag0, use = "complete.obs")
cor_TSI_Lag1 <- cor(data$Temperature, data$TSI_Lag1, use = "complete.obs")
cor_TSI_Lag2 <- cor(data$Temperature, data$TSI_Lag2, use = "complete.obs")
cor_TSI_Lag3 <- cor(data$Temperature, data$TSI_Lag3, use = "complete.obs")
cor_TSI_Lag4 <- cor(data$Temperature, data$TSI_Lag4, use = "complete.obs")

# Display the correlations
correlations <- data.frame(
  Lag = 0:4,
  Correlation = c(cor_TSI_Lag0, cor_TSI_Lag1, cor_TSI_Lag2, cor_TSI_Lag3, cor_TSI_Lag4)
)

print(correlations)



#LAG ANALYSIS between Temperature and Lyman Alpha
# Calculate correlations for a range of lags
max_lag <- 828 # For example, up to a 12-month lag
correlations <- sapply(1:max_lag, function(lag) cor(lag(data$Temp_Celsius, lag), data$Lyman_Alpha, use = "complete.obs"))

# Plot the correlations
plot(1:max_lag, correlations, type = "b", xlab = "Lag (months)", ylab = "Correlation with Temperature",
     main = "Correlation Between Temperature and Lyman Alpha at Different Lags")


library(vars)

# Create a data frame with the relevant variables
var_data1 <- data[, c("No.of.Sunspots", "Tsi","Temperature")]
var_data1 = na.omit(var_data1)
var_data1 <- var_data1[328:843, ]

# Determine the optimal lag length
lag_selection <- VARselect(var_data1, lag.max = 15, type = "const")

# View the selection criteria
print(lag_selection)

# Fit a VAR model
model_1 <- VAR(var_data1, p = 13)  

# Summary of the model
summary(model_1)

# Forecasting using the VAR model
forecast_var <- predict(model_1, n.ahead = 12)  # Forecast next 12 months
plot(forecast_var)


# Create a data frame with the relevant variables
var_data2 <- data[, c("Sunspots_Lag370", "Tsi","Temperature")]
var_data2 = na.omit(var_data2)

# Determine the optimal lag length
lag_selection <- VARselect(var_data2, lag.max = 15, type = "const")

# View the selection criteria
print(lag_selection)

# Fit a VAR model
model_2 <- VAR(var_data2, p = 6) 

# Summary of the model
summary(model_2)






# Extract AIC and BIC for each model
aic_model1 <- AIC(model_1)
bic_model1 <- BIC(model_1)

aic_model2 <- AIC(model_2)
bic_model2 <- BIC(model_2)

aic_model3 <- AIC(model_3)
bic_model3 <- BIC(model_3)

# Compare the AIC and BIC values
print(data.frame(Model = c("Model 1", "Model 2", "Model 3"),
                 AIC = c(aic_model1, aic_model2, aic_model3),
                 BIC = c(bic_model1, bic_model2, bic_model3)))









# Perform spectral analysis for TSI
tsi_ts <- ts(data$Tsi, start = c(1954, 1), frequency = 12)
spec.pgram(tsi_ts, taper = 0.1, log = "no", 
           main = "Spectral Analysis of TSI", 
           xlab = "Frequency", ylab = "Spectral Density")

# Perform spectral analysis for Sunspots
sunspots_ts <- ts(data$No.of.Sunspots, start = c(1954, 1), frequency = 12)
spec.pgram(sunspots_ts, taper = 0.1, log = "no", 
           main = "Spectral Analysis of Sunspots", 
           xlab = "Frequency", ylab = "Spectral Density")

# Perform spectral analysis for GMSAT (Temperature)
temp_ts <- ts(data$Temperature, start = c(1954, 1), frequency = 12)
spec.pgram(temp_ts, taper = 0.1, log = "no", 
           main = "Spectral Analysis of GMSAT", 
           xlab = "Frequency", ylab = "Spectral Density")

# Perform spectral analysis for Lyman-alpha
Lyman_ts <- ts(data$L.alpha, start = c(1954, 1), frequency = 12)
spec.pgram(Lyman_ts, taper = 0.1, log = "no", 
           main = "Spectral Analysis of Lyman-alpha", 
           xlab = "Frequency", ylab = "Spectral Density")

# Reset graphical parameters to default after plotting
par(mfrow = c(1, 1))


# Load the dataset
grf_data <- read.csv("GRF.csv")
head(grf_data)


# Load necessary libraries
library(tidyverse)
library(forecast)
library(tseries)
library(ggplot2)
# Min-Max scaling for Temperature and Total
combined_data$Temperature_scaled <- (combined_data$Temperature - min(combined_data$Temperature)) / 
  (max(combined_data$Temperature) - min(combined_data$Temperature))
combined_data$Total_scaled <- (combined_data$Total - min(combined_data$Total)) / 
  (max(combined_data$Total) - min(combined_data$Total))

# Plot the min-max scaled data
ggplot(combined_data, aes(x = Date)) +
  geom_line(aes(y = Temperature_scaled, color = "GMSAT"), size = 1) +  # Scaled Temperature line
  geom_line(aes(y = Total_scaled, color = "GRF"), size = 1) +  # Scaled Total line
  labs(title = "GMSAT and Total GRF Over Time", 
       x = "Year", 
       y = "Scaled Values (0-1)") +
  theme_minimal(base_size = 15) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),  # Center the title
    axis.title.y = element_text(face = "bold")
  ) +
  scale_color_manual(values = c("GMSAT" = "pink2", "GRF" = "red3")) +  # Line colors
  theme(legend.title = element_blank())  # Remove legend title
library(vars)

# Create a data frame with the relevant variables including the "Total" column from GRF data
var_data4 <- combined_data[, c("No.of.Sunspots", "Tsi", "Temperature", "Total")]
var_data4 <- na.omit(var_data4)
# Determine the optimal lag length for the new model
lag_selection <- VARselect(var_data4, lag.max = 15, type = "const")

# View the selection criteria
print(lag_selection)

# The optimal lag order (p) according to AIC, BIC, HQIC, etc.
optimal_lag <- lag_selection$selection
print(optimal_lag)

# Fit the new VAR model with the "Total" variable included
model4 <- VAR(var_data4, p = 13)

# Summary of the new model
summary(model4)

aic_model1 <- AIC(model_1)
bic_model1 <- BIC(model_1)

aic_model2 <- AIC(model_2)
bic_model2 <- BIC(model_2)

aic_model4 <- AIC(model4)
bic_model4 <- BIC(model4)

print(aic_model1)
print(bic_model1)


print(aic_model4)
print(bic_model4)

forecast_var <- predict(model4, n.ahead = 12)  # Forecast next 12 months
plot(forecast_var)







# Load necessary libraries
library(forecast)

# Convert relevant columns to a numeric matrix
xreg_without_grf <- as.matrix(combined_data[, c("Tsi", "No.of.Sunspots", "Sunspots_Lag1", "Sunspots_Lag2", "Sunspots_Lag3")])
xreg_with_grf <- as.matrix(combined_data[, c("Tsi", "No.of.Sunspots", "Sunspots_Lag1", "Sunspots_Lag2", "Sunspots_Lag3", "Total")])

# Model 1: ARIMA model without GRF
model_without_grf <- auto.arima(combined_data$Temperature, xreg = xreg_without_grf)

# Model 2: ARIMA model with GRF
model_with_grf <- auto.arima(combined_data$Temperature, xreg = xreg_with_grf)

# Compare AIC values
aic_without_grf <- AIC(model_without_grf)
aic_with_grf <- AIC(model_with_grf)

# Print the AIC values
cat("AIC without GRF:", aic_without_grf, "\n")
cat("AIC with GRF:", aic_with_grf, "\n")





# Perform Fourier Transform on pre-whitened temperature residuals
fft_temp <- fft(resi_temp)
n_temp <- length(fft_temp)

# Perform Fourier Transform on pre-whitened TSI residuals
fft_tsi <- fft(resi_tsi)
n_tsi <- length(fft_tsi)

# Compute the frequency vector (frequencies corresponding to the Fourier coefficients)
freq_temp <- (0:(n_temp-1)) / n_temp
freq_tsi <- (0:(n_tsi-1)) / n_tsi

# Compute the amplitude (magnitude) of the Fourier coefficients
amp_temp <- Mod(fft_temp) / n_temp
amp_tsi <- Mod(fft_tsi) / n_tsi

# Plot the amplitude spectrum for Temperature
plot(freq_temp[1:(n_temp/2)], amp_temp[1:(n_temp/2)], type = "l", col = "blue",
     xlab = "Frequency", ylab = "Amplitude", main = "Fourier Amplitude Spectrum - Temperature")

# Plot the amplitude spectrum for TSI
plot(freq_tsi[1:(n_tsi/2)], amp_tsi[1:(n_tsi/2)], type = "l", col = "red",
     xlab = "Frequency", ylab = "Amplitude", main = "Fourier Amplitude Spectrum - TSI")

# Optionally, you can overlay both spectra for comparison
plot(freq_temp[1:(n_temp/2)], amp_temp[1:(n_temp/2)], type = "l", col = "blue",
     xlab = "Frequency", ylab = "Amplitude", main = "Fourier Amplitude Spectrum - Temperature and TSI")
lines(freq_tsi[1:(n_tsi/2)], amp_tsi[1:(n_tsi/2)], col = "red")
legend("topright", legend = c("Temperature", "TSI"), col = c("blue", "red"), lty = 1)




