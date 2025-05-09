# 🌞 Investigating the Temporal Relationship Between Sunspots and Global Mean Surface Air Temperature

![Status](https://img.shields.io/badge/status-Completed-brightgreen)

## 📚 Data Sources

- [NASA GISS Global Temperature Anomaly](https://data.giss.nasa.gov/gistemp/)
- [NOAA AGGI - Greenhouse Gas Index](https://gml.noaa.gov/aggi/)
- [AAVSO Sunspot Data](https://www.aavso.org/solar-database)
- [LISIRD Lyman-Alpha & TSI Irradiance](https://lasp.colorado.edu/lisird/)


## 🧠 Overview

This project investigates the **indirect and long-term effects** of solar activity—particularly sunspot cycles—on **global mean surface air temperature (GMSAT)** using advanced **time series analysis**, **spectral decomposition**, and **intervention modeling**.

The study integrates solar variables like:
- Sunspot numbers (ARSSN)
- Total Solar Irradiance (TSI)
- Lyman-Alpha Irradiation

...with climate indicators:
- NASA GISS global temperature anomaly data
- NOAA's Global Radiative Forcing Index (GRF)

## 🎯 Objectives

1. Understand how sunspot activity affects surface air temperature.
2. Identify **lags and delayed correlations** using statistical modeling.
3. Evaluate **intervention effects** of anthropogenic factors (e.g., greenhouse gases) on temperature.
4. Build predictive models using **Vector AutoRegression (VAR)** and **intervention analysis**.

---

## 📊 Methods Used

- 🧹 **Data Cleaning & Transformation**: From multiple datasets (NASA, NOAA, AAVSO, LISIRD)
- 📈 **Exploratory Data Analysis**: Summary stats, seasonal plots, trends
- 🔄 **Time Series Decomposition**: STL, X11, and Classical methods
- ⏱️ **Lag Analysis**: Cross-correlation with LOESS smoothing
- 🔬 **Spectral Analysis**: To detect periodic components like 11-year solar cycles
- 📉 **VAR Modeling**: To quantify interdependencies between TSI, sunspots, and temperature
- ⚡ **Intervention Modeling**: Added GRF to improve model accuracy and explain long-term trends

---

---

## 📊 Methodology

### 2.1 Data Description

We utilized the following datasets:

- **American Relative Sunspots Number (Ra)**  
- **Total Solar Irradiance (TSI)**  
- **Lyman-Alpha Irradiance**  
- **Global Mean Surface Air Temperature (GMSAT)**  
- **Annual Greenhouse Gas Index (AGGI)**  

📋 _Table: Data Sources Overview_  
![image](https://github.com/user-attachments/assets/9a1120ad-e2e6-449f-81cf-70ed9bcab64b)


---

### 2.2 Data Preprocessing & EDA

Key preprocessing steps:
- Aligned all datasets to a common period: **Jan 1954 – Mar 2024**
- Aggregated daily Lyman-Alpha data to monthly
- Converted GMSAT anomaly to absolute temperature (baseline = 14°C)
- Transformed wide format GMSAT to long format

📋 _Table: Summary Statistics of Key Variables_  
![image](https://github.com/user-attachments/assets/018d38fc-c83d-4195-91cd-e33736b26511)


📈 _Figure: Time Series of Sunspots, TSI, Lyman-Alpha, GMSAT_  
![image](https://github.com/user-attachments/assets/2c77ddce-a976-41b6-a393-ff14724f4062)


---

### 2.3 Spectral Analysis

Spectral analysis reveals dominant frequencies, especially the well-known **11-year solar cycle**, across Sunspots, TSI, and Lyman-Alpha data. GMSAT shows more complex patterns with multiple peaks.

📈 _Figure: Spectral Density Plots_  
![image](https://github.com/user-attachments/assets/aad4af65-d253-403d-adb3-434b5066ff68)


---

### 2.4 Lag Analysis

Correlation at various lags:

- **Sunspots vs TSI**: Peak correlation at 1-month lag  
- **Sunspots vs GMSAT**: Weak short-term effect, strongest correlation at ~370-month lag (~30 years)  
- **TSI vs GMSAT**: Cyclical pattern with mixed signs

📋 _Table: Sunspots–TSI Correlation_  
![image](https://github.com/user-attachments/assets/43c595fe-2ec2-4f18-a42c-4af010883cfc)


📋 _Table: Sunspots–GMSAT Correlation_  
![image](https://github.com/user-attachments/assets/8b23c353-a646-44ef-ae61-a1b46a34574e)


📈 _Figure: Sunspots vs GMSAT Lag Plot_  
📈 _Figure: TSI vs GMSAT Lag Plot_  
![image](https://github.com/user-attachments/assets/82a60c5b-a10e-41a2-8a6b-befb19e9f7dc)
![image](https://github.com/user-attachments/assets/6d8a713d-865a-44b8-b3b8-dc86424bbd51)


---

### 2.5 Vector Auto-Regressive (VAR) Model

Constructed VAR(13) model with Sunspots, TSI, and GMSAT. Key insights:

- Sunspot and TSI have strong autocorrelation
- Sunspots indirectly influence GMSAT via TSI
- Delayed effects are captured well by the lagged structure

📋 _Table: Lag Order Selection_  
![image](https://github.com/user-attachments/assets/23517a66-cdca-46f7-9810-3a8a3e880e42)


📋 _Table: VAR Estimates & Significance_  
![image](https://github.com/user-attachments/assets/e526254a-376d-47aa-8bec-4d94f552c271)


---

### 2.6 Intervention Analysis

Added **Total Global Radiative Forcing (GRF)** to the model as an external driver.

- GRF shows consistent upward trend since ~1975  
- Strong correlation observed between GRF and GMSAT  
- Including GRF significantly improves model performance

📈 _Figure: Radiative Forcing Over Time_  
![image](https://github.com/user-attachments/assets/86905997-e897-443f-b744-a1240cace2f0)


📈 _Figure: Scaled GMSAT vs GRF Plot_  
![image](https://github.com/user-attachments/assets/fdb18deb-afd0-4d03-bf60-f7dad8434147)


📋 _Table: Lag Order Selection (Intervention Model)_  
![image](https://github.com/user-attachments/assets/5300591e-d285-45a1-a48d-3492d3908548)


📋 _Table: Intervention Model Coefficients (GMSAT Equation)_  
![image](https://github.com/user-attachments/assets/8bdd9b8b-d09f-4372-afb7-0e13231364b1)


---
## 🧪 Results & Discussions

### 🔍 Key Findings 

- **Strong Link Observed**: Time series analysis revealed that increased sunspot activity correlates with peaks in TSI and Lyman-Alpha radiation.
- **GMSAT Patterns Are Complex**: While GMSAT follows a rising trend, it shows weaker short-term correlation with sunspot data, indicating influence from other climatic factors.
- **Spectral Analysis Validated Periodicity**: All solar and climate variables showed dominant peaks around the ~11-year solar cycle frequency.
- **Lag Observations**:
  - **Sunspots → TSI**: 1-month lag with strong correlation.
  - **Sunspots → GMSAT**: Negative correlation at short lags; positive and significant at ~370 months (~30.8 years).
  - **TSI → GMSAT**: Cyclical correlation with alternating signs.

📈 _Figure: Model Comparison Metrics (AIC/BIC)_  
![image](https://github.com/user-attachments/assets/e41b2210-7d3f-4531-acca-e43f11c40c2c)


- **Model 1** (Sunspots, TSI, GMSAT): Captures short-term relationships.
- **Model 2** (+ Global Radiative Forcing as intervention): Improves explanatory power significantly.
- **Intervention Model Result**: Highlights GRF as a major factor influencing GMSAT.

---

### ⚠️ Limitations

- Analysis **excluded major external drivers** of climate such as:
  - Volcanic activity  
  - Aerosols  
  - ENSO cycles  
  - Anthropogenic greenhouse gas emissions  
- **Model Complexity**: The VAR model focused only on short-term lags and could not capture multi-decadal feedback mechanisms.
- **Data Constraints**: More time and computational resources could allow incorporation of advanced models (e.g., multivariate structural VAR, long memory models).
- **Scope**: Focused mainly on **solar activity proxies (TSI & Lyman-alpha)**, not other wavelengths like UV, IR, or X-rays.

---

### 🌱 Future Work 

- **Extended Lag Modeling**: Future studies can incorporate **longer lags** to capture delayed climate response to solar activity.
- **Include More Variables**: Consider external drivers such as:
  - Volcanic aerosols  
  - ENSO  
  - Ocean currents  
  - Human-induced radiative forcing  
- **Advanced Techniques**:
  - Machine learning for time series prediction  
  - Bayesian VAR or dynamic factor models  
  - Causal inference with structural models  
- **Wavelength Expansion**: Investigate UV, infrared, and X-ray irradiance impacts on different atmospheric layers.

---

# 📌 Key Findings

- ✅ **Sunspots and TSI** show peak correlation at a lag of 1 month (~0.84).
- 🔁 **Sunspots and Temperature** show a weak short-term relation but reveal a ~30-year lagged correlation.
- 📉 **VAR model** captured interactions between TSI, Sunspots, and GMSAT, with a 13-month optimal lag.
- 🌍 Adding **Global Radiative Forcing (GRF)** significantly improved model predictions (p = 0.002).
"


