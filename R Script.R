########################################################
# 🧠 Nonlinear TVECM Analysis: ETH vs. WTI
# 🎯 Objective: Model regime-dependent cointegration 
# between Ethereum (ETH) and West Texas Intermediate (WTI)
# using the Threshold Vector Error Correction Model (TVECM)
########################################################

# Step 1. 📦 Load Required Libraries
library(tsDyn)      # For TVECM modeling
library(urca)       # For Johansen cointegration test
library(tidyverse)  # For data handling
library(pastecs)    # For descriptive statistics

# Step 2. 📥 Import and Prepare Dataset
# (Assumes dataset already imported and named `data_clean`)
# Use haven::read_dta() if working from Stata files

# Step 3. 🧹 Handle Missing Values (if not already done)
# data_clean <- na.omit(data_raw)

# Step 4. 📆 Declare Time Series Variables
lnETH <- ts(data_clean$lnETH, start = c(2020, 6), end = c(2025, 80), frequency = 365)
lnWTI <- ts(data_clean$lnWTI, start = c(2020, 297), end = c(2025, 80), frequency = 365)

# Step 5. 🔗 Combine into Multivariate Matrix
bivarii <- cbind(lnETH = data_clean$lnETH, lnWTI = data_clean$lnWTI)

# Step 6. 📊 Descriptive Statistics
stat.desc(data_clean[, c("lnETH", "lnWTI")], norm = TRUE)
# → Observe skewness, kurtosis, normality W-test, etc.

# Step 7. 🔍 Cointegration Analysis

## 7.1. Johansen Test: Long-Run Equilibrium
coint_testing <- ca.jo(bivarii, type = "trace", K = 2, ecdet = "const")
summary(coint_testing)
# → Strong evidence of cointegration (r = 1)

## 7.2. Hansen & Seo (2002) Threshold Cointegration Test
test1 <- TVECM.HStest(bivarii, lag = 1, intercept = TRUE, nboot = 100)
print(test1)
# → p < 0.05 indicates nonlinearity → use TVECM

# Step 8. ⚙️ Estimate TVECM Model
tvec <- TVECM(
  bivarii,
  nthresh = 2,           # Two thresholds → three regimes
  lag = 1,               # One lag in short-run dynamics
  ngridBeta = 20,        # Grid search over cointegration vector
  ngridTh = 30,          # Grid search over thresholds
  trim = 0.05,           # Trimming to avoid sparse regimes
  common = "All",        # Common cointegration vector across regimes
  plot = TRUE            # Show residual SSR grid search
)

# Step 9. 📈 Summarize Results
print(tvec)
summary(tvec)
# → ECT signs, lag coefficients, threshold values, diagnostics

# Step 10. 🧪 Post-Estimation Diagnostics

## 10.1. Extract Residuals
tvecm_residuals <- residuals(tvec)

## 10.2. Model Fit Criteria
AIC(tvec)
BIC(tvec)

# End of Pipeline ✅
########################################################
