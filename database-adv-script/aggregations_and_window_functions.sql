
--  Find the total number of bookings made by each user.
SELECT u.user_id, u.first_name, u.last_name, COUNT(b.booking_id) AS total_bookings FROM User u LEFT JOIN Booking b ON u.user_id = b.user_id GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;

-- Window Function with RANK: Rank properties based on the total number of bookings they have received
-- identify rows with the same rank and acknowledge ties in ranking.
SELECT p.property_id, p.name AS property_name, COUNT(b.booking_id) AS total_bookings, RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank FROM Property p LEFT JOIN Booking b 
ON p.property_id = b.property_id GROUP BY p.property_id, p.name ORDER BY booking_rank;

-- unique rank for each row and don't care about ties.
SELECT p.property_id, p.name AS property_name, COUNT(b.booking_id) AS total_bookings, ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank FROM Property p LEFT JOIN Booking b 
ON p.property_id = b.property_id GROUP BY p.property_id, p.name ORDER BY booking_rank;
