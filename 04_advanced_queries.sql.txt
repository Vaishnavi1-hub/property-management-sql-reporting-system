USE property_management;

-- 1. Display tenant, property, and unit details
SELECT
    t.full_name AS tenant_name,
    p.property_name,
    u.unit_number,
    u.monthly_rent,
    l.lease_status
FROM tenants t
JOIN leases l
    ON t.tenant_id = l.tenant_id
JOIN units u
    ON l.unit_id = u.unit_id
JOIN properties p
    ON u.property_id = p.property_id
ORDER BY p.property_name, u.unit_number;


-- 2. Display pending and late payments
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


-- 3. Calculate total paid revenue by property
SELECT
    p.property_name,
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


-- 4. Count maintenance requests by category
SELECT
    category,
    COUNT(*) AS request_count
FROM maintenance_requests
GROUP BY category
ORDER BY request_count DESC;


-- 5. Find properties with more than 3 occupied units
SELECT
    p.property_name,
    COUNT(u.unit_id) AS occupied_units
FROM properties p
JOIN units u
    ON p.property_id = u.property_id
WHERE u.status = 'Occupied'
GROUP BY p.property_id, p.property_name
HAVING COUNT(u.unit_id) > 3
ORDER BY occupied_units DESC;


-- 6. Categorize units based on monthly rent
SELECT
    unit_number,
    monthly_rent,
    CASE
        WHEN monthly_rent >= 30000 THEN 'Premium'
        WHEN monthly_rent >= 20000 THEN 'Standard'
        ELSE 'Budget'
    END AS rent_category
FROM units
ORDER BY monthly_rent DESC;


-- 7. Find tenants whose paid amount is above the average
SELECT
    t.full_name AS tenant_name,
    SUM(pay.amount) AS total_paid
FROM tenants t
JOIN leases l
    ON t.tenant_id = l.tenant_id
JOIN payments pay
    ON l.lease_id = pay.lease_id
WHERE pay.payment_status = 'Paid'
GROUP BY t.tenant_id, t.full_name
HAVING SUM(pay.amount) >
(
    SELECT AVG(total_paid)
    FROM
    (
        SELECT
            SUM(amount) AS total_paid
        FROM payments
        WHERE payment_status = 'Paid'
        GROUP BY lease_id
    ) AS payment_totals
)
ORDER BY total_paid DESC;


-- 8. Find units with maintenance costs above average
SELECT
    u.unit_number,
    SUM(m.estimated_cost) AS total_maintenance_cost
FROM units u
JOIN maintenance_requests m
    ON u.unit_id = m.unit_id
GROUP BY u.unit_id, u.unit_number
HAVING SUM(m.estimated_cost) >
(
    SELECT AVG(total_cost)
    FROM
    (
        SELECT
            SUM(estimated_cost) AS total_cost
        FROM maintenance_requests
        GROUP BY unit_id
    ) AS maintenance_totals
)
ORDER BY total_maintenance_cost DESC;