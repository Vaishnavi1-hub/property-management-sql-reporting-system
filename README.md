# Property Management & SQL Reporting System

A MySQL-based property management database designed to demonstrate relational database design, SQL reporting, business-data analysis, and basic query performance optimization.

## Project Overview

This project models a property management system that manages:

- Properties
- Units
- Tenants
- Leases
- Payments
- Maintenance Requests

The database uses relational relationships between these entities and provides SQL queries and reports for common property-management operations.

## Technologies Used

- MySQL
- SQL
- MySQL Workbench
- Relational Database Management System (RDBMS)

## Database Structure

The database contains six main tables:

1. `properties` – stores property information.
2. `units` – stores individual units and rental information.
3. `tenants` – stores tenant details.
4. `leases` – connects tenants with rental units.
5. `payments` – records rental payments and payment status.
6. `maintenance_requests` – tracks maintenance issues and estimated costs.

### Relationships

```text
Properties
    |
    └── Units
          |
          ├── Leases ─── Tenants
          |
          └── Maintenance Requests

Leases
    |
    └── Payments