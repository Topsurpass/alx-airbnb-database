-- INNER JOIN: Retrieve all bookings and the respective users who made those bookings
SELECT b.booking_id, u.first_name, u.last_name, b.property_id, b.start_date, b.end_date, b.total_price, b.status FROM Booking b INNER JOIN User u ON b.user_id = u.user_id;

-- LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews
SELECT p.property_id, p.name AS property_name, p.description AS property_description, p.location, p.pricepernight, r.rating, r.comment FROM Property p LEFT JOIN Review r ON p.property_id = r.property_id;

-- FULL OUTER JOIN: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
SELECT u.user_id, u.first_name, u.last_name, b.booking_id, b.property_id, b.start_date, b.end_date, b.total_price, b.status FROM User u LEFT JOIN Booking b ON u.user_id = b.user_id 
UNION SELECT u.user_id, u.first_name, u.last_name, b.booking_id, b.property_id, b.start_date, b.end_date, b.total_price, b.status FROM User u RIGHT JOIN Booking b ON u.user_id = b.user_id;
