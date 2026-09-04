USE property_management;

-- ============================================
-- SQL VIEWS
-- ============================================

-- 1. Property Occupancy View
CREATE OR REPLACE VIEW property_occupancy_report AS
SELECT
    p.property_name,
    COUNT(u.unit_id) AS total_units,
    SUM(CASE WHEN u.status = 'Occupied' THEN 1 ELSE 0 END) AS occupied_units,
    SUM(CASE WHEN u.status = 'Vacant' THEN 1 ELSE 0 END) AS vacant_units,
    ROUND(
        SUM(CASE WHEN u.status = 'Occupied' THEN 1 ELSE 0 END) * 100.0
        / COUNT(u.unit_id),
        2
    ) AS occupancy_rate
FROM properties p
LEFT JOIN units u
    ON p.property_id = u.property_id
GROUP BY p.property_id, p.property_name;


-- 2. Pending Payment View
CREATE OR REPLACE VIEW pending_payment_report AS
SELECT
    t.full_name AS tenant_name,
    p.property_name,
    u.unit_number,
    pay.payment_date,
    pay.amount,
    pay.payment_status
FROM payments pay
JOIN leases l
    ON pay.lease_id = l.lease_id
JOIN tenants t
    ON l.tenant_id = t.tenant_id
JOIN units u
    ON l.unit_id = u.unit_id
JOIN properties p
    ON u.property_id = p.property_id
WHERE pay.payment_status IN ('Pending', 'Late');


-- ============================================
-- TEST THE VIEWS
-- ============================================

SELECT * 
FROM property_occupancy_report
ORDER BY occupancy_rate DESC;

SELECT *
FROM pending_payment_report
ORDER BY payment_date;