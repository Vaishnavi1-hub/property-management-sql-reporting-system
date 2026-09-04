USE property_management;

-- ============================================
-- STORED PROCEDURES
-- ============================================

DELIMITER $$

-- 1. Get Property Revenue Report
CREATE PROCEDURE GetPropertyRevenue()
BEGIN
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
END$$

DELIMITER ;


-- ============================================
-- TEST THE STORED PROCEDURE
-- ============================================

CALL GetPropertyRevenue();