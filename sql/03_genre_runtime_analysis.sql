-- ===============================================================================
-- Genre & Runtime Analytics
-- Target: Split comma-separated genre lists and calculate average runtime by genre
-- ===============================================================================

-- 1. Average Runtime per Individual Movie Genre
SELECT 
    TRIM(value) AS IndividualGenre,
    AVG(CAST(runtimeMinutes AS FLOAT)) AS AvgRuntimeMinutes,
    COUNT(title) AS MovieCount
FROM rotten_tomatoes_movies
CROSS APPLY STRING_SPLIT(genre, ',')
WHERE runtimeMinutes IS NOT NULL AND runtimeMinutes > 0
GROUP BY TRIM(value)
ORDER BY AvgRuntimeMinutes DESC;

-- 2. Movie Duration Breakdown by Title & Primary Genre
SELECT 
    title,
    genre,
    AVG(CAST(runtimeMinutes AS FLOAT)) AS AVGRuntime
FROM rotten_tomatoes_movies
WHERE runtimeMinutes IS NOT NULL
GROUP BY title, genre
ORDER BY AVGRuntime DESC;
