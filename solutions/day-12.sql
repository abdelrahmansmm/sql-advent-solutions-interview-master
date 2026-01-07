-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH daily_messages AS (
SELECT CAST(m.sent_at AS DATE) AS date, u.user_id, u.user_name, COUNT(*) AS num_messages
FROM npn_messages m
JOIN npn_users u
ON m.sender_id = u.user_id
GROUP BY CAST(m.sent_at AS DATE), u.user_id, u.user_name),
ranked_customers AS (
  SELECT *, DENSE_RANK() OVER(PARTITION BY date ORDER BY num_messages DESC) AS rank
  FROM daily_messages
)
SELECT *
FROM ranked_customers
WHERE rank = 1
ORDER BY date, user_id;
