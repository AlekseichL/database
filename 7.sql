-- имена users совершивших не менее одного заказа orders
SELECT users.name, 
(select count(orders.id) from orders where orders.user_id=users.id) as total_order
FROM users
where (select count(orders.id) from orders where orders.user_id=users.id)>0
;

-- ¬ыведите список товаров products и разделов catalogs, который соответствует товару
SELECT (products.name) as Ќаименорвание_товара, (catalogs.name) as “ип_товара 
FROM products, catalogs
where products.catalog_id=catalogs.id;