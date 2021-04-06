use vk;

-- суммарное количество лайков по половому признаку 
select count(likes.like_type) as total, gender.gender_info
from likes, profiles, gender
where (likes.user_id=profiles.user_id and
      profiles.gender_id=gender.id and
      likes.like_type=1)
GROUP by gender.gender_info
ORDER by total DESC;

-- пользователи и их возраст
select concat_ws(' ', profiles.first_name, profiles.last_name) as data_of_users, (TO_DAYS(NOW())-TO_DAYS(profiles.birthday))/365.25 as year 
from profiles
;
-- limit 10;

-- лайки пользователей разделенные по target_type
select concat_ws(' ', profiles.first_name, profiles.last_name) as data_of_users, 
(TO_DAYS(NOW())-TO_DAYS(profiles.birthday))/365.25 as year, 
(SELECT sum(coalesce(likes.like_type, 0)) FROM likes, messages
where ((likes.target_id=messages.id) 
and (messages.from_user_id=profiles.user_id) 
and (likes.like_type=1) 
and (likes.target_type_id=1))) as total_messages_likes,
(SELECT sum(coalesce(likes.like_type, 0)) FROM likes
where ((likes.target_id=profiles.user_id) 
and (likes.like_type=1) 
and (likes.target_type_id=2))) as total_users_likes,
(SELECT sum(coalesce(likes.like_type, 0)) FROM likes, media
where ((likes.target_id=media.id) 
and (media.user_id=profiles.user_id) 
and (likes.like_type=1) 
and (likes.target_type_id=3))) as total_media_likes,
(SELECT sum(coalesce(likes.like_type, 0)) FROM likes, posts
where ((likes.target_id=posts.id) 
and (posts.user_id=profiles.user_id) 
and (likes.like_type=1) 
and (likes.target_type_id=4))) as total_posts_likes
from profiles
order by 2
;

-- суммарное количество лайков 10 самых молодых пользователей пользователей по target_type  
select concat_ws(' ', profiles.first_name, profiles.last_name) as data_of_users, 
(TO_DAYS(NOW())-TO_DAYS(profiles.birthday))/365.25 as year, 
(COALESCE ((SELECT sum(coalesce(likes.like_type, 0)) FROM likes, messages
where ((likes.target_id=messages.id) 
and (messages.from_user_id=profiles.user_id) 
and (likes.like_type=1) 
and (likes.target_type_id=1))), 0)+COALESCE((SELECT sum(coalesce(likes.like_type, 0)) FROM likes
where ((likes.target_id=profiles.user_id) 
and (likes.like_type=1) 
and (likes.target_type_id=2))), 0)+COALESCE((SELECT sum(coalesce(likes.like_type, 0)) FROM likes, media
where ((likes.target_id=media.id) 
and (media.user_id=profiles.user_id) 
and (likes.like_type=1) 
and (likes.target_type_id=3))), 0)+COALESCE((SELECT sum(coalesce(likes.like_type, 0)) FROM likes, posts
where ((likes.target_id=posts.id) 
and (posts.user_id=profiles.user_id) 
and (likes.like_type=1) 
and (likes.target_type_id=4))),0)) as total_like
from profiles
order by year
LIMIT 10;

-- активность пользователей
select concat_ws(' ', profiles.first_name, profiles.last_name) as data_of_users, 
(SELECT count(likes.user_id) from likes where likes.user_id=profiles.user_id) as activity_on_likes,
(SELECT count(media.user_id) from media where media.user_id=profiles.user_id) as activity_on_media,
(SELECT count(posts.user_id) from posts where posts.user_id=profiles.user_id) as activity_on_posts,
(SELECT count(messages.from_user_id) from messages where messages.from_user_id=profiles.user_id) as activity_on_messages
from profiles
;

-- 10 пользователей с наименьшей активностью
select concat_ws(' ', profiles.first_name, profiles.last_name) as data_of_users,
(COALESCE((SELECT count(likes.user_id) from likes where likes.user_id=profiles.user_id), 0)+COALESCE((SELECT count(media.user_id) from media where media.user_id=profiles.user_id), 0)+COALESCE((SELECT count(posts.user_id) from posts where posts.user_id=profiles.user_id), 0)+COALESCE((SELECT count(messages.from_user_id) from messages where messages.from_user_id=profiles.user_id), 0)) as total_activity
from profiles
order by 2
LIMIT 10
;
