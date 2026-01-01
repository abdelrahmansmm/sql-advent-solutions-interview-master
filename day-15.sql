-- SQL Advent Calendar - Day 15
-- Title: The Grinch's Mischief Tracker
-- Difficulty: hard
--
-- Question:
-- The Grinch is tracking his daily mischief scores to see how his behavior changes over time. Can you find how many points his score increased or decreased each day compared to the previous day?
--
-- The Grinch is tracking his daily mischief scores to see how his behavior changes over time. Can you find how many points his score increased or decreased each day compared to the previous day?
--

-- Table Schema:
-- Table: grinch_mischief_log
--   log_date: DATE
--   mischief_score: INTEGER
--

-- My Solution:

WITH scores AS (
  SELECT *, LAG(mischief_score) OVER(ORDER BY log_date ASC) AS prev_score 
  FROM grinch_mischief_log
)
SELECT log_date, mischief_score, (mischief_score - prev_score)
FROM scores
