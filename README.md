- interesting query -
- You can find all vehicles a dealership owns using only the VIN foreign key relationship
- SELECT v.*
FROM Vehicles v
JOIN Inventory i ON v.VIN = i.VIN
WHERE i.dealership_id = 1;
:) Thanks!
