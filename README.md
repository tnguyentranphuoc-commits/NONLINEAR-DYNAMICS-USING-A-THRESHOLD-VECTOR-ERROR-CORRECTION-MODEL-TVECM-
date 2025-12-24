# NONLINEAR DYNAMICS USING A THRESHOLD VECTOR ERROR CORRECTION MODEL (TVECM)
🛠️ **Tech Stack**: R (tsDyn, urca, pastecs, tidyverse)

---

## (i). Overview

This project investigates the **nonlinear interrelationship** between **Ethereum (ETH)** and **West Texas Intermediate (WTI)** crude oil prices using the **Threshold Vector Error Correction Model (TVECM)**. Unlike linear cointegration models, TVECM allows for **regime-dependent behavior**, capturing how the adjustment to long-run equilibrium differs under distinct market conditions (e.g., high vs low volatility periods).

The motivation stems from observed empirical patterns: both ETH and WTI display **non-normality**, **high kurtosis**, and **structural asymmetries**. The TVECM framework captures these dynamics by allowing for **multiple thresholds**, providing deeper insight into the **nonlinear adjustments** and **market switching behavior**.

---

## (ii). Methodology

### 🔍 Pre-Estimation Diagnostics

- **Descriptive Statistics**:
  - ETH: Mean = 0.00147 | SD = 0.0451 | Skew = -1.30 | Kurtosis = 19.5
  - WTI: Mean = 0.0000677 | SD = 0.0301 | Skew = -1.47 | Kurtosis = 56.2
  - Both series are **leptokurtic** and **left-skewed**.

- **Normality Tests**:
  - Shapiro-Wilk W = 0.89 (ETH), 0.73 (WTI)
  - **p < 0.0001** → Reject normality for both.

- **Cointegration**:
  - **Johansen Trace Test** confirms **1 cointegrating vector** at 1% level.
  - Strong long-run relationship with **negative WTI loading**.

- **Nonlinearity Test**:
  - **Hansen & Seo (2002)** threshold cointegration test:
    - Test statistic = 23.72, p = 0.01
    - → Strong evidence of **threshold cointegration**.

---

## (iii). Modeling Pipeline

```text
STEP 1: Import and clean daily data for ETH & WTI (2018–2025)
→ STEP 2: Log-transformation and combine series into matrix (lnETH, lnWTI)
→ STEP 3: Descriptive analysis and normality diagnostics
→ STEP 4: Johansen cointegration test
→ STEP 5: Hansen & Seo threshold cointegration test
→ STEP 6: TVECM estimation with two thresholds (nthresh = 2, lag = 1)
→ STEP 7: Extract regime-specific coefficients and interpret error correction dynamics
→ STEP 8: Visual diagnostics, residual check, and summary statistics
```

---

## (iv). Key Findings

### 📉 TVECM Results Overview

- **Two thresholds** detected:
  - Threshold 1: −0.0626
  - Threshold 2: −0.0420
  - → Define **three regimes**: Down (5.2%), Middle (5.1%), Up (89.7%)

### ⚙️ Cointegrating Vector:
- (1, −0.1815) → ETH and WTI are negatively cointegrated.

### 📊 Regime Dynamics:

#### 🔽 **Down Regime (Market Stress)**
- ETH adjusts strongly to long-run deviation:
  - ECT = **−1.3053 (p < 0.001)**
- WTI negatively affects ETH: **−0.536 (p < 0.001)**
- ETH has memory (lagged self = 0.238, p < 0.05)

#### 🟡 **Middle Regime (Transition Phase)**
- ETH adjustment weaker: ECT = **−0.9488 (insignificant)**
- No significant short-run interactions
- WTI affects itself more than ETH

#### 🔼 **Up Regime (Stable Market)**
- ETH: ECT = **−1.0037 (p < 0.001)** → continues adjusting toward equilibrium
- WTI still negatively affects ETH: **−0.1524 (p < 0.001)**
- WTI self-corrects significantly: **−0.4603 (p < 0.001)**

---

## (v). Application: Risk & Portfolio Implications

- **ETH is more reactive** in correcting long-run imbalances, especially during stress regimes.
- **WTI exerts stronger influence** on ETH in extreme regimes, implying commodity-driven crypto sensitivity.
- Implications for **regime-aware portfolio construction**:
  - Use thresholds to switch risk allocations.
  - Avoid static correlation assumptions between crypto and commodity markets.
  - Monitor transitions across regimes as **leading indicators** for volatility management.

---

## (vi). Repository Contents

- `R Script.R`: Full R script for TVECM estimation and diagnostics  
- `Dataset.dta`: Daily log returns of ETH and WTI (Investing.com)  
- `Methods and Results.pdf`: Methodological explanations and empirical outputs  
- `README.md`: This project documentation

--
