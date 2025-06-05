-- Queries to uncover:
--The first thing we will do is to create a unified SQL View

CREATE OR REPLACE VIEW master_energy_analysis AS
SELECT 
    e.disco,
    e.date,
    e.band,
    e.energy_kwh,
    b.billing_naira,
    c.collection_naira
FROM energy_dist e
LEFT JOIN billing b 
    ON e.disco = b.disco 
    AND e.date = b.date 
    AND e.band = b.band
LEFT JOIN collection c 
    ON e.disco = c.disco 
    AND e.date = c.date 
    AND e.band = c.band;

SELECT * FROM master_energy_analysis

-- Total energy distributed, Total amount billed and Total amount collected by disco and band
SELECT
	disco,
	band,
	SUM(energy_kwh) AS total_energy_dist,
	SUM(billing_naira) AS total_amount_billed,
	SUM(collection_naira) AS total_amount_collected
FROM master_energy_analysis
GROUP BY disco, band

-- Key Metrics to Extract
-- 1. Energy Billing Rate by Disco and Band			
--How much was billed per unit of energy
SELECT 
	disco,
	band,
	ROUND(SUM(billing_naira)::numeric / NULLIF(SUM(energy_kwh)::numeric, 0), 2) AS billing_rate_per_kwh
FROM master_energy_analysis
GROUP BY disco, band
ORDER BY disco, band;

-- 2. Collection Rate by Disco and Band
--How much was collected/recovered per unit
SELECT
	disco,
	band,
	ROUND(SUM(collection_naira)::numeric / NULLIF(SUM(energy_kwh)::numeric, 0), 2) AS collection_rate_per_kwh
FROM master_energy_analysis
GROUP BY disco, band
ORDER BY disco, band;

-- 3. Collection Efficiency
--% of billed amount that was collected
SELECT 
	disco,
	band,
	ROUND(SUM(collection_naira) * 100/ NULLIF(SUM(billing_naira), 0), 2) AS percent_collected
FROM master_energy_analysis
GROUP BY disco, band
ORDER BY disco, band;

-- 4. Revenue Loss by State/Distribution Company
--Billed amount not recovered
SELECT 
	disco,
	band,
	SUM(billing_naira) AS total_billing,
	SUM(collection_naira) AS total_revenue,
	ROUND(SUM(billing_naira) - SUM(collection_naira), 0)	AS revenue_loss	
FROM master_energy_analysis
GROUP BY disco, band
ORDER BY disco, band;

-- 5. Billing and Revenue by Distribution Company
-- Which of the States/disco is billed more and which returns more revenue
SELECT 
	disco,
	ROUND(SUM(billing_naira), 0) AS total_billed,
	ROUND(SUM(collection_naira), 0) AS total_collected
FROM master_energy_analysis
GROUP BY disco
ORDER BY total_revenue DESC;

-- 6. Monthly Trends for Billing, Collection, and Efficiency
--How does financial performance evolve over time?
SELECT
  TO_CHAR(DATE_TRUNC('month', date), 'YYYY-MM') AS month,
  ROUND(SUM(billing_naira), 2) AS total_billed,
  ROUND(SUM(collection_naira), 2) AS total_collected,
  ROUND(SUM(collection_naira) * 100.0 / NULLIF(SUM(billing_naira), 0), 2) AS collection_efficiency_percent
FROM master_energy_analysis
GROUP BY month
ORDER BY month;

-- 7. Yearly Trends 
SELECT
  TO_CHAR(DATE_TRUNC('YEAR', date), 'YYYY') AS year,
  ROUND(SUM(billing_naira), 0) AS total_billed,
  ROUND(SUM(collection_naira), 0) AS total_collected,
  ROUND(SUM(collection_naira) * 100.0 / NULLIF(SUM(billing_naira), 0), 2) AS collection_efficiency_percent
FROM master_energy_analysis
GROUP BY year
ORDER BY year;

-- 8. Band efficiency — energy delivered vs paid
SELECT
  band,
  ROUND(SUM(billing_naira),0) AS total_billed,
  ROUND(SUM(collection_naira),0) AS total_collected
FROM master_energy_analysis
GROUP BY band
ORDER BY total_billed DESC;

WITH monthly_summary AS (
  SELECT
    disco,
    TO_CHAR(DATE_TRUNC('month', date), 'YYYY-MM') AS month,
    SUM(energy_kwh) AS total_energy,
    SUM(billing_naira) AS total_billed,
    SUM(collection_naira) AS total_collected
  FROM master_energy_analysis
  GROUP BY disco, DATE_TRUNC('month', date)
)
SELECT * FROM monthly_summary;


