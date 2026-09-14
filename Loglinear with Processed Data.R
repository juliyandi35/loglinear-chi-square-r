library(MASS)

# Import and Describe the Data
HairEyeColor

## Independence model of hair and eye color and sex.  
hec.1 <- loglm(~Hair+Eye+Sex, data=HairEyeColor)
hec.1

## Conditional independence
hec.2 <- loglm(~(Hair + Eye) * Sex, data=HairEyeColor)
hec.2

## Joint independence model.  
hec.3 <- loglm(~Hair*Eye + Sex, data=HairEyeColor)
hec.3

anova(hec.1, hec.2, hec.3)
