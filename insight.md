# 🇳🇬 Nigerian Power Sector Analysis (2020–2022)

## 📘 Project Overview

This project delivers a comprehensive financial and operational analysis of Nigeria’s power distribution sector using real-world data from 2020 to 2022. It focuses on key metrics such as billing efficiency, revenue collection, band-level performance, and revenue leakage across DisCos (Distribution Companies).

The goal is to simulate the work of a **senior financial analyst or energy consultant**, extract insights, and provide policy- and investment-grade recommendations. The entire analysis is built using **PostgreSQL** and **Power BI**, and it aims to reflect both local relevance and global standards.

---

## 🛠️ Tools Used

* **Excel / Power Query** — Data cleaning and wrangling
* **PostgreSQL** — Data transformation and querying
* **Power BI** — Data visualization
* **GitHub** — Project versioning and portfolio documentation

---

## 🧼 Data Cleaning Process

**Raw File:** DisCos Energy Sales by Service Bands Reports (Excel)

1. **Imported the sheets** containing data on energy distributed, billing, and revenue collection into Power Query.
2. **Removed metadata** and empty rows, and transposed data where necessary.
3. **Filtered out sub-categories**, keeping only subtotals for Lifeline and Bands A–E.
4. **Normalized band names** and merged all DisCo data into a single columnar structure.
5. **Unpivoted the band columns** to achieve a long format with the following structure:

   * `disco`
   * `billing_date`
   * `band` (lifeline, A, B, C, D, E)
   * `energy_kwh` / `billing_naira` / `collection_naira`
6. Saved each table (`energy_dist.csv`, `billing.csv`, `collection.csv`) as **SQL-ready CSVs**.
7. Loaded into PostgreSQL and created a **master view** joining all datasets by `disco`, `band`, and `billing_date`.

---

## 🧾 SQL Data Model

**Database Tables:**

* `energy_dist` — Energy (kWh) delivered per DisCo and band
* `billing` — Amount billed in ₦ per DisCo and band
* `collection` — Amount collected in ₦ per DisCo and band

**View Created:** `master_energy_analysis`
Structure:

* `disco`
* `billing_date`
* `band`
* `energy_kwh`
* `billing_naira`
* `collection_naira`

---

## 📊 Core Analysis & Insights

### 1. Energy Billing Rate by Band

**Query:** Billing (₦) / Energy (kWh) per DisCo and Band
**Insight:**

* Band A: ₦50–₦60/kWh
* Band E: Below ₦20/kWh
* Inconsistencies hint at tariff misalignment.
  **Recommendation:** Regulatory harmonization and audit.

### 2. Collection Efficiency by Band

**Query:** Collection / Billing per Band & DisCo
**Insight:**

* Bands A–B: > 85% efficiency
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

> 📌 *Source: IEA, World Bank Open Data*

**Conclusion:** Nigeria’s inefficiencies are more structural than demand-driven. Financial analytics can unlock powerful policy reform, debt recovery, and tariff accuracy if applied with real-time data and regulatory backing.

---

## 👨🏽‍💼 Author

**Franklin Durueke**
Data Analyst | Finance | Power Sector Strategy
[GitHub](https://github.com/franklinanalytics) · [LinkedIn](https://linkedin.com/in/durueke-franklin)

---

## 📂 File Structure

```
├── data/
│   ├── energy_dist.csv
│   ├── billing.csv
│   └── collection.csv
├── sql/
│   ├── create_view.sql
│   ├── band_efficiency.sql
│   └── revenue_loss_by_disco.sql
├── visuals/
│   └── power_bi_dashboard.pbix
├── README.md
└── insights.md
```

> For questions or collaborations, please reach out via [duruekefranklin@gmail.com](mailto:duruekefranklin@gmail.com)

---

> **Status:** ✅ Completed — Ready for Interview Use, GitHub Portfolio, and Upwork Showcase
