
/*We want to reward our users who have been around the longest.  
Find the 5 oldest users.*/
SELECT *
FROM users
ORDER BY created_at
LIMIT 5;


/*What day of the week do most users register on?
We need to figure out when to schedule an ad campgain*/
SELECT DAYOFWEEK(created_at) AS day, COUNT(*) AS max_reg
FROM users
GROUP BY day
ORDER BY max_reg DESC;


/* An alternative to above solution would be as follows */
SELECT date_format(created_at,'%W') AS day, COUNT(*) AS max_reg
FROM users
GROUP BY 1
ORDER BY 2 DESC;


/*We want to target our inactive users with an email campaign.
Find the users who have never posted a photo*/
SELECT users.username AS "Inactive Users"
FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.user_id IS NULL; 


/*We're running a new contest to see who can get the most likes on a single photo.
WHO WON??!!*/
SELECT photos.id AS "User with most likes on a photo", users.username, COUNT(likes.photo_id) AS "No. of likes"
FROM photos
INNER JOIN likes ON photos.id = likes.photo_id
INNER JOIN users ON users.id = photos.user_id
GROUP BY photos.id
ORDER BY COUNT(likes.photo_id) DESC
LIMIT 1; 


/*Our Investors want to know...
How many times does the average user post?*/
/*Average user post= total number of photos/total number of users*/
SELECT (ROUND( (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users), 2) ) AS "Average user posts" ;


/*user ranking by postings higher to lower*/
SELECT users.username, COUNT(photos.id) AS "ranking"
FROM users
INNER JOIN photos ON users.id = photos.user_id
GROUP BY users.username
ORDER BY COUNT(photos.id) DESC ;


/*Total Posts per users */
SELECT users.username, COUNT(photos.*)
FROM users
INNER JOIN photos ON users.id = photos.user_id
GROUP BY users.username;
/* The above query results in total posts by username. If we want to list by only user_id then we can use the below query:
SELECT user_id, COUNT(id) AS "Total posts per user"
FROM photos
GROUP BY user_id; */

/*Total numbers of users who have posted at least one time */
SELECT COUNT(DISTINCT users.id) AS "Total users who have posted atleast once"
FROM users
INNER JOIN photos ON users.id = photos.user_id;

/* An alternative solution to the above would be as follows*/
SELECT COUNT(DISTINCT user_id) AS "Total users who have posted atleast once"
FROM photos;


/*A brand wants to know which hashtags to use in a post
What are the top 5 most commonly used hashtags?*/
SELECT tag_name , COUNT(tag_name) AS "No. of times tag used in post"
FROM tags
INNER JOIN photo_tags on tags.id = photo_tags.tag_id
GROUP BY photo_tags.tag_id
ORDER BY COUNT(tag_name) DESC
LIMIT 5;


/*We have a small problem with bots on our site...
Find users who have liked every single photo on the site*/
SELECT users.id,username, COUNT(users.id) As total_likes_by_user
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes_by_user = (SELECT COUNT(*) FROM photos);


/*We also have a problem with celebrities
Find users who have never commented on a photo*/
SELECT username
FROM users
LEFT JOIN comments ON comments.user_id = users.id 
WHERE comment_text IS NULL;
