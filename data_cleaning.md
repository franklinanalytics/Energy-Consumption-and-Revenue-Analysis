# Energy-Consumption-and-Revenue-Analysis

## Data Cleaning & Transformation Process

**Tool Used:**

* Microsoft Excel (Power Query & Manual Data Wrangling)

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

\| disco | billing\_date | lifeline | band\_a | band\_b | band\_c | band\_d | band\_e |

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
