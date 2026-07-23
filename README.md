# 🍅 Rotten Tomatoes Movie Review & Sentiment Data Analysis

![SQL Server](https://img.shields.io/badge/Database-SQL%20Server-red?style=for-the-badge&logo=microsoftsqlserver)
![Data Analytics](https://img.shields.io/badge/Domain-Data%20Analytics-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge)

## 📌 Project Overview
This repository contains comprehensive T-SQL scripts and analytical queries designed to analyze movie trends, audience scores, genre runtime distributions, review volumes, and director sentiment dynamics from a dataset based on **Rotten Tomatoes** movies and user reviews.

---

## 🔍 Key Analytical Highlights

1. **Audience Score & Streaming Release Performance**:
   - Monthly and yearly trend analysis of top audience-rated movies.
   - Analysis of score distributions relative to streaming release dates.

2. **Quarterly Review Volume Tracking**:
   - Aggregation of review volumes across fiscal quarters (`DATEPART(quarter)`).
   - Identification of peak engagement periods and trending releases.

3. **Genre Runtime Exploration**:
   - Runtime normalization using string splitting (`STRING_SPLIT`) for multi-genre movies.
   - Average duration analysis per genre category.

4. **Director Sentiment Analysis & Ranking**:
   - Tracking positive vs. negative review sentiment (`scoreSentiment = 'POSITIVE' / 'NEGATIVE'`) grouped by director and creation year.
   - Advanced SQL window functions (`ROW_NUMBER() OVER (PARTITION BY yr ORDER BY cnt_positive_score DESC)`) to rank top directors annually by positive reception against negative feedback.

---

## 🛠️ Repository Structure & SQL Modules

```
rtomatoesAnalysis/
│
├── sql/
│   ├── 00_schema_and_views.sql           # Database schema, indexes & views
│   ├── 01_audience_score_analysis.sql   # Audience scores & streaming metrics
│   ├── 02_quarterly_review_trends.sql   # Quarterly review volume aggregations
│   ├── 03_genre_runtime_analysis.sql    # Genre runtime string-split metrics
│   └── 04_director_sentiment_ranking.sql# Director sentiment window rankings
│
├── rtomatoes_movie_review.sql           # Original consolidated T-SQL script
└── README.md                            # Project documentation
```

---

## 📊 Database Schema Overview

The analysis relies on two primary tables:

* **`rotten_tomatoes_movies`**: Contains `id`, `title`, `audienceScore`, `releaseDateStreaming`, `runtimeMinutes`, `genre`, `director`.
* **`rotten_tomatoes_movie_reviews`**: Contains `reviewId`, `id`, `creationDate`, `scoreSentiment`.

---

## 🚀 How to Execute Queries

1. Import your `rotten_tomatoes_movies` and `rotten_tomatoes_movie_reviews` tables into Microsoft SQL Server Management Studio (SSMS) or Azure Data Studio.
2. Run [`sql/00_schema_and_views.sql`](file:///d:/Kashyap/kash_repos/rtomatoesAnalysis/sql/00_schema_and_views.sql) to set up tables, performance indexes, and views.
3. Execute the analytical query modules in sequence (01 to 04) to view sentiment rankings and performance metrics.

---

## 👤 Author
Developed by **[Kashyap8may](https://github.com/Kashyap8may)**.
