delimiter //
DROP TRIGGER IF EXISTS name_or_description_insert//
CREATE TRIGGER name_or_description_insert BEFORE INSERT ON products
FOR EACH ROW 
BEGIN 
	IF NEW.name is NULL AND NEW.description is NULL THEN 
	 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ѕол€ name и description принимают неопределенное значение NULL';
	END IF;
END//



