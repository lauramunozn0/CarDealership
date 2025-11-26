DROP DATABASE IF EXISTS CarDealership;
CREATE DATABASE IF NOT EXISTS CarDealership;
Use CarDealership;

DROP TABLE IF EXISTS Dealerships;
DROP TABLE IF EXISTS Vehicles;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS SalesContracts;

CREATE TABLE Dealerships (
 Dealership_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    address VARCHAR(50),
    phone VARCHAR(12),
    PRIMARY KEY (dealership_id)
);

CREATE TABLE Vehicles (
    VIN VARCHAR(17) NOT NULL,
    make VARCHAR(50),
    model VARCHAR(50),
    year INT,
    SOLD BOOLEAN,
    color VARCHAR(50),
    vehicleType VARCHAR(50),
    odometer INT,
    price DOUBLE,
    PRIMARY KEY (VIN)
);

CREATE TABLE Inventory (
    dealership_id INT NOT NULL,
    VIN VARCHAR(17) NOT NULL,
    PRIMARY KEY (dealership_id, VIN),
    FOREIGN KEY (dealership_id) REFERENCES Dealerships(dealership_id),
    FOREIGN KEY (VIN) REFERENCES vehicles(VIN)
);

CREATE TABLE salesContracts (
    Contract_id INT NOT NULL AUTO_INCREMENT,
    VIN VARCHAR(17) NOT NULL,
    sale_date DATE,
    price DECIMAL(10,2),
    PRIMARY KEY (contract_id),
    FOREIGN KEY (VIN) REFERENCES vehicles(VIN)
);
-- simple data

INSERT INTO Dealerships (name, address, phone) VALUES
('Star Motors', '101 Galaxy Way', '555-1001'),
('AutoPlanet', '500 Space Blvd', '555-2002');

INSERT INTO Vehicles (VIN, make, model, year, SOLD, color, vehicleType, odometer, price) VALUES
('VIN12345678900001', 'Toyota', 'Camry', 2019, FALSE, 'Red', 'Sedan', 45000, 18000.00),
('VIN12345678900002', 'Ford', 'Mustang', 2020, FALSE, 'Blue', 'Coupe', 12000, 35000.00),
('VIN12345678900003', 'Honda', 'Civic', 2018, TRUE, 'Black', 'Sedan', 60000, 15000.00);

INSERT INTO Inventory (Dealership_id, VIN) VALUES
(1, 'VIN12345678900001'),
(1, 'VIN12345678900003'),
(2, 'VIN12345678900002');

INSERT INTO SalesContracts (VIN, sale_date, price) VALUES
('VIN12345678900003', '2024-09-10', 14999.99);

-- 1
SELECT * FROM dealerships;

-- 2
SELECT v.* FROM vehicles v
JOIN inventory i ON v.VIN = i.VIN
WHERE i.dealership_id = 1;

-- 3
SELECT * FROM vehicles
WHERE VIN = 'VIN12345678900001';

-- 4 
SELECT d.* FROM dealerships d
JOIN inventory i ON d.dealership_id = i.dealership_id
WHERE i.VIN = 'VIN12345678900001';

-- 5
SELECT DISTINCT d.* FROM dealerships d
JOIN inventory i ON d.dealership_id = i.dealership_id
JOIN vehicles v ON v.VIN = i.VIN
WHERE v.make = 'Ford'
  AND v.model = 'Mustang'
  AND v.color = 'Red';
  
  -- 6 
SELECT d.name,
       v.VIN,
       v.make,
       v.model,
       sc.sale_date,
       sc.price
FROM SalesContracts sc
JOIN Vehicles v ON sc.VIN = v.VIN
JOIN Inventory i ON v.VIN = i.VIN
JOIN Dealerships d ON i.dealership_id = d.dealership_id
WHERE d.dealership_id = 1
  AND sc.sale_date BETWEEN '2024-01-01' AND '2024-12-31';











