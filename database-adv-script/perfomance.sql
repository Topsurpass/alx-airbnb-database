-- Initial Query: Retrieve all bookings along with user details, property details, and payment details
SELECT b.start_date, b.end_date, b.total_price, u.first_name, u.last_name, u.email, p.name AS property_name, p.location, pay.payment_id, pay.amount AS payment_amount, 
pay.payment_method FROM Booking b JOIN User u ON b.user_id = u.user_id JOIN Property p ON b.property_id = p.property_id LEFT JOIN Payment pay ON b.booking_id = pay.booking_id 
WHERE b.start_date >= '2024-01-01' AND b.total_price > 100;


EXPLAIN SELECT b.start_date, b.end_date, b.total_price, u.first_name, u.last_name, u.email, p.name AS property_name, p.location, pay.payment_id, pay.amount AS payment_amount, 
pay.payment_method FROM Booking b JOIN User u ON b.user_id = u.user_id JOIN Property p ON b.property_id = p.property_id LEFT JOIN Payment pay ON b.booking_id = pay.booking_id 
WHERE b.start_date >= '2024-01-01' AND b.total_price > 100;