--Analysis

 --1. highest audiance scroed movie per month?

 Select m.id,m.title,Count(Month(r.creationDate)) as DateOfReview, AVG(audienceScore) as TopAudienceScore from rotten_tomatoes_movies as m Join
			rotten_tomatoes_movie_reviews as r on m.id = r.id
			Group by m.id,m.title
			Order by 4 Desc;


Select DISTINCT YEAR(creationDate) from rotten_tomatoes_movie_reviews
Order by 1;

Select DISTINCT id,AVG(audienceScore) as TopAudienceScore from rotten_tomatoes_movies
Group by id
Order by 2 Desc;

Select Count(id), Count (DISTINCT id) from  rotten_tomatoes_movies


Select id, Count(id) from rotten_tomatoes_movies
group by id having Count(id) > 1;

Select * from rotten_tomatoes_movies
Where id IN ('$5_a_day','0s_and_1s','100_days_of_love');


Select DISTINCT id, (Select AVG(audienceScore) from rotten_tomatoes_movies) TopAudienceScore from rotten_tomatoes_movies
Where id IN ('$5_a_day','0s_and_1s','100_days_of_love')
Group by id
Order by 2 Desc;

Select id, audienceScore,YEAR(releaseDateStreaming) YR, MONTH(releaseDateStreaming) MN from
(Select MAX(audienceScore) TopAudienceScore, YEAR(releaseDateStreaming) YR, MONTH(releaseDateStreaming) MN
from
(select distinct id,audiencescore, releaseDateStreaming, title from rotten_tomatoes_movies) a
WHERE releaseDateStreaming IS NOT NULL
Group by YEAR(releaseDateStreaming),MONTH(releaseDateStreaming)
Order by 2) b JOIN

on a.id=b.id Self JOIN on

-- 2. highest number of reviewed movie per quarter?

 Select TOP 100 * from rotten_tomatoes_movie_reviews;

 Select TOP 100 * from rotten_tomatoes_movies;

 Select DATEPART(quarter,a.creationDate) QD, Count(a.reviewId) CountOfReviews from rotten_tomatoes_movie_reviews a
 Join rotten_tomatoes_movies b on a.id=b.id
 Group by DATEPART(quarter,a.creationDate)
 Order by 1,2;



 Select id,YEAR(creationDate) YR, DATEPART(quarter,creationDate) QD, Count(reviewId) CountOfReviews from rotten_tomatoes_movie_reviews
 Group by id,YEAR(creationDate),DATEPART(quarter,creationDate)
 Order by 2 Desc,3 Desc;



-- 3. on an avg which gener has more runtime;

 Select title,AVG(runtimeMinutes) AVGRuntime,genre from rotten_tomatoes_movies
 Cross Apply string_split(genre,',')
 Group by title,genre;

 --4. For Every year which director has more no of positives

 Select TOP 100 * from rotten_tomatoes_movie_reviews;

  Select TOP 100 * from rotten_tomatoes_movies;

  Select Year(a.creationDate) YR,b.director,Count (a.scoreSentiment) as ReviewSentiment from rotten_tomatoes_movie_reviews a
  JOIN rotten_tomatoes_movies b on a.id = b.id
  Where scoreSentiment = 'POSITIVE'
  Group by Year(a.creationDate),b.director
  Order by 3 Desc;


  -- neew find higest positive and negative for the same director in that year
  select pst.*,nv.YR,nv.Cnt_Negative_score
  from
  (
  select * from
  (select *,ROW_NUMBER() over(partition by yr order by cnt_positive_score desc,director asc) as rn from
  (Select Year(a.creationDate) YR,b.director,Count(a.scoreSentiment) as Cnt_Positive_score from rotten_tomatoes_movie_reviews a
  JOIN rotten_tomatoes_movies b on a.id = b.id
  Where scoreSentiment = 'POSITIVE'
  Group by Year(a.creationDate), b.director
  ) x ) y where y.rn=1) pst
  left join
  (select * from
  (select *,ROW_NUMBER() over(partition by yr order by Cnt_Negative_score desc,director asc) as rn from
 (
  Select Year(a.creationDate) YR,b.director,Count (a.scoreSentiment) as Cnt_Negative_score from rotten_tomatoes_movie_reviews a
  JOIN rotten_tomatoes_movies b on a.id = b.id
  Where scoreSentiment = 'NEGATIVE'
  Group by Year(a.creationDate),b.director
  ) x ) y where y.rn=1) nv on pst.director=nv.director



  Select Year(a.creationDate) YR,b.director,a.scoreSentiment from rotten_tomatoes_movie_reviews a
  JOIN rotten_tomatoes_movies b on a.id = b.id
  Where scoreSentiment = 'POSITIVE'
  Order by 3 Desc;
