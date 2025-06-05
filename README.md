# 🇳🇬 Nigerian Power Sector Analysis (2020–2022)

## Project Overview

This project delivers a comprehensive financial and operational analysis of electricity distribution, billing, and revenue collection in Nigeria from 2020 to 2022, based on official datasets sourced from the Nigerian Electricity Regulatory Commission (NERC). It focuses on key metrics such as billing efficiency, revenue collection, band-level performance, and revenue leakage across DisCos (Distribution Companies).

NERC, the primary regulator of the Nigerian electricity supply industry, publishes monthly service-level performance data across Nigeria’s 11 electricity Distribution Companies (DisCos) and customer service bands. These reports formed the basis for this analytical deep-dive.

The goal of this project is to:

* Uncover inefficiencies in billing and collection across customer bands (A to E)

* Measure and visualize revenue losses and collection performance

* Highlight regional disparities and customer group behaviors

* Compare Nigeria’s sector performance to international benchmarks (India, Kenya, South Africa)

Built using PostgreSQL and Power BI, the analysis offers insights for stakeholders, policymakers, consultants, and industry practitioners. The findings can be used to support data-driven reforms in Nigeria’s power sector.

---

## 🛠️ Tools Used

* **Excel / Power Query** — Data cleaning and wrangling
* **PostgreSQL** — Data transformation and querying
* **Power BI** — Data visualization
* **GitHub** — Project versioning and portfolio documentation

---

## Data Cleaning Process

