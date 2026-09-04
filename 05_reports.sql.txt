USE property_management;

-- ============================================
-- BUSINESS REPORTS
-- ============================================

-- 1. Property Occupancy Report
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
GROUP BY p.property_id, p.property_name
ORDER BY occupancy_rate DESC;


-- 2. Property Revenue Report
SELECT
    p.property_name,
    COUNT(pay.payment_id) AS payment_count,
    SUM(pay.amount) AS total_revenue
FROM properties p
JOIN units u
    ON p.property_id = u.property_id
JOIN leases l
    ON u.unit_id = l.unit_id
JOIN payments pay
    ON l.lease_id = pay.lease_id
WHERE pay.payment_status = 'Paid'
GROUP BY p.property_id, p.property_name
ORDER BY total_revenue DESC;


-- 3. Pending and Late Payment Report
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
WHERE pay.payment_status IN ('Pending', 'Late')
ORDER BY pay.payment_date;


-- 4. Tenant Lease Report
SELECT
    t.full_name AS tenant_name,
    t.city,
    p.property_name,
    u.unit_number,
    l.start_date,
    l.end_date,
    l.security_deposit,
    l.lease_status
FROM tenants t
JOIN leases l
    ON t.tenant_id = l.tenant_id
JOIN units u
    ON l.unit_id = u.unit_id
JOIN properties p
    ON u.property_id = p.property_id
ORDER BY l.end_date;


-- 5. Maintenance Summary Report
SELECT
    p.property_name,
    m.category,
    COUNT(m.request_id) AS total_requests,
    SUM(m.estimated_cost) AS estimated_maintenance_cost
FROM maintenance_requests m
JOIN units u
    ON m.unit_id = u.unit_id
JOIN properties p
    ON u.property_id = p.property_id
GROUP BY p.property_id, p.property_name, m.category
ORDER BY estimated_maintenance_cost DESC;


-- 6. Open Maintenance Requests
SELECT
    p.property_name,
    u.unit_number,
    m.category,
    m.priority,
    m.description,
    m.request_status,
    m.estimated_cost
FROM maintenance_requests m
JOIN units u
    ON m.unit_id = u.unit_id
JOIN properties p
    ON u.property_id = p.property_id
WHERE m.request_status IN ('Pending', 'In Progress')
ORDER BY
    CASE
        WHEN m.priority = 'High' THEN 1
        WHEN m.priority = 'Medium' THEN 2
        ELSE 3
    END,
    m.request_date;


-- 7. Revenue by Payment Method
SELECT
    payment_method,
    COUNT(payment_id) AS payment_count,
    SUM(amount) AS total_amount
FROM payments
WHERE payment_status = 'Paid'
GROUP BY payment_method
ORDER BY total_amount DESC;


-- 8. Property-Level Unit Summary
SELECT
    p.property_name,
    COUNT(u.unit_id) AS total_units,
    ROUND(AVG(u.monthly_rent), 2) AS average_rent,
    MIN(u.monthly_rent) AS minimum_rent,
    MAX(u.monthly_rent) AS maximum_rent
FROM properties p
JOIN units u
    ON p.property_id = u.property_id
GROUP BY p.property_id, p.property_name
ORDER BY average_rent DESC;