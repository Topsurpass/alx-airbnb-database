-- ***************************************
-- Populate Sample Data: User Table
-- ***************************************
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
    (gen_random_uuid(), 'Alice', 'Johnson', 'alice@example.com', 'hashed_password_1', '1234567890', 'guest', DEFAULT),
    (gen_random_uuid(), 'Bob', 'Smith', 'bob@example.com', 'hashed_password_2', '0987654321', 'host', DEFAULT),
    (gen_random_uuid(), 'Charlie', 'Brown', 'charlie@example.com', 'hashed_password_3', '1112223333', 'admin', DEFAULT),
    (gen_random_uuid(), 'Diana', 'Prince', 'diana@example.com', 'hashed_password_4', '4445556666', 'guest', DEFAULT),
    (gen_random_uuid(), 'Ethan', 'Hunt', 'ethan@example.com', 'hashed_password_5', '7778889999', 'host', DEFAULT);

-- ***************************************
-- Populate Sample Data: Property Table
-- ***************************************
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
    (gen_random_uuid(), (SELECT user_id FROM User WHERE email = 'bob@example.com'), 'Cozy Apartment', 'A cozy apartment in downtown.', 'New York', 120.00, DEFAULT, DEFAULT),
    (gen_random_uuid(), (SELECT user_id FROM User WHERE email = 'bob@example.com'), 'Beach House', 'Beautiful beach house with ocean view.', 'San Francisco', 300.00, DEFAULT, DEFAULT),
    (gen_random_uuid(), (SELECT user_id FROM User WHERE email = 'ethan@example.com'), 'Luxury Villa', 'Exclusive villa with modern amenities.', 'Los Angeles', 500.00, DEFAULT, DEFAULT),
    (gen_random_uuid(), (SELECT user_id FROM User WHERE email = 'ethan@example.com'), 'Country Cottage', 'Charming cottage in the countryside.', 'Austin', 200.00, DEFAULT, DEFAULT),
    (gen_random_uuid(), (SELECT user_id FROM User WHERE email = 'bob@example.com'), 'Penthouse Suite', 'High-rise suite with city views.', 'Chicago', 350.00, DEFAULT, DEFAULT);

-- ***************************************
-- Populate Sample Data: Booking Table
-- ***************************************
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
    (gen_random_uuid(), 
        (SELECT property_id FROM Property WHERE name = 'Cozy Apartment'), 
        (SELECT user_id FROM User WHERE email = 'alice@example.com'), 
        '2024-12-01', '2024-12-05', 480.00, 'confirmed', DEFAULT),
    (gen_random_uuid(), 
        (SELECT property_id FROM Property WHERE name = 'Beach House'), 
        (SELECT user_id FROM User WHERE email = 'alice@example.com'), 
        '2024-12-10', '2024-12-15', 1500.00, 'pending', DEFAULT),
    (gen_random_uuid(), 
        (SELECT property_id FROM Property WHERE name = 'Luxury Villa'), 
        (SELECT user_id FROM User WHERE email = 'diana@example.com'), 
        '2024-11-01', '2024-11-07', 3500.00, 'confirmed', DEFAULT),
    (gen_random_uuid(), 
        (SELECT property_id FROM Property WHERE name = 'Country Cottage'), 
        (SELECT user_id FROM User WHERE email = 'charlie@example.com'), 
        '2024-11-15', '2024-11-18', 600.00, 'canceled', DEFAULT),
    (gen_random_uuid(), 
        (SELECT property_id FROM Property WHERE name = 'Penthouse Suite'), 
        (SELECT user_id FROM User WHERE email = 'diana@example.com'), 
        '2024-12-20', '2024-12-25', 1750.00, 'pending', DEFAULT);

-- ***************************************
-- Populate Sample Data: Payment Table
-- ***************************************
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
    (gen_random_uuid(), 
        (SELECT booking_id FROM Booking WHERE total_price = 480.00), 
        480.00, DEFAULT, 'credit_card'),
    (gen_random_uuid(), 
        (SELECT booking_id FROM Booking WHERE total_price = 1500.00), 
        1500.00, DEFAULT, 'paypal'),
    (gen_random_uuid(), 
        (SELECT booking_id FROM Booking WHERE total_price = 3500.00), 
        3500.00, DEFAULT, 'stripe'),
    (gen_random_uuid(), 
        (SELECT booking_id FROM Booking WHERE total_price = 600.00), 
        600.00, DEFAULT, 'credit_card'),
    (gen_random_uuid(), 
        (SELECT booking_id FROM Booking WHERE total_price = 1750.00), 
        875.00, DEFAULT, 'paypal'); -- Partial payment example

-- ***************************************
-- Populate Sample Data: Review Table
-- ***************************************
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
    (gen_random_uuid(), 
        (SELECT property_id FROM Property WHERE name = 'Cozy Apartment'), 
        (SELECT user_id FROM User WHERE email = 'alice@example.com'), 
        5, 'Amazing stay! Very comfortable and clean.', DEFAULT),
    (gen_random_uuid(), 
        (SELECT property_id FROM Property WHERE name = 'Beach House'), 
        (SELECT user_id FROM User WHERE email = 'alice@example.com'), 
        4, 'Beautiful view but could be better maintained.', DEFAULT),
    (gen_random_uuid(), 
        (SELECT property_id FROM Property WHERE name = 'Luxury Villa'), 
        (SELECT user_id FROM User WHERE email = 'diana@example.com'), 
        5, 'Perfect experience with great facilities.', DEFAULT),
    (gen_random_uuid(), 
        (SELECT property_id FROM Property WHERE name = 'Country Cottage'), 
        (SELECT user_id FROM User WHERE email = 'charlie@example.com'), 
        3, 'Nice location, but amenities need improvement.', DEFAULT),
    (gen_random_uuid(), 
        (SELECT property_id FROM Property WHERE name = 'Penthouse Suite'), 
        (SELECT user_id FROM User WHERE email = 'diana@example.com'), 
        4, 'Great view but overpriced.', DEFAULT);

-- ***************************************
-- Populate Sample Data: Message Table
-- ***************************************
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
    (gen_random_uuid(), 
        (SELECT user_id FROM User WHERE email = 'alice@example.com'), 
        (SELECT user_id FROM User WHERE email = 'bob@example.com'), 
        'Hi, is the Beach House available on my selected dates?', DEFAULT),
    (gen_random_uuid(), 
        (SELECT user_id FROM User WHERE email = 'bob@example.com'), 
        (SELECT user_id FROM User WHERE email = 'alice@example.com'), 
        'Yes, the Beach House is available. Let me know if you have any questions.', DEFAULT),
    (gen_random_uuid(), 
        (SELECT user_id FROM User WHERE email = 'diana@example.com'), 
        (SELECT user_id FROM User WHERE email = 'ethan@example.com'), 
        'Is the Luxury Villa wheelchair accessible?', DEFAULT),
    (gen_random_uuid(), 
        (SELECT user_id FROM User WHERE email = 'ethan@example.com'), 
        (SELECT user_id FROM User WHERE email = 'diana@example.com'), 
        'Yes, it is. Let me know if you need additional assistance.', DEFAULT),
    (gen_random_uuid(), 
        (SELECT user_id FROM User WHERE email = 'charlie@example.com'), 
        (SELECT user_id FROM User WHERE email = 'bob@example.com'), 
        'Can I check-in earlier at the Country Cottage?', DEFAULT);
