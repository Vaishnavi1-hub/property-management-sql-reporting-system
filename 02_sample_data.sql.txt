USE property_management;

-- ============================================
-- SAMPLE DATA
-- ============================================

-- Properties
INSERT INTO properties
(property_id, property_name, city, property_type, total_units)
VALUES
(1, 'Sunrise Residency', 'Pune', 'Residential', 5),
(2, 'Green Valley Apartments', 'Mumbai', 'Residential', 4),
(3, 'Tech Park Heights', 'Bengaluru', 'Residential', 6),
(4, 'Lakeview Towers', 'Hyderabad', 'Residential', 5),
(5, 'Urban Nest Homes', 'Chhatrapati Sambhajinagar', 'Residential', 4);


-- Units
INSERT INTO units
(unit_id, property_id, unit_number, bedrooms, monthly_rent, status)
VALUES
(1, 1, 'A-101', 2, 18000.00, 'Occupied'),
(2, 1, 'A-102', 2, 19000.00, 'Occupied'),
(3, 1, 'A-103', 1, 14000.00, 'Vacant'),
(4, 1, 'A-104', 3, 25000.00, 'Occupied'),
(5, 1, 'A-105', 2, 20000.00, 'Vacant'),

(6, 2, 'B-201', 2, 22000.00, 'Occupied'),
(7, 2, 'B-202', 3, 30000.00, 'Occupied'),
(8, 2, 'B-203', 1, 16000.00, 'Vacant'),
(9, 2, 'B-204', 2, 23000.00, 'Occupied'),

(10, 3, 'C-301', 2, 24000.00, 'Occupied'),
(11, 3, 'C-302', 2, 25000.00, 'Occupied'),
(12, 3, 'C-303', 3, 32000.00, 'Occupied'),
(13, 3, 'C-304', 1, 18000.00, 'Vacant'),
(14, 3, 'C-305', 2, 26000.00, 'Vacant'),
(15, 3, 'C-306', 3, 35000.00, 'Occupied'),

(16, 4, 'D-401', 2, 21000.00, 'Occupied'),
(17, 4, 'D-402', 1, 15000.00, 'Vacant'),
(18, 4, 'D-403', 2, 22000.00, 'Occupied'),
(19, 4, 'D-404', 3, 30000.00, 'Occupied'),
(20, 4, 'D-405', 2, 23000.00, 'Vacant'),

(21, 5, 'E-501', 1, 12000.00, 'Occupied'),
(22, 5, 'E-502', 2, 16000.00, 'Occupied'),
(23, 5, 'E-503', 2, 17000.00, 'Vacant'),
(24, 5, 'E-504', 3, 21000.00, 'Occupied');


-- Tenants
INSERT INTO tenants
(tenant_id, full_name, email, phone, city)
VALUES
(1, 'Aarav Sharma', 'aarav.sharma@email.com', '9876543210', 'Pune'),
(2, 'Priya Patil', 'priya.patil@email.com', '9876543211', 'Mumbai'),
(3, 'Rahul Verma', 'rahul.verma@email.com', '9876543212', 'Bengaluru'),
(4, 'Sneha Kulkarni', 'sneha.kulkarni@email.com', '9876543213', 'Pune'),
(5, 'Aditya Joshi', 'aditya.joshi@email.com', '9876543214', 'Hyderabad'),
(6, 'Neha Deshmukh', 'neha.deshmukh@email.com', '9876543215', 'Mumbai'),
(7, 'Rohan Mehta', 'rohan.mehta@email.com', '9876543216', 'Bengaluru'),
(8, 'Ananya Singh', 'ananya.singh@email.com', '9876543217', 'Hyderabad'),
(9, 'Vikram Shah', 'vikram.shah@email.com', '9876543218', 'Pune'),
(10, 'Kavya More', 'kavya.more@email.com', '9876543219', 'Chhatrapati Sambhajinagar');


