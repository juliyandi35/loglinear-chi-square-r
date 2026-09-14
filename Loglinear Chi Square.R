library(gmodels)
library(readxl)
library(MASS)

chi_square_data <- df
head(chi_square_data)

Gender <- as.factor(chi_square_data$Gender)
Pass <- as.factor(chi_square_data$Pass)
Training <- as.factor(chi_square_data$Training)

boysClub <- subset(chi_square_data,Gender == "Male")
girlsRule <- subset(chi_square_data,Gender == "Female")

CrossTable(boysClub$Training,boysClub$Pass, sresid = TRUE, prop.t = FALSE, prop.c = FALSE, prop.chisq = FALSE, format = "SPSS")
CrossTable(girlsRule$Training,girlsRule$Pass, sresid = TRUE, prop.t = TRUE, prop.c = TRUE, prop.chisq = FALSE, format = "SPSS")

xtable <- xtabs(~ Training + Pass, data = girlsRule)
xtable

saturaded <- loglm(~ Training + Pass + Training:Pass, data = xtable, fit = TRUE)
nointeraction <- loglm(~ Training + Pass, data = xtable, fit = TRUE)
girlsat <- loglm(~ Training*Pass, data = xtable, fit = TRUE)

saturaded
nointeraction
girlsat

contingencyTable <- xtabs(~Gender + Training + Pass, data = chi_square_data)
contingencyTable

saturaded2 <- loglm(~ Gender*Training*Pass, data = contingencyTable)
summary(saturaded2)

threeway <- update(saturaded2, .~. -Gender:Training:Pass)
summary(threeway)

anova(saturaded2,threeway)

trainingPass <- update(threeway, .~. -Training:Pass)
genderPass <- update(threeway, .~. -Gender:Pass)
genderTraining <- update(threeway, .~. -Gender:Training)

anova(threeway,trainingPass)
anova(threeway,genderPass)
anova(threeway,genderTraining)

CrossTable(boysClub$Training, boysClub$Pass, fisher = TRUE, chisq = TRUE, expected = TRUE, sresid = TRUE, format = "SPSS")
CrossTable(girlsRule$Training, girlsRule$Pass, fisher = TRUE, chisq = TRUE, expected = TRUE, sresid = TRUE, format = "SPSS")
