CREATE DATABASE project;

USE project;

-- Таблица документов, подготовленных в рамках информирования
CREATE TABLE prepared_documents(
id SERIAL PRIMARY KEY,
reg_number VARCHAR(255) COMMENT 'Регистрационный номер',
date_of_signing DATE COMMENT 'Дата подписи документа',
author_id BIGINT unsigned,
thematics_id BIGINT unsigned,
title TINYTEXT COMMENT 'Заголовок',
document_text MEDIUMTEXT COMMENT 'Текст документа'
);

-- Таблица авторов/исполнителей информированиий (документов в рамках информирования)
CREATE TABLE author(
id SERIAL PRIMARY KEY,
surname TINYTEXT COMMENT 'Фамилия',
name TINYTEXT COMMENT 'Имя',
patronymic TINYTEXT COMMENT 'Отчество'
);

-- Таблица тематик информирования
CREATE TABLE thematics(
id SERIAL PRIMARY KEY,
thematics TINYTEXT COMMENT 'Тематика информирования'
);

-- Таблица исходных материалов
CREATE TABLE document_sources(
id SERIAL PRIMARY KEY,
reg_number VARCHAR(255) COMMENT 'Регистрационный номер исходного документа',
date_of_signing DATE COMMENT 'Дата подписи документа',
author_ds_id BIGINT unsigned,
division_id BIGINT unsigned,
implementation_id BIGINT unsigned COMMENT 'Реализован в документе информирования'
);

-- Таблица авторов исходных материалов
CREATE TABLE author_document_sources(
id SERIAL PRIMARY KEY,
surname TINYTEXT COMMENT 'Фамилия исполнителя исходного документа',
name TINYTEXT COMMENT 'Имя исполнителя исходного документа',
patronymic TINYTEXT COMMENT 'Отчество исполнителя исходного документа'
);

-- Таблица подразделений осуществляющих сбор и первичную обработку информации
CREATE TABLE divisions(
id SERIAL PRIMARY KEY,
division TINYTEXT COMMENT 'Название подразделения'
);

-- Таблица информирования инстанций
CREATE TABLE informing(
id SERIAL PRIMARY KEY,
prepared_documents_id BIGINT unsigned,
information_consumer tinyint COMMENT 'Внешний потребитель информации регионального уровня',
supervising_department tinyint COMMENT 'Курирующее подразделение',
head_supervising_department tinyint COMMENT 'Курирующее головное подразделение',
head_office_1 tinyint COMMENT 'Головное подразделение 1',
head_office_2 tinyint COMMENT 'Головное подразделение 2',
head_office_3 tinyint COMMENT 'Головное подразделение 3',
head_office_4 tinyint COMMENT 'Головное подразделение 4',
head_office_5 tinyint COMMENT 'Головное подразделение 5'
);

-- Таблица обратной связи от supervising_department и head_supervising_department (оценка документов курирующими структурами)
CREATE TABLE feedback_sd(
id SERIAL PRIMARY KEY,
prepared_documents_id BIGINT unsigned,
document_evaluation_id BIGINT unsigned,
criteria_1 ENUM('Несвоевременно', 'Недостаточно своевременно', 'Своевременно') COMMENT 'Критерий оценки направленного документа на своевременность',
criteria_2 ENUM('Не раскрыто', 'Недостаточно раскрыто', 'Раскрыто', 'Всесторонне раскрыто') COMMENT 'Критерий оценки направленного документа на полноту раскрытия темы',
criteria_3 ENUM('Известно', 'Преимущественно неизвестно', 'Неизвестно') COMMENT 'Критерий оценки направленного документа на новизну предоставляемой информации',
criteria_4 ENUM('Низкая', 'Средняя', 'Высокая') COMMENT 'Критерий оценки направленного документа на значимость информации'
);

-- Таблица оценок документов
CREATE TABLE document_evaluation(
id SERIAL PRIMARY KEY,
score TINYINT 
);

-- Таблица реализации документов головными и курирующими подразделениями
CREATE TABLE implementation_inf(
id SERIAL PRIMARY KEY,
prepared_documents_id BIGINT unsigned,
implementer TINYTEXT COMMENT 'Головное или курирующее подразделение реализовавшее документ',
information_consumer TINYTEXT COMMENT 'Внешний потребитель информации проинформированный головным или курирующим подразделением'
);

-- Таблица обратной связи от внешнего потребителя регионального уровня
CREATE TABLE feedback_information_consumer(
id SERIAL PRIMARY KEY,
prepared_documents_id BIGINT unsigned,
reg_number VARCHAR(255) COMMENT 'Регистрационный номер ответа',
date_of_signing DATE COMMENT 'Дата подписи ответного документа',
response_text TEXT
);

-- Таблица изменений в таблицах
CREATE TABLE logs(
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
table_name varchar(50) NOT NULL, 
row_id BIGINT UNSIGNED NOT NULL,
date_update DATEtime default current_timestamp COMMENT 'Дата внесения изменений'
) ENGINE=Archive;

