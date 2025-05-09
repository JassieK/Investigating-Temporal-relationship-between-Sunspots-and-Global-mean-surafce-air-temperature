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

## 📁 Project Structure

```bash
sunspot-climate-analysis/
├── code/
    └── Analysis.R
    └── Analysis.R
    └── Analysis.R
    └── Analysis.R
    └── Analysis.R                  
│   └── Analysis.R          #Final Analysis 
├── data/                   # Datasets (not included due to size)
├── figures/                # Key plots and visualizations
├── results/                # Model summaries and outputs
├── 201772048_JasmitKaur.pdf  # Full academic dissertation
└── README.md               # You are here!
