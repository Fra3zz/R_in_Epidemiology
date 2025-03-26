install.packages("reticulate")
install.packages("openxlsx")

# Load necessary libraries
library(reticulate)
library(openxlsx)

# Source the Python script
source_python("truerng_seed.py")

# Get a seed from TrueRNG
seed <- get_seed_from_truerng()

# Set the seed for R's random number generator
set.seed(seed)

# Define sample size
sample_size <- 50

# Generate numerical variables using R's random number generator
infection_rate <- runif(sample_size, min = 0, max = 1)
recovery_rate <- runif(sample_size, min = 0, max = 1)
population_density <- runif(sample_size, min = 100, max = 1000)

# Generate categorical variables using R
region <- sample(c("North", "South", "East"), sample_size, replace = TRUE)
season <- sample(c("Spring", "Summer", "Autumn", "Winter"), sample_size, replace = TRUE)
health_policy <- sample(c("Strict", "Lenient"), sample_size, replace = TRUE)

# Combine into a data frame
disease_data <- data.frame(
  InfectionRate = infection_rate,
  RecoveryRate = recovery_rate,
  PopulationDensity = population_density,
  Region = region,
  Season = season,
  HealthPolicy = health_policy
)

# View the first few rows of the dataset
head(disease_data)

# Write the data to a CSV file with headers
write.csv(disease_data, file = "outbreak.csv", row.names = FALSE)

# Write the data to an Excel file
write.xlsx(disease_data, file = "outbreak.xlsx", rowNames = FALSE)
