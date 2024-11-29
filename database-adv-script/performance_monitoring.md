# Query Analysis: JOIN Query Performance

## Query Used

```sql
EXPLAIN ANALYZE SELECT b.start_date, b.end_date, b.total_price, u.first_name, u.last_name, u.email, p.name AS property_name, p.location, pay.payment_id, pay.amount AS payment_amount,
pay.payment_method FROM Booking b JOIN User u ON b.user_id = u.user_id JOIN Property p ON b.property_id = p.property_id LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.start_date >= '2024-01-01' AND b.total_price > 100;
```

## EXPLAIN ANALYZE Output

```plaintext
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| EXPLAIN                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|  -> Nested loop left join  (cost=3.67 rows=1.67) (actual time=0.154..0.208 rows=5 loops=1)
    -> Nested loop inner join  (cost=3.08 rows=1.67) (actual time=0.141..0.174 rows=5 loops=1)
        -> Nested loop inner join  (cost=2.5 rows=1.67) (actual time=0.13..0.154 rows=5 loops=1)
            -> Table scan on p  (cost=0.75 rows=5) (actual time=0.0593..0.0636 rows=5 loops=1)
            -> Filter: ((b.start_date >= DATE'2024-01-01') and (b.total_price > 100.00))  (cost=0.257 rows=0.333) (actual time=0.0136..0.0142 rows=1 loops=5)
                -> Index lookup on b using fk_property (property_id=p.property_id)  (cost=0.257 rows=1) (actual time=0.0124..0.0129 rows=1 loops=5)
        -> Single-row index lookup on u using PRIMARY (user_id=b.user_id)  (cost=0.31 rows=1) (actual time=0.00349..0.00353 rows=1 loops=5)
    -> Index lookup on pay using fk_booking (booking_id=b.booking_id)  (cost=0.31 rows=1) (actual time=0.00439..0.00604 rows=1 loops=5)
 |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)
```

## Observations on the `EXPLAIN ANALYZE` Output

### Execution Plan Overview:

- The query uses a **nested loop join** strategy, iterating over each row from the outer table and matching rows in the inner tables.
- The execution includes multiple nested loop joins: a left join for `Booking` and `User`, an inner join for `Property`, and a left join for `Payment`.

### Detailed Steps:

1. **Table Scan on `Booking`**:
   - Sequential scan (`cost=0.75`) processes 5 rows with an actual execution time of `0.0294` to `0.0309` seconds.
2. **Single-Row Index Lookup on `User`**:
   - Uses the primary key (`user_id=b.user_id`) with a `cost=0.27`, taking `0.00278` to `0.00279` seconds per loop, processing 1 row at a time.
3. **Single-Row Index Lookup on `Property`**:
   - Utilizes the primary key (`property_id=b.property_id`) with a `cost=0.27`, and takes `0.00151` to `0.00154` seconds per loop.
4. **Index Lookup on `Payment`**:
   - Uses `fk_booking` index for `booking_id=b.booking_id` with a `cost=0.27`, processing 1 row per loop in `0.0031` to `0.00353` seconds.

### Performance Analysis:

- **Overall Cost and Efficiency**: The total cost is low (`cost=6`), and the actual processing time for 5 rows ranges from `0.0533` to `0.0751` seconds, indicating efficient performance.
- **Index Usage**: The use of indexes on `User`, `Property`, and `Payment` tables reduces lookup time and ensures efficient join operations.
- **Nested Loops**: Suitable for small datasets as shown, but performance should be monitored for larger datasets to ensure scalability.

### Considerations for Scaling:

- Evaluating additional or optimized indexes could further improve performance for larger datasets.
- Reviewing data distribution and considering query optimization strategies like partitioning or denormalization may be needed for complex scenarios.

## Conclusion

The query is optimized for small-scale data with the use of indexes, ensuring fast data retrieval and join operations. Further optimizations may be necessary for larger datasets to maintain performance.
