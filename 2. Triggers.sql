use project;
delimiter //
DROP TRIGGER IF EXISTS insert_in_prepared_documents//
CREATE TRIGGER insert_in_prepared_documents BEFORE INSERT ON prepared_documents
FOR EACH ROW 
BEGIN 
	IF NEW.reg_number is NULL or NEW.date_of_signing is NULL or NEW.author_id is NULL or NEW.thematics_id is NULL or NEW.title is NULL or NEW.document_text is NULL THEN 
	 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Поля таблицы не могут принимать значение NULL';
	END IF;
END//

DROP TRIGGER IF EXISTS insert_in_document_sources//
CREATE TRIGGER insert_in_document_sources BEFORE INSERT ON document_sources
FOR EACH ROW 
BEGIN 
	IF NEW.reg_number is NULL or NEW.date_of_signing is NULL or NEW.author_ds_id is NULL or NEW.division_id is NULL 
	THEN 
	 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Поля таблицы (за исключением поля реализации документа) не могут принимать значение NULL';
	END IF;
END//


DROP TRIGGER IF EXISTS insert_in_informing//
CREATE TRIGGER insert_in_informing BEFORE INSERT ON informing
FOR EACH ROW 
BEGIN 
	IF new.prepared_documents_id<>1 and new.information_consumer<>1 and new.supervising_department<>1 and new.head_supervising_department<>1 and new.head_office_1<>1 and new.head_office_2<>1 and new.head_office_3<>1 and new.head_office_4<>1 and new.head_office_5<>1 THEN 
	 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'В полях адрестаов должно быть не менее одного значения равного 1';
	END IF;
END//

DROP TRIGGER IF EXISTS insert_in_logs_prepared_documents//
CREATE TRIGGER insert_in_logs_prepared_documents After INSERT ON prepared_documents
FOR EACH ROW
BEGIN 
	insert into logs values (NULL, 'INSERT prepared_documents', NEW.id, DEFAULT);
END//

DROP TRIGGER IF EXISTS update_in_logs_prepared_documents//
CREATE TRIGGER update_in_logs_prepared_documents After UPDATE ON prepared_documents
FOR EACH ROW
BEGIN 
	insert into logs values (NULL, 'UPDATE prepared_documents', NEW.id, DEFAULT);
END//

DROP TRIGGER IF EXISTS insert_in_logs_document_sources//
CREATE TRIGGER insert_in_logs_document_sources After INSERT ON document_sources
FOR EACH ROW
BEGIN 
	insert into logs values (NULL, 'INSERT document_sources', NEW.id, DEFAULT);
END//

DROP TRIGGER IF EXISTS update_in_logs_document_sources//
CREATE TRIGGER update_in_logs_document_sources After UPDATE ON document_sources
FOR EACH ROW
BEGIN 
	insert into logs values (NULL, 'UPDATE document_sources', NEW.id, DEFAULT);
END//
