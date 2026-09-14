library(MASS)
library(gmodels)
library(readxl)

#chi_square_data <- read_excel("Synthetic Data.xlsx")
chi_square_data <- df
head(chi_square_data)

# Two Variables
boys <- subset(chi_square_data,Gender == "Male")
girls <- subset(chi_square_data,Gender == "Female")

# For Male Data
xtable_male <- xtabs(~ Training + Pass, data = boys)
xtable_male

saturaded_male <- loglm(~ Training + Pass + Training:Pass, data = xtable_male, fit = TRUE)
no_interaction_male <- loglm(~ Training + Pass, data = xtable_male, fit = TRUE)
only_interaction_male <- loglm(~ Training*Pass, data = xtable_male, fit = TRUE)

saturaded_male
no_interaction_male
only_interaction_male

anova(saturaded_male,no_interaction_male,only_interaction_male)

# For Female Data
xtable_female <- xtabs(~ Training + Pass, data = boys)
xtable_female

saturaded_female <- loglm(~ Training + Pass + Training:Pass, data = xtable_female, fit = TRUE)
no_interaction_female <- loglm(~ Training + Pass, data = xtable_female, fit = TRUE)
only_interaction_female <- loglm(~ Training*Pass, data = xtable_female, fit = TRUE)

saturaded_female
no_interaction_female
only_interaction_female

anova(saturaded_female,no_interaction_female,only_interaction_female)

# Three Variables
contingencyTable <- xtabs(~Pass + Training + Gender, data = chi_square_data)
contingencyTable

saturaded <- loglm(~ Pass*Training*Gender, data = contingencyTable)
summary(saturaded)

threeway <- update(saturaded, .~. -Gender:Training:Pass)
summary(threeway)

anova(saturaded,threeway)

trainingPass <- update(threeway, .~. -Training:Pass)
genderPass <- update(threeway, .~. -Gender:Pass)
genderTraining <- update(threeway, .~. -Gender:Training)

anova(threeway,trainingPass,genderPass,genderTraining)
