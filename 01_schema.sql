CREATE DATABASE IF NOT EXISTS property_management;

USE property_management;

-- Properties
CREATE TABLE properties (
    property_id INT PRIMARY KEY AUTO_INCREMENT,
    property_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    property_type VARCHAR(50),
    total_units INT
);

-- Units
CREATE TABLE units (
    unit_id INT PRIMARY KEY AUTO_INCREMENT,
    property_id INT NOT NULL,
    unit_number VARCHAR(20) NOT NULL,
    bedrooms INT,
    monthly_rent DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (property_id) REFERENCES properties(property_id)
);

-- Tenants
CREATE TABLE tenants (
    tenant_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50)
);

-- Leases
CREATE TABLE leases (
    lease_id INT PRIMARY KEY AUTO_INCREMENT,
    unit_id INT NOT NULL,
    tenant_id INT NOT NULL,
    start_date DATE,
    end_date DATE,
    security_deposit DECIMAL(10,2),
    lease_status VARCHAR(20),
    FOREIGN KEY (unit_id) REFERENCES units(unit_id),
    FOREIGN KEY (tenant_id) REFERENCES tenants(tenant_id)
);

-- Payments
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    lease_id INT NOT NULL,
    payment_date DATE,
    amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    payment_method VARCHAR(30),
    FOREIGN KEY (lease_id) REFERENCES leases(lease_id)
);

-- Maintenance Requests
CREATE TABLE maintenance_requests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    unit_id INT NOT NULL,
    request_date DATE,
    category VARCHAR(50),
    priority VARCHAR(20),
    description VARCHAR(255),
    request_status VARCHAR(30),
    estimated_cost DECIMAL(10,2),
    FOREIGN KEY (unit_id) REFERENCES units(unit_id)
);