# Steps to Measure Query Performance Using EXPLAIN or ANALYZE

Follow these steps to evaluate and improve query performance by adding indexes to your database schema.

---

## 1. **Before Adding Indexes**

### Step 1: Run the Query Without Indexes

- Use the `EXPLAIN` statement to analyze the query's execution plan before adding indexes.
- Example query:

```sql
EXPLAIN SELECT *
FROM Booking
WHERE user_id = 'a1b2c3d4-e5f6-7890-1234-56789abcdef0';
```

- Observe the output of the query execution plan:
  - Look for the number of rows scanned.
  - Identify if a full table scan is performed (this is often inefficient).

---

## 2. **Add Indexes**

### Step 2: Apply Indexes to High-Usage Columns

- Use the `CREATE INDEX` statements provided in the `database_index.sql` file to add indexes. Example:

```sql
CREATE INDEX idx_booking_user_id ON Booking(user_id);
```

- After creating the indexes, the database will use these indexes for optimized query execution.

---

## 3. **After Adding Indexes**

### Step 3: Re-run the Query With Indexes

- Use `EXPLAIN` or `ANALYZE` to analyze the query again after indexes have been added. Example:

```sql
ANALYZE SELECT *
FROM Booking
WHERE user_id = 'a1b2c3d4-e5f6-7890-1234-56789abcdef0';
```

- Observe the changes in the execution plan:
  - Check if the query now uses the index (look for an "Index Scan" instead of "Seq Scan").
  - Compare the query cost and the number of rows scanned before and after the index was added.

---

## Expected Results

### Without Indexes:

- **Execution Plan**: Full table scan.
- **Query Cost**: High.
- **Scanned Rows**: All rows in the table.

### With Indexes:

- **Execution Plan**: Index scan.
- **Query Cost**: Significantly lower.
- **Scanned Rows**: Only relevant rows matching the condition.

---

### Example Output (Postgres EXPLAIN)

Before Index:

```plaintext
Seq Scan on Booking  (cost=0.00..35.50 rows=1000 width=128)
Filter: (user_id = 'a1b2c3d4-e5f6-7890-1234-56789abcdef0')
```

After Index:

```plaintext
Index Scan using idx_booking_user_id on Booking  (cost=0.25..8.50 rows=10 width=128)
Index Cond: (user_id = 'a1b2c3d4-e5f6-7890-1234-56789abcdef0')
```

---

Save your observations to justify the indexes you create.
