DROP function if exists hello;
delimiter //
CREATE function hello ()
returns text deterministic
begin
	if (CURTIME() between '00:00:00' and '06:00:00') THEN 
	return '������ ����';
	ELSEIF (CURTIME() between '06:00:00' and '12:00:00') THEN 
	return '������ ����';
	ELSEIF (CURTIME() between '12:00:00' and '18:00:00') THEN 
	return '������ ����';
	ELSE  
	return '������ �����';
	end if;
end//

SELECT hello()//


