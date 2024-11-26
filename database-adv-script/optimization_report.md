## Optimization Report

### Analyzing Query Performance

```
EXPLAIN SELECT b.booking_id, b.start_date, b.end_date, b.total_price, u.user_id, u.first_name, u.last_name, u.email, p.property_id, p.name AS property_name, p.location, pay.payment_id,
pay.amount AS payment_amount, pay.payment_method FROM Booking b JOIN User u ON b.user_id = u.user_id JOIN Property p ON b.property_id = p.property_id LEFT JOIN Payment pay
ON b.booking_id = pay.booking_id;

```

### Applying Indexes

```
-- Create index for User table on email (commonly used in searches and unique constraint)
CREATE UNIQUE INDEX idx_user_email ON User(email);

```

```
-- Create index for Booking table on user_id and property_id (frequently used in JOIN operations)
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);

```

```
-- Create index for Property table on location and pricepernight (commonly used in filtering or sorting)
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_pricepernight ON Property(pricepernight);

```

```
-- Create index for Review table on property_id (frequently used in JOIN and aggregation queries)
CREATE INDEX idx_review_property_id ON Review(property_id);

```

```
-- Create index for Payment table on booking_id (frequently used in JOIN operations)
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);

```

### Refactoring Query

Refactored Query: Optimize by reducing unnecessary data retrieval and ensuring indexes have been created on Booking(user_id), Booking(property_id), and Payment(booking_id)

```
SELECT b.booking_id, b.start_date, b.end_date, b.total_price, u.first_name, u.last_name, p.name AS property_name, pay.amount AS payment_amount, pay.payment_method FROM Booking b JOIN User u ON b.user_id = u.user_id JOIN Property p ON b.property_id = p.property_id LEFT JOIN Payment pay ON b.booking_id = pay.booking_id;

```

### Reanalyze Refactored Query and Compare

```
EXPLAIN SELECT b.booking_id, b.start_date, b.end_date, b.total_price, u.first_name, u.last_name, p.name AS property_name, pay.amount AS payment_amount, pay.payment_method FROM Booking b JOIN User u ON b.user_id = u.user_id JOIN Property p ON b.property_id = p.property_id LEFT JOIN Payment pay ON b.booking_id = pay.booking_id;
```

### Changes Nade

- Reduced columns retrieved to only the necessary ones (e.g., excluded user_id, property_id).
- Ensured indexes on user_id, property_id, and booking_id to optimize joins.
- Used LEFT JOIN for Payment to include bookings without payments.
