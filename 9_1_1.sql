
-- Перемешение записи id = 1 из таблицы shop.users в таблицу sample.users
START TRANSACTION; 
INSERT INTO sample.users (id, name) SELECT id, name FROM shop.users WHERE id = 1;
DELETE FROM shop.users where id=1;
commit;