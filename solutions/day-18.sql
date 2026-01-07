-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

WITH fquiz AS (
  SELECT subject, MIN(quiz_date) AS first_quiz_date
  FROM daily_quiz_scores
  GROUP BY subject
),
lquiz AS (
  SELECT subject, MAX(quiz_date) AS last_quiz_date
  FROM daily_quiz_scores
  GROUP BY subject
),
fquiz_score AS (
  SELECT f.subject, d.score AS first_score
  FROM daily_quiz_scores d
  JOIN fquiz f
  ON d.subject = f.subject
  WHERE f.first_quiz_date = d.quiz_date
),
lquiz_score AS (
  SELECT l.subject, d.score AS last_score
  FROM daily_quiz_scores d
  JOIN lquiz l
  ON d.subject = l.subject
  WHERE l.last_quiz_date = d.quiz_date
)
SELECT fs.subject, fs.first_score, ls.last_score
FROM fquiz_score fs
JOIN lquiz_score ls
ON fs.subject = ls.subject
