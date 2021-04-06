use vk;

SELECT g.gender_info, COUNT(l.id) as total_likes
FROM likes l 
JOIN profiles p on l.user_id = p.user_id 
JOIN gender g on g.id = p.gender_id 
where l.like_type = 1
GROUP BY p.gender_id 
ORDER BY total_likes DESC ;


SELECT sum(likes_count) as total_likes_youngest
From (
select p.user_id, p.birthday, count(l.id) as likes_count
FROM profiles p
left join likes l on l.target_id = p.user_id AND l.target_type_id = 2
GROUP by p.user_id 
ORDER by p.birthday DESC 
limit 10
) as total_likes;

select concat_ws(' ', p.first_name, p.last_name) as data_of_users,
(count(l.id)+
count(m.id)+
count(po.id)+
count(me.id)) as total_activity
from profiles p 
left join likes l on l.user_id=p.user_id
LEFT JOIN media m on m.user_id=p.user_id
LEFT JOIN posts po on po.user_id=p.user_id
LEFT JOIN messages me on me.from_user_id=p.user_id
group by data_of_users 
order by total_activity 
LIMIT 10
;
