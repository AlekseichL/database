
-- ����������� ������ id = 1 �� ������� shop.users � ������� sample.users
START TRANSACTION; 
INSERT INTO sample.users (id, name) SELECT id, name FROM shop.users WHERE id = 1;
DELETE FROM shop.users where id=1;
commit;