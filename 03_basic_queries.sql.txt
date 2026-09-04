USE property_management;

-- 1. Display all properties
SELECT *
FROM properties;


-- 2. Display occupied units
SELECT
    unit_id,
    unit_number,
    monthly_rent,
    status
FROM units
WHERE status = 'Occupied';


-- 3. Display vacant units
SELECT
    unit_id,
    unit_number,
    monthly_rent
FROM units
WHERE status = 'Vacant';


-- 4. Find units with monthly rent greater than 20000
SELECT
    unit_number,
    monthly_rent
FROM units
WHERE monthly_rent > 20000
ORDER BY monthly_rent DESC;


-- 5. Display tenants from Pune
SELECT
    tenant_id,
    full_name,
    email,
    phone
FROM tenants
WHERE city = 'Pune';


-- 6. Display active leases
SELECT
    lease_id,
    unit_id,
    tenant_id,
    start_date,
    end_date,
    lease_status
FROM leases
WHERE lease_status = 'Active';


-- 7. Calculate total number of units
SELECT COUNT(*) AS total_units
FROM units;


-- 8. Calculate average monthly rent
SELECT
    ROUND(AVG(monthly_rent), 2) AS average_monthly_rent
FROM units;


-- 9. Find the highest monthly rent
SELECT
    MAX(monthly_rent) AS highest_monthly_rent
FROM units;


-- 10. Count units by status
SELECT
    status,
    COUNT(*) AS unit_count
FROM units
GROUP BY status
ORDER BY unit_count DESC;