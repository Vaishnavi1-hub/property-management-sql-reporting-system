USE property_management;

-- ============================================
-- QUERY PERFORMANCE OPTIMIZATION
-- ============================================

-- 1. Create index for faster payment-status filtering
CREATE INDEX idx_payment_status
ON payments(payment_status);


-- 2. Create index for faster payment-date filtering
CREATE INDEX idx_payment_date
ON payments(payment_date);


-- 3. Create index for faster maintenance-status filtering
CREATE INDEX idx_maintenance_status
ON maintenance_requests(request_status);


-- 4. Analyze pending and late payment query
EXPLAIN
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


-- 5. Analyze property revenue query
EXPLAIN
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
GROUP BY p.property_id, p.property_name;