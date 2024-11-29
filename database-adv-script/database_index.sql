-- Create index for User table on email (commonly used in searches and ique constraint)
CREATE UNIQUE INDEX idx_user_email ON User(email);

-- Create index for Booking table on user_id and property_id (frequently used in JOIN operations)
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Create index for Property table on location and pricepernight (commonly used in filtering or sorting)
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_pricepernight ON Property(pricepernight);

-- Create index for Review table on property_id (frequently used in JOIN and aggregation queries)
CREATE INDEX idx_review_property_id ON Review(property_id);

-- Create index for Payment table on booking_id (frequently used in JOIN operations)
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);
