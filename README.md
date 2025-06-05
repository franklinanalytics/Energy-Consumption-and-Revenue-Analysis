![](images/page1.png)

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

## Dataset & Source

**Raw File:** [DisCos Energy Sales by Service Bands Reports](https://github.com/franklinanalytics/Energy-Consumption-and-Revenue-Analysis/blob/main/datasets/DisCos%20Energy%20Sales%20by%20Service%20Bands%20Reports_Nov.20-Sep.2022_30122022.xlsx) (Excel) 

**Source:** Public datasets from [NERC.gov.ng](NERC.gov.ng)

All data was cleaned, normalized, and restructured for modeling purposes. See `/data_cleaning.md` for full documentation.
> *This is an independent project and not affiliated with NERC. All rights and credit go to the Nigerian Electricity Regulatory Commission for the original data.*
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

## Analysis & Insights

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

## Power BI Dashboard Structure

**Page 1: Intro Page**

**Page 2: Executive Summary**

* KPI Cards: Total Billing, Collection, Collection Efficiency
* Bar chart: DisCo-wise energy distribution and billing 

**Page 3: Executive Summary 2**

* Bar chart: DisCo-wise revenue collection
* Doughnut: Revenue by Band
* Slicer: Band, DisCo, Date

**Page 4: Trends and Time Series**

* Line chart: Billing vs Collection over time
* Table: Billing, Collection and Collection Efficiency over time

**Page 5: Revenue Leakage**

* Area chart: Revenue leakage by Disco
* Table: Revenue Leakage by Disco and Band

**Page 6: Band Performance**
* Column chart: Avg ₦/kWh per Band
* Line Chart: Collection Efficiency by Band
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
<p align="center">
  <img src="images/nerc-logo.png" alt="NERC Logo" width="120"/>
</p>

> **Logo credit**: [NERC](NERC.gov.ng) — for educational and non-commercial purposes only.
