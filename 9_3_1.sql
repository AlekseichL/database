DROP function if exists hello;
delimiter //
CREATE function hello ()
returns text deterministic
begin
	if (CURTIME() between '00:00:00' and '06:00:00') THEN 
	return 'Доброй ночи';
	ELSEIF (CURTIME() between '06:00:00' and '12:00:00') THEN 
	return 'Доброе утро';
	ELSEIF (CURTIME() between '12:00:00' and '18:00:00') THEN 
	return 'Добрый день';
	ELSE  
	return 'Добрый вечер';
	end if;
end//

SELECT hello()//


