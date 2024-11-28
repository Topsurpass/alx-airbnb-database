-- Create the partitioned Booking table in MySQL
CREATE TABLE BookingPartioned (
    booking_id CHAR(36) NOT NULL, -- Primary key component
    property_id CHAR(36) NOT NULL, -- Reference to Property
    user_id CHAR(36) NOT NULL, -- Reference to User
    start_date DATE NOT NULL, -- Primary key component for partitioning
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date) -- Include start_date in the primary key
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2024q1 VALUES LESS THAN (2024),
    PARTITION p2024q2 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026)
);

-- Copy data from the existing Booking table to the new partitioned table
INSERT INTO BookingPartioned
SELECT booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at
FROM Booking;
