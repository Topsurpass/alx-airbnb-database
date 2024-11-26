-- Create the partitioned Booking table in MySQL
CREATE TABLE BookingPartioned (
    booking_id UUID PRIMARY KEY, -- Primary key
    property_id UUID NOT NULL, -- Foreign key referencing Property
    user_id UUID NOT NULL, -- Foreign key referencing User
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_property FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2024q1 VALUES LESS THAN (2024),
    PARTITION p2024q2 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026)
);

-- Copy data from the existing Booking table to the new partitioned table
INSERT INTO BookingPartioned
SELECT * FROM Booking;

-- Drop the original Booking table (if necessary)
-- DROP TABLE Booking;

-- Rename the partitioned table to the original table name (if necessary)
-- ALTER TABLE BookingPartioned RENAME TO Booking;
