
# Analysis of Partitioned and Non-Partitioned Tables

## 1. Partitioned Table (`BookingPartioned`)

### EXPLAIN Output
```sql
EXPLAIN SELECT * FROM BookingPartioned WHERE start_date > '2024-11-27 00:00:00';
```

| id | select_type | table            | partitions    | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
|----|-------------|------------------|---------------|------|---------------|------|---------|------|------|----------|-------------|
|  1 | SIMPLE      | BookingPartioned | p2024q2,p2025 | ALL  | NULL          | NULL | NULL    | NULL |    5 |    33.33 | Using where |

### Explanation and Observations
- **Partitions Used**: The query utilizes partitions `p2024q2` and `p2025`, indicating partition pruning was applied to limit the search.
- **Rows Scanned**: Only 5 rows were scanned, which shows a significant reduction in the dataset being queried.
- **Filtered Rows**: 33.33% of the rows in the selected partitions matched the filter condition, suggesting effective pruning.
- **Extra Information**: The query condition `start_date > '2024-11-27 00:00:00'` applied using the `WHERE` clause indicates that partition pruning occurred, leading to optimized search performance.
- **Query Time**: Very fast (0.00 sec).

### Observations
- **Partitioning Benefits**: The use of partition pruning improved the query's efficiency by restricting the search space to specific partitions.
- **Performance**: This approach is well-suited for large datasets with time-based queries, enhancing performance by reducing the number of rows to scan.

---

## 2. Non-Partitioned Table (`Booking`)

### Table Structure
```sql
CREATE TABLE Booking (
    booking_id CHAR(36) PRIMARY KEY DEFAULT (UUID()), -- Primary key
    property_id CHAR(36) NOT NULL, -- Foreign key referencing Property
    user_id CHAR(36) NOT NULL, -- Foreign key referencing User
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_property FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);
```

### EXPLAIN Output
```sql
EXPLAIN SELECT * FROM Booking WHERE start_date > '2024-11-27 00:00:00';
```

| id | select_type | table   | partitions | type  | possible_keys     | key               | key_len | ref  | rows | filtered | Extra                 |
|----|-------------|---------|------------|-------|-------------------|-------------------|---------|------|------|----------|-----------------------|
|  1 | SIMPLE      | Booking | NULL       | range | idx_booking_dates | idx_booking_dates | 3       | NULL |    3 |   100.00 | Using index condition |

### Explanation and Observations
- **Indexes Used**: The `idx_booking_dates` index was utilized to filter rows based on the `start_date` condition.
- **Rows Scanned**: The query only scanned 3 rows, showing an efficient access pattern due to the index.
- **Filtered Rows**: 100% of the rows returned matched the filter, indicating precise query performance.
- **Extra Information**: The `Using index condition` suggests that the query utilized the index for efficient lookup.
- **Query Time**: Slightly slower (0.01 sec).


### Observations
- **Indexing Benefits**: The index on `start_date` allowed the query to efficiently locate relevant rows without scanning the entire table.
- **Performance**: For smaller datasets or highly selective queries, indexing provides a fast and effective solution. However, it may become less efficient for larger tables or broader scans.

---

### **Conclusion**
- **Partitioned Table**: Offers clear advantages for queries that filter data by date ranges, reducing the data scanned and improving efficiency for larger datasets.
- **Non-Partitioned Table**: Indexing on the `start_date` column is effective for range-based queries but may not perform as well as partitioning in large datasets.

Both approaches have their strengths, with partitioning providing a more scalable solution for large time-based datasets and indexing being more suitable for smaller or more selective queries.
