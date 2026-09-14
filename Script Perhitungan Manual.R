# Load library
library(MASS)

# Membuat tabel kontingensi
data_table <- matrix(c(30, 20, 10, 40), nrow=2, byrow=TRUE)
dimnames(data_table) <- list(Gender = c("Pria", "Wanita"), Drink = c("Kopi", "Teh"))

# Model independensi: tanpa interaksi
model <- loglm(~ Gender + Drink, data=data_table)

# Menampilkan hasil model
summary(model)
