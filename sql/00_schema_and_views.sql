-- ===============================================================================
-- Database Schema, Tables, and Analytical Views for Rotten Tomatoes Dataset
-- Database Engine: Microsoft SQL Server (T-SQL)
-- ===============================================================================

-- 1. Table Definitions
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'rotten_tomatoes_movies')
BEGIN
    CREATE TABLE rotten_tomatoes_movies (
        id VARCHAR(255) PRIMARY KEY,
        title VARCHAR(500) NOT NULL,
        audienceScore INT NULL,
        releaseDateStreaming DATETIME NULL,
        runtimeMinutes INT NULL,
        genre VARCHAR(500) NULL,
        director VARCHAR(500) NULL
    );
END;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'rotten_tomatoes_movie_reviews')
BEGIN
    CREATE TABLE rotten_tomatoes_movie_reviews (
        reviewId INT IDENTITY(1,1) PRIMARY KEY,
        id VARCHAR(255) NOT NULL,
        creationDate DATETIME NOT NULL,
        scoreSentiment VARCHAR(50) NOT NULL,
        CONSTRAINT FK_Movie_Review FOREIGN KEY (id) REFERENCES rotten_tomatoes_movies(id)
    );
END;

GO

-- 2. Indexes for Query Performance Optimization
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_reviews_id_creation')
    CREATE INDEX IX_reviews_id_creation ON rotten_tomatoes_movie_reviews(id, creationDate);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_reviews_sentiment')
    CREATE INDEX IX_reviews_sentiment ON rotten_tomatoes_movie_reviews(scoreSentiment);

GO

-- 3. Analytical View: Annual Director Review Sentiment Summary
CREATE OR ALTER VIEW vw_director_sentiment_summary AS
SELECT 
    YEAR(r.creationDate) AS ReviewYear,
    m.director,
    COUNT(CASE WHEN r.scoreSentiment = 'POSITIVE' THEN 1 END) AS PositiveReviewCount,
    COUNT(CASE WHEN r.scoreSentiment = 'NEGATIVE' THEN 1 END) AS NegativeReviewCount,
    COUNT(r.reviewId) AS TotalReviewCount
FROM rotten_tomatoes_movie_reviews r
JOIN rotten_tomatoes_movies m ON r.id = m.id
WHERE m.director IS NOT NULL
GROUP BY YEAR(r.creationDate), m.director;

GO

-- 4. Analytical View: Quarterly Review Engagement
CREATE OR ALTER VIEW vw_quarterly_review_stats AS
SELECT 
    YEAR(creationDate) AS ReviewYear,
    DATEPART(quarter, creationDate) AS ReviewQuarter,
    COUNT(reviewId) AS TotalReviews
FROM rotten_tomatoes_movie_reviews
GROUP BY YEAR(creationDate), DATEPART(quarter, creationDate);

GO
