
-- Non-Correlated Subquery: Find all properties where the average rating is greater than 4.0.
-- Non correlated because the subquery does not depend on the outer query.
SELECT * FROM Property p WHERE p.property_id in  (SELECT r.property_id FROM Review r GROUP BY r.property_id HAVING AVG(r.rating) > 4.0);


-- Correlated Subquery: Find users who have made more than 3 bookings.
-- Correlated because the subquery depends on each row of the outer query (via u.user_id).
SELECT * from User u WHERE  (SELECT COUNT(b.booking_id) FROM Booking b WHERE b.user_id = u.user_id) > 3
