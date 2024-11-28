-- User Table
CREATE TABLE User (
    user_id CHAR(36) PRIMARY KEY DEFAULT (UUID()), -- Use CHAR(36) to store UUID
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    role ENUM('guest', 'host', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Property Table
CREATE TABLE Property (
    property_id CHAR(36) PRIMARY KEY DEFAULT (UUID()), -- Use CHAR(36) to store UUID
    host_id CHAR(36) NOT NULL, -- Foreign key referencing User (CHAR(36))
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_host FOREIGN KEY (host_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Booking Table
CREATE TABLE Booking (
    booking_id CHAR(36) PRIMARY KEY DEFAULT (UUID()), -- Use CHAR(36) to store UUID
    property_id CHAR(36) NOT NULL, -- Foreign key referencing Property (CHAR(36))
    user_id CHAR(36) NOT NULL, -- Foreign key referencing User (CHAR(36))
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_property FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Payment Table
CREATE TABLE Payment (
    payment_id CHAR(36) PRIMARY KEY DEFAULT (UUID()), -- Use CHAR(36) to store UUID
    booking_id CHAR(36) NOT NULL, -- Foreign key referencing Booking (CHAR(36))
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    CONSTRAINT fk_booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE
);

-- Review Table
CREATE TABLE Review (
    review_id CHAR(36) PRIMARY KEY DEFAULT (UUID()), -- Use CHAR(36) to store UUID
    property_id CHAR(36) NOT NULL, -- Foreign key referencing Property (CHAR(36))
    user_id CHAR(36) NOT NULL, -- Foreign key referencing User (CHAR(36))
    rating INTEGER CHECK (rating >= 1 AND rating <= 5) NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_review_property FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Message Table
CREATE TABLE Message (
    message_id CHAR(36) PRIMARY KEY DEFAULT (UUID()), -- Use CHAR(36) to store UUID
    sender_id CHAR(36) NOT NULL, -- Foreign key referencing User (CHAR(36))
    recipient_id CHAR(36) NOT NULL, -- Foreign key referencing User (CHAR(36))
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_sender FOREIGN KEY (sender_id) REFERENCES User(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_recipient FOREIGN KEY (recipient_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Indexes for Performance
CREATE INDEX idx_user_email ON User(email); -- Index on email for quick lookups
CREATE INDEX idx_property_location ON Property(location); -- Index on location for searches
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date); -- Index on booking dates
CREATE INDEX idx_review_property_user ON Review(property_id, user_id); -- Composite index for reviews
CREATE INDEX idx_message_sender_recipient ON Message(sender_id, recipient_id); -- Composite index for messages