**Raw File:** [DisCos Energy Sales by Service Bands Reports](https://github.com/franklinanalytics/Energy-Consumption-and-Revenue-Analysis/blob/main/DisCos%20Energy%20Sales%20by%20Service%20Bands%20Reports_Nov.20-Sep.2022_30122022.xlsx) (Excel) 

**Source:** Public datasets from [NERC.gov.ng](NERC.gov.ng)
> *This is an independent project and not affiliated with NERC. All rights and credit go to the Nigerian Electricity Regulatory Commission for the original data.*
---
### Step 1: Import and Initial Preparation

The raw data was provided in a multi-sheet Excel workbook containing electricity billing records by distribution company (DisCo), time period, and customer band.

* Loaded the relevant sheets into **Power Query**.
* Removed all metadata headers, footers, and empty rows to retain only relevant tabular values.
* Transposed the tables to switch rows and columns into a standard layout for analysis.

---

### Step 2: Subtotal Extraction by Band

The dataset contained multiple breakdowns for each band (e.g., *Band A Non MD*, *Band A MD*, etc.). However, the goal was to analyze **total performance per band**, not subcategories.

* Identified and retained only the **subtotal values** for:

  * Lifeline
  * Band A
  * Band B
  * Band C
  * Band D
  * Band E
* Removed all intermediary columns and unnecessary breakdowns.
* Reorganized the cleaned values for each DisCo and placed them **vertically** into a unified table.

---

### Step 3: Standardization and Structure

Created a consistent table structure for each dataset (`energy`, `billing`, and `collection`), using the format:

\| disco | date | lifeline | band\_a | band\_b | band\_c | band\_d | band\_e |

Column names were normalized to lowercase and in `snake_case` format for compatibility with SQL and analytics tools.

---

### Step 4: Unpivoting into Long Format

To enable time-series and band-level comparison:

* Used **Power Query’s Unpivot Columns** feature to convert the six band columns (`lifeline` through `band_e`) into two:

  * `band`
  * `value_column` (e.g., `energy_kwh`, `billing_naira`, or `collection_naira`)
* This reshaped the data into a **tidy/long format** — suitable for merging, aggregation, and time-series analysis.

Final structure per file:

| disco | billing\_date | band | energy\_kwh / billing\_naira / collection\_naira |
| ----- | ------------- | ---- | ------------------------------------------------ |

---

### Step 5: Export for SQL Modeling

Each of the transformed datasets (`energy`, `billing`, and `collection`) was:

* Validated for consistency and duplicates
* Saved as `.csv` format for compatibility with PostgreSQL and Power BI
* Each file contains **1,518 rows**, ensuring perfect alignment across datasets for relational modeling

---

## Summary

This systematic approach to cleaning and reshaping the energy distribution data lays the foundation for high-quality analysis. It ensures compatibility with:

* SQL-based data warehousing
* Power BI dashboards
* Industry-grade financial and operational analytics

---

# SQL Data Model

**Database Tables:**

* `energy_dist` — Energy (kWh) delivered per DisCo and band
* `billing` — Amount billed in ₦ per DisCo and band
* `collection` — Amount collected in ₦ per DisCo and band

Loaded into PostgreSQL and created a **master view** joining all datasets by `disco`, `band`, and `billing_date`.

**View Created:** `master_energy_analysis`

**Structure:**

* `disco`
* `date`
* `band`
* `energy_kwh`
* `billing_naira`
* `collection_naira`

---

## 📊 Core Analysis & Insights

### 1. Energy Billing Rate by Band

**Query:** Billing (₦) / Energy (kWh) per DisCo and Band
**Insight:**

* Band A: ₦50–₦70/kWh
* Band E: Below ₦30/kWh
* Inconsistencies hint at tariff misalignment.

**Recommendation:** Regulatory harmonization and audit.

### 2. Collection Efficiency by Band

**Query:** Collection / Billing per Band & DisCo
**Insight:**

* Bands A–B: > 85% efficiency, Unless in DisCos like KE and JEDC
* Bands D–E: Often < 50%

**Recommendation:** Metering and credit enforcement for low-income bands.

### 3. Revenue Leakage by DisCo

**Query:** Billing - Collection per DisCo
**Insight:**

* High losses in Kaduna, Ibadan, and Benin.
  **Recommendation:** Target metering rollout and enforcement.

### 4. Monthly Trends

**Query:** Aggregated billing/collection by month
**Insight:**

* Billing up, collection flat post-2021.
  **Recommendation:** Prepaid incentives and financing for debt reduction.

### 5. Band Efficiency (Energy vs Paid)

**Query:** Collection / Energy per Band
**Insight:**

* Bands D–E: < 40% monetized energy
  **Recommendation:** Improve mobile payments and education.

---

## 🧱 Summary Tables & CTEs

Created reusable **monthly summaries** and **band-level KPIs** using PostgreSQL views and CTEs for faster queries.

Example:

```sql
WITH monthly_summary AS (
  SELECT
    disco,
    DATE_TRUNC('month', billing_date) AS month,
    SUM(energy_kwh) AS total_energy,
    SUM(billing_naira) AS total_billed,
    SUM(collection_naira) AS total_collected
  FROM master_energy_analysis
  GROUP BY disco, DATE_TRUNC('month', billing_date)
)
SELECT * FROM monthly_summary;
```

---

## 📈 Power BI Dashboard Structure

**Page 1: Executive Summary**

* KPI Cards: Total Billing, Collection, Collection Efficiency
* Bar chart: DisCo-wise billing vs collection
* Pie: Revenue by Band

**Page 2: Trends**

* Line chart: Billing vs Collection over time
* Slicer: Band, DisCo, Date

**Page 3: Band-Level Analysis**

* Heatmap: Collection Efficiency by Band & Month
* Column chart: Avg ₦/kWh per Band

**Page 4: Revenue Leakage Drill-down**

* Tree map: Losses by DisCo

---

## 🌍 Benchmarking: Nigeria vs Global Standards

| Metric                        | Nigeria  | Kenya | India | South Africa |
| ----------------------------- | -------- | ----- | ----- | ------------ |
| Avg. Collection Efficiency    | \~65–75% | \~85% | \~90% | \~95%        |
| Billing Rate (₦/kWh)          | ₦20–60   | ₦25   | ₦22   | ₦65+         |
| Electrification Rate          | \~55%    | 75%   | 99%   | 85%          |
| Technical + Commercial Losses | 30–40%   | 22%   | 18%   | 10–15%       |

> *Source: IEA, World Bank Open Data*

**Conclusion:** Nigeria’s inefficiencies are more structural than demand-driven. Financial analytics can unlock powerful policy reform, debt recovery, and tariff accuracy if applied with real-time data and regulatory backing.

---

## 👨🏽‍💼 Author

**Franklin Durueke**

Data Analyst | Finance Analytics | Power Sector Strategy

[GitHub](https://github.com/franklinanalytics) · [LinkedIn](https://linkedin.com/in/durueke-franklin)

> For questions or collaborations, please reach out via [duruekefranklin@gmail.com](mailto:duruekefranklin@gmail.com)

---
### Attribution & Logo

<p align="left">
  <img src="nerc-logo1.png" alt="NERC Logo" width="120"/>
</p>

> **Logo credit**: [NERC](NERC.gov.ng) — for educational and non-commercial purposes only.