-- Leases
INSERT INTO leases
(lease_id, unit_id, tenant_id, start_date, end_date, security_deposit, lease_status)
VALUES
(16, 1, 1, '2026-01-01', '2026-12-31', 36000.00, 'Active'),
(17, 2, 2, '2026-02-01', '2027-01-31', 38000.00, 'Active'),
(18, 4, 3, '2026-01-15', '2027-01-14', 50000.00, 'Active'),
(19, 6, 4, '2026-03-01', '2027-02-28', 44000.00, 'Active'),
(20, 7, 5, '2026-01-01', '2026-12-31', 60000.00, 'Active'),
(21, 9, 6, '2026-02-15', '2027-02-14', 46000.00, 'Active'),
(22, 10, 7, '2026-01-01', '2026-12-31', 48000.00, 'Active'),
(23, 11, 8, '2026-03-01', '2027-02-28', 50000.00, 'Active'),
(24, 13, 9, '2026-01-15', '2027-01-14', 52000.00, 'Active'),
(25, 16, 10, '2026-02-01', '2027-01-31', 42000.00, 'Active'),
(26, 18, 1, '2026-04-01', '2027-03-31', 44000.00, 'Active'),
(27, 19, 2, '2026-01-01', '2026-12-31', 60000.00, 'Active'),
(28, 20, 3, '2026-02-01', '2027-01-31', 46000.00, 'Active'),
(29, 22, 4, '2026-03-01', '2027-02-28', 24000.00, 'Active'),
(30, 24, 5, '2026-01-15', '2027-01-14', 42000.00, 'Active');


-- Payments
INSERT INTO payments
(payment_id, lease_id, payment_date, amount, payment_status, payment_method)
VALUES
(16, 16, '2026-01-05', 18000.00, 'Paid', 'UPI'),
(17, 17, '2026-01-07', 22000.00, 'Paid', 'Bank Transfer'),
(18, 18, '2026-01-10', 25000.00, 'Paid', 'UPI'),
(19, 19, '2026-01-12', 20000.00, 'Paid', 'Credit Card'),
(20, 20, '2026-01-15', 18000.00, 'Pending', 'UPI'),
(21, 21, '2026-01-18', 30000.00, 'Paid', 'Bank Transfer'),
(22, 22, '2026-01-20', 27000.00, 'Paid', 'UPI'),
(23, 23, '2026-01-22', 21000.00, 'Pending', 'Credit Card'),
(24, 24, '2026-01-25', 32000.00, 'Paid', 'Bank Transfer'),
(25, 25, '2026-01-27', 19000.00, 'Paid', 'UPI'),
(26, 26, '2026-02-05', 18000.00, 'Paid', 'UPI'),
(27, 27, '2026-02-07', 22000.00, 'Late', 'Bank Transfer'),
(28, 28, '2026-02-10', 25000.00, 'Paid', 'Credit Card'),
(29, 29, '2026-02-12', 20000.00, 'Pending', 'UPI'),
(30, 30, '2026-02-15', 18000.00, 'Paid', 'Bank Transfer');


-- Maintenance Requests
INSERT INTO maintenance_requests
(request_id, unit_id, request_date, category, priority, description, request_status, estimated_cost)
VALUES
(1, 1, '2026-01-03', 'Plumbing', 'High', 'Water leakage in bathroom', 'Completed', 2500.00),
(2, 2, '2026-01-05', 'Electrical', 'Medium', 'Faulty ceiling light', 'Completed', 1200.00),
(3, 4, '2026-01-08', 'Plumbing', 'High', 'Kitchen pipe leakage', 'In Progress', 3000.00),
(4, 6, '2026-01-10', 'HVAC', 'Medium', 'Air conditioner not cooling', 'Pending', 4500.00),
(5, 7, '2026-01-12', 'Electrical', 'Low', 'Power socket replacement', 'Completed', 800.00),
(6, 9, '2026-01-15', 'Plumbing', 'Medium', 'Bathroom tap repair', 'Completed', 1000.00),
(7, 10, '2026-01-18', 'Appliance', 'High', 'Refrigerator not working', 'In Progress', 6000.00),
(8, 11, '2026-01-20', 'Electrical', 'Medium', 'Switchboard issue', 'Pending', 1500.00),
(9, 13, '2026-01-22', 'Plumbing', 'Low', 'Kitchen tap replacement', 'Completed', 900.00),
(10, 16, '2026-01-25', 'HVAC', 'High', 'Air conditioner repair', 'Pending', 5000.00),
(11, 18, '2026-02-02', 'Plumbing', 'Medium', 'Water pressure issue', 'Completed', 1800.00),
(12, 19, '2026-02-05', 'Electrical', 'High', 'Main switch problem', 'In Progress', 3500.00),
(13, 20, '2026-02-08', 'Appliance', 'Medium', 'Washing machine issue', 'Completed', 2200.00),
(14, 22, '2026-02-10', 'Plumbing', 'Low', 'Drain blockage', 'Completed', 700.00),
(15, 24, '2026-02-12', 'Electrical', 'Medium', 'Bedroom light repair', 'Pending', 1100.00);