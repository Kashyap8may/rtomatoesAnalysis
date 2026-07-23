-- ===============================================================================
-- Audience Score & Movie Rating Analysis
-- Target: Evaluate top audience-rated movies per month/year & streaming trends
-- ===============================================================================

-- 1. Highest Audience Scored Movie Per Month & Review Date Aggregations
SELECT 
    m.id,
    m.title,
    COUNT(MONTH(r.creationDate)) AS ReviewMonthCount,
    AVG(CAST(m.audienceScore AS FLOAT)) AS TopAudienceScore
FROM rotten_tomatoes_movies m 
JOIN rotten_tomatoes_movie_reviews r ON m.id = r.id
GROUP BY m.id, m.title
ORDER BY TopAudienceScore DESC;

-- 2. Review Date Range Discovery
SELECT DISTINCT 
    YEAR(creationDate) AS ReviewYear
FROM rotten_tomatoes_movie_reviews
ORDER BY ReviewYear ASC;

-- 3. Top Rated Movies Overall
SELECT DISTINCT 
    id,
    title,
    AVG(CAST(audienceScore AS FLOAT)) AS TopAudienceScore
FROM rotten_tomatoes_movies
GROUP BY id, title
ORDER BY TopAudienceScore DESC;

-- 4. Streaming Release Date Score Analysis
SELECT 
    m.id,
    m.title,
    m.audienceScore,
    YEAR(m.releaseDateStreaming) AS StreamingYear,
    MONTH(m.releaseDateStreaming) AS StreamingMonth
FROM rotten_tomatoes_movies m
WHERE m.releaseDateStreaming IS NOT NULL 
  AND m.audienceScore = (
      SELECT MAX(audienceScore) 
      FROM rotten_tomatoes_movies sub 
      WHERE YEAR(sub.releaseDateStreaming) = YEAR(m.releaseDateStreaming)
        AND MONTH(sub.releaseDateStreaming) = MONTH(m.releaseDateStreaming)
  )
ORDER BY StreamingYear DESC, StreamingMonth DESC;
