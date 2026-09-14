# Set the number of rows
num_rows <- 80

set.seed(0)
# Create data frame
df <- data.frame(
  Training = sample(c("Applebee","Money"), num_rows,replace = TRUE),
  Gender = sample(c("Male","Female"), num_rows,replace = TRUE),
  Pass = sample(c("Yes", "No"), num_rows, replace = TRUE)
)

# Print the data frame
print(df)

str(df)

table(df$Training)
df$Training <- as.factor(df$Training)
df$Gender <- as.factor(df$Gender)
df$Pass <- as.factor(df$Pass)

writexl::write_xlsx(df,"Synthetic Data.xlsx")
