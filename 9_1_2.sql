use shop;

-- представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs
CREATE or replace view cat AS SELECT products.id, (products.name) as 'товарная позиция', 
(catalogs.name) as 'позиция каталога' 
FROM products join catalogs on products.catalog_id = catalogs.id
;

select * from cat;