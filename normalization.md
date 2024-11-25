# Database Normalization to 3NF

## Principles of Normalization

1. **1NF (First Normal Form)**: Ensures that all tables have atomic (indivisible) values and no repeating groups.
2. **2NF (Second Normal Form)**: Removes partial dependencies—every non-key attribute must depend on the entire primary key.
3. **3NF (Third Normal Form)**: Removes transitive dependencies—non-key attributes must not depend on other non-key attributes.

## Steps Taken for Normalization

### 1. User Table

- Attributes are fully dependent on the primary key (`user_id`).
- No redundant data or transitive dependencies.

### 2. Property Table

- Attributes are fully dependent on the primary key (`property_id`).
- Foreign key `host_id` references `User(user_id)` and establishes a host-property relationship.

### 3. Booking Table

- Attributes are fully dependent on the primary key (`booking_id`).
- Foreign keys `property_id` and `user_id` establish relationships with `Property` and `User`.

### 4. Payment Table

- Attributes are fully dependent on the primary key (`payment_id`).
- Foreign key `booking_id` establishes the relationship with `Booking`.

### 5. Review Table

- Attributes are fully dependent on the primary key (`review_id`).
- Foreign keys `property_id` and `user_id` establish relationships with `Property` and `User`.

### 6. Message Table

- Attributes are fully dependent on the primary key (`message_id`).
- Foreign keys `sender_id` and `recipient_id` reference `User(user_id)`.

## Conclusion

The database schema adheres to **3NF**. Each table has:

- Atomic and unique values.
- No partial dependencies.
- No transitive dependencies.

No further normalization is required.
