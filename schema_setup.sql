-- Energy Consumption and Revenue Analysis
CREATE TABLE energy_dist (
	disco				VARCHAR,
	date				date,
	band				VARCHAR,
	energy_kwh 			FLOAT
);

CREATE TABLE billing (
	disco				VARCHAR,
	date				date,
	band				VARCHAR,
	billing_naira 		NUMERIC
);

CREATE TABLE collection (
	disco				VARCHAR,
	date				date,
	band				VARCHAR,
	collection_naira 	NUMERIC
);

SELECT * FROM energy_dist
SELECT * FROM billing
SELECT * FROM collection
