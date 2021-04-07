use shop;

-- �������������, ������� ������� �������� name �������� ������� �� ������� products � ��������������� �������� �������� name �� ������� catalogs
CREATE or replace view cat AS SELECT products.id, (products.name) as '�������� �������', 
(catalogs.name) as '������� ��������' 
FROM products join catalogs on products.catalog_id = catalogs.id
;

select * from cat;