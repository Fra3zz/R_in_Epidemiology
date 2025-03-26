# Install necessary packages
install.packages("ggplot2")
install.packages("dplyr")
install.packages("writexl")

# Load the libraries
library(ggplot2)
library(dplyr)
library(writexl)

# Create necessary directories
dir.create("./infection/analysis", recursive = TRUE, showWarnings = FALSE)

# Read the CSV file
data <- read.csv("./infection/data/outbreak.csv")

# Function to calculate mode
calculate_mode <- function(x) {
  uniq_x <- unique(x)
  uniq_x[which.max(tabulate(match(x, uniq_x)))]
}

# Descriptive Statistics for Numerical Variables
descriptive_stats <- data %>%
  summarise(
    InfectionRate_Mean = mean(InfectionRate),
    InfectionRate_Median = median(InfectionRate),
    InfectionRate_Mode = calculate_mode(InfectionRate),
    InfectionRate_SD = sd(InfectionRate),
    InfectionRate_Min = min(InfectionRate),
    InfectionRate_Max = max(InfectionRate),
    RecoveryRate_Mean = mean(RecoveryRate),
    RecoveryRate_Median = median(RecoveryRate),
    RecoveryRate_Mode = calculate_mode(RecoveryRate),
    RecoveryRate_SD = sd(RecoveryRate),
    RecoveryRate_Min = min(RecoveryRate),
    RecoveryRate_Max = max(RecoveryRate),
    PopulationDensity_Mean = mean(PopulationDensity),
    PopulationDensity_Median = median(PopulationDensity),
    PopulationDensity_Mode = calculate_mode(PopulationDensity),
    PopulationDensity_SD = sd(PopulationDensity),
    PopulationDensity_Min = min(PopulationDensity),
    PopulationDensity_Max = max(PopulationDensity)
  )

# Print Descriptive Statistics
print(descriptive_stats)

# Export Descriptive Statistics to CSV
write.csv(descriptive_stats, "./infection/analysis/Descriptive_Statistics.csv", row.names = FALSE)

# Export Descriptive Statistics to Excel
write_xlsx(descriptive_stats, "./infection/analysis/Descriptive_Statistics.xlsx")

# Graphical Display for a Numerical Variable: Histogram of Infection Rate
ggplot(data, aes(x = InfectionRate)) +
  geom_histogram(binwidth = 0.1, fill = "skyblue", color = "black") +
  labs(title = "Histogram of Infection Rate",
       x = "Infection Rate",
       y = "Frequency") +
  theme_minimal()

# Save the histogram
ggsave("./infection/analysis/InfectionRate_Histogram.png")

# Graphical Display for a Categorical Variable: Bar Plot of Region
ggplot(data, aes(x = Region)) +
  geom_bar(fill = "lightgreen", color = "black") +
  labs(title = "Bar Plot of Region",
       x = "Region",
       y = "Count") +
  theme_minimal()

# Save the bar plot
ggsave("./infection/analysis/Region_BarPlot.png")
