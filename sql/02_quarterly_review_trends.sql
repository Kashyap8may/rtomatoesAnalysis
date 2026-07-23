-- ===============================================================================
-- Quarterly Review Engagement Analysis
-- Target: Identify seasonal spikes and highest reviewed movies per quarter
-- ===============================================================================

-- 1. Quarterly Review Distribution Overview
SELECT 
    DATEPART(quarter, a.creationDate) AS QuarterOfYear,
    COUNT(a.reviewId) AS CountOfReviews
FROM rotten_tomatoes_movie_reviews a
JOIN rotten_tomatoes_movies b ON a.id = b.id
GROUP BY DATEPART(quarter, a.creationDate)
ORDER BY QuarterOfYear ASC;

-- 2. Detailed Movie Review Counts Grouped by Year and Quarter
SELECT 
    a.id,
    b.title,
    YEAR(a.creationDate) AS ReviewYear,
    DATEPART(quarter, a.creationDate) AS ReviewQuarter,
    COUNT(a.reviewId) AS CountOfReviews
FROM rotten_tomatoes_movie_reviews a
JOIN rotten_tomatoes_movies b ON a.id = b.id
GROUP BY a.id, b.title, YEAR(a.creationDate), DATEPART(quarter, a.creationDate)
ORDER BY ReviewYear DESC, ReviewQuarter DESC, CountOfReviews DESC;
