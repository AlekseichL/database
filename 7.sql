-- ����� users ����������� �� ����� ������ ������ orders
SELECT users.name, 
(select count(orders.id) from orders where orders.user_id=users.id) as total_order
FROM users
where (select count(orders.id) from orders where orders.user_id=users.id)>0
;

-- �������� ������ ������� products � �������� catalogs, ������� ������������� ������
SELECT (products.name) as �������������_������, (catalogs.name) as ���_������ 
FROM products, catalogs
where products.catalog_id=catalogs.id;