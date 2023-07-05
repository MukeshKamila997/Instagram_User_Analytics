select * from users
select * from photos
select * from comments
select * from likes
select * from follows
select * from tags
select * from photo_tags


--Marketing Metrics

/* We want to reward our users who have been around the longest.
Find the 5 oldest users */
select * from users 
order by created_at asc
limit 5
--or
select *, age(created_at) as loyal_users from users
order by loyal_users desc
limit 5


/* We want to target our inactive users with an email campaign.
Find the users who have never posted a single photo */
select username from users
left join photos
on users.id = photos.user_id
where photos.user_id is null;


/* We're hosting a contest to see the user who gets the most likes on a single photo. 
Identify the winner */
select users.username,
       photos.id,
	   photos.image_url,
       count(*) as total_likes
from photos
inner join likes
        on likes.photo_id = photos.id
inner join users
        on photos.user_id = users.id
group by users.username,photos.id
order by total_likes desc
limit 1;


/* A partner brand wants to know, which hashtags to use in a post.
Find out the top 5 most commonly used hashtags */ 
select tag_name,count(tag_name) as total
from tags
inner join photo_tags on tags.id = photo_tags.tag_id
group by tag_name
order by total desc
limit 5;


/* What day of the week do most users register on?
We need to find out, which day would be the best day to launch ADs */
select 
       to_char(created_at,'day') as day,
       count(*) as total
from users
group by day
order by total desc
limit 2;


--Investor Metrics

/* Our investors want to know if Instagram is performing well or not */
/* Find out how many times does average user posts on Instagram.
Also find out the total number of photos/total number of users */
select (select count(*) from photos) / (select count(*) from users) as avg;


/* If the platform is crowded with fake and dummy accounts.
Find users who have liked every single photo on the site */
select users.id,username,count(users.id) as total_num_of_likes
from users
join likes on users.id = likes.user_id
group by users.id
having count(users.id) = (select count(*) from photos)









