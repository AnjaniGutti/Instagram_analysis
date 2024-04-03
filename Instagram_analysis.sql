USE ig_clone;

#A) Marketing Analysis

#1 loyal users reward winners
SELECT*FROM users
ORDER BY created_at
limit 5;

#2 Inactive User Engagement
SELECT username FROM users
LEFT JOIN photos
ON users.id = photos.user_id
WHERE photos.id IS NULL;

#3 Contest Winner Declaration
SELECT username, photos.id, photos.image_url, 
	count(likes.user_id) as total_likes 
FROM photos
INNER JOIN likes
ON photos.id = likes.photo_id
INNER JOIN users
ON users.id = photos.user_id
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1;

#4 Hashtag Research
SELECT tags.tag_name, COUNT(*) AS total
FROM photo_tags
JOIN tags
ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total DESC
LIMIT 5;

#5 Ad Campaign Launch
SELECT DAYNAME(created_at) AS day, 
	COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 2;

#B) Investor Metrics:
#1 User engagement
SELECT 
	(SELECT COUNT(*) FROM photos)/ (SELECT COUNT(*) FROM users) 
	AS avg_posts;

#2 Bots & Fake Accounts
SELECT user_id, count(*) as likes_num
FROM likes
GROUP BY user_id
HAVING likes_num = (SELECT COUNT(*) FROM photos);
SELECT u.username, COUNT(*) as likes_num
FROM users u 
JOIN likes l ON u.id = l.user_id
GROUP BY u.id
HAVING likes_num =(SELECT COUNT(*) FROM photos);

