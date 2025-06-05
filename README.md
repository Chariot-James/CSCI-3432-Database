# CSCI-3432-Databases
# Restaurant Support Database

This repository contains the SQL schema and data dump for a sample restaurant management system. It was created as part of a class project to demonstrate relational database design, data handling, and the use of triggers, stored procedures, and foreign key constraints.

## Project Overview

The **Restaurant Support** database is designed to simulate how restaurants can manage their customers, reservations, servers, waitlists, and loyalty programs. It includes a full set of relational tables with realistic test data.

### My Role

I was responsible for designing and coding the entire database structure, including:

- Creating normalized tables with appropriate data types and constraints
- Setting up relationships using foreign keys
- Writing triggers and a stored procedure to handle loyalty and waitlist logic
- Populating the database with representative sample data

---

## Features

- **Customers** table for storing user profiles and satisfaction ratings
- **Loyalty** system with tier upgrades based on points (includes trigger)
- **Restaurant** information including capacity and location
- **Reservation** system with relational integrity
- **Servers** and their assignments to restaurants
- **Waitlist** management with estimated wait times and notification preferences
- **Stored Procedure** to update waitlist status
- **Triggers** to update loyalty points automatically after reservations

---

## How to Use

1. Import the `restaurantsupport.sql` file into your MySQL server:
   ```bash
   mysql -u your_user -p < restaurantsupport.sql
