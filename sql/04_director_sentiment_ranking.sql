-- ===============================================================================
-- Director Review Sentiment Analysis & Window Ranking
-- Target: Evaluate positive/negative review distributions per director and rank them
-- ===============================================================================

-- 1. Yearly Positive Review Count per Director
SELECT 
    YEAR(a.creationDate) AS ReviewYear,
    b.director,
    COUNT(a.scoreSentiment) AS PositiveReviewCount
FROM rotten_tomatoes_movie_reviews a
JOIN rotten_tomatoes_movies b ON a.id = b.id
WHERE a.scoreSentiment = 'POSITIVE' AND b.director IS NOT NULL
GROUP BY YEAR(a.creationDate), b.director
ORDER BY ReviewYear DESC, PositiveReviewCount DESC;

-- 2. Ranking Top Directors by Positive vs. Negative Reviews (SQL Window Functions)
WITH PositiveSentiment AS (
    SELECT * FROM (
        SELECT 
            YEAR(a.creationDate) AS YR,
            b.director,
            COUNT(a.scoreSentiment) AS Cnt_Positive_score,
            ROW_NUMBER() OVER(PARTITION BY YEAR(a.creationDate) ORDER BY COUNT(a.scoreSentiment) DESC, b.director ASC) AS rn
        FROM rotten_tomatoes_movie_reviews a
        JOIN rotten_tomatoes_movies b ON a.id = b.id
        WHERE a.scoreSentiment = 'POSITIVE' AND b.director IS NOT NULL
        GROUP BY YEAR(a.creationDate), b.director
    ) x WHERE x.rn = 1
),
NegativeSentiment AS (
    SELECT * FROM (
        SELECT 
            YEAR(a.creationDate) AS YR,
            b.director,
            COUNT(a.scoreSentiment) AS Cnt_Negative_score,
            ROW_NUMBER() OVER(PARTITION BY YEAR(a.creationDate) ORDER BY COUNT(a.scoreSentiment) DESC, b.director ASC) AS rn
        FROM rotten_tomatoes_movie_reviews a
        JOIN rotten_tomatoes_movies b ON a.id = b.id
        WHERE a.scoreSentiment = 'NEGATIVE' AND b.director IS NOT NULL
        GROUP BY YEAR(a.creationDate), b.director
    ) x WHERE x.rn = 1
)
SELECT 
    pst.YR AS ReviewYear,
    pst.director AS TopPositiveDirector,
    pst.Cnt_Positive_score AS PositiveReviewCount,
    ISNULL(nv.Cnt_Negative_score, 0) AS NegativeReviewCount
FROM PositiveSentiment pst
LEFT JOIN NegativeSentiment nv ON pst.director = nv.director AND pst.YR = nv.YR
ORDER BY ReviewYear DESC;
