-- cоздание двух пользователей, которые имеют доступ к базе данных shop
CREATE user shop_read;
grant select on shop.* to shop_read;

CREATE user shop;
grant ALL on shop.* to shop;

select Host, User from mysql.user;
