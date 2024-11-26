## Partitioning Large Tables

Test the performance of queries on the partitioned table (e.g., fetching bookings by date range).

### Fetching bookings by date range

```
SELECT *
FROM Booking_partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2024-06-30';
```

### Comparing quering performance

```
EXPLAIN SELECT *
FROM Booking_partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2024-06-30';
```

### Brief Report on Observed Improvements

#### Performance Observations

- The query execution time for fetching bookings within a specific date range was significantly reduced.
- The database only scanned the relevant partitions instead of the entire Booking table, leading to faster results.
- Indexing can be applied independently on each partition, further enhancing query speed for large datasets.

#### Limitations

- Partitioning increases complexity in managing the schema.
- Write operations might require additional considerations to ensure correct partition placement.

### Conclusion

This approach is especially beneficial for datasets with time-based queries and predictable date ranges.
