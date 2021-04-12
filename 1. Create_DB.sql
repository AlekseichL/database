CREATE DATABASE project;

USE project;

-- ������� ����������, �������������� � ������ ��������������
CREATE TABLE prepared_documents(
id SERIAL PRIMARY KEY,
reg_number VARCHAR(255) COMMENT '��������������� �����',
date_of_signing DATE COMMENT '���� ������� ���������',
author_id BIGINT unsigned,
thematics_id BIGINT unsigned,
title TINYTEXT COMMENT '���������',
document_text MEDIUMTEXT COMMENT '����� ���������'
);

-- ������� �������/������������ ��������������� (���������� � ������ ��������������)
CREATE TABLE author(
id SERIAL PRIMARY KEY,
surname TINYTEXT COMMENT '�������',
name TINYTEXT COMMENT '���',
patronymic TINYTEXT COMMENT '��������'
);

-- ������� ������� ��������������
CREATE TABLE thematics(
id SERIAL PRIMARY KEY,
thematics TINYTEXT COMMENT '�������� ��������������'
);

-- ������� �������� ����������
CREATE TABLE document_sources(
id SERIAL PRIMARY KEY,
reg_number VARCHAR(255) COMMENT '��������������� ����� ��������� ���������',
date_of_signing DATE COMMENT '���� ������� ���������',
author_ds_id BIGINT unsigned,
division_id BIGINT unsigned,
implementation_id BIGINT unsigned COMMENT '���������� � ��������� ��������������'
);

-- ������� ������� �������� ����������
CREATE TABLE author_document_sources(
id SERIAL PRIMARY KEY,
surname TINYTEXT COMMENT '������� ����������� ��������� ���������',
name TINYTEXT COMMENT '��� ����������� ��������� ���������',
patronymic TINYTEXT COMMENT '�������� ����������� ��������� ���������'
);

-- ������� ������������� �������������� ���� � ��������� ��������� ����������
CREATE TABLE divisions(
id SERIAL PRIMARY KEY,
division TINYTEXT COMMENT '�������� �������������'
);

-- ������� �������������� ���������
CREATE TABLE informing(
id SERIAL PRIMARY KEY,
prepared_documents_id BIGINT unsigned,
information_consumer tinyint COMMENT '������� ����������� ���������� ������������� ������',
supervising_department tinyint COMMENT '���������� �������������',
head_supervising_department tinyint COMMENT '���������� �������� �������������',
head_office_1 tinyint COMMENT '�������� ������������� 1',
head_office_2 tinyint COMMENT '�������� ������������� 2',
head_office_3 tinyint COMMENT '�������� ������������� 3',
head_office_4 tinyint COMMENT '�������� ������������� 4',
head_office_5 tinyint COMMENT '�������� ������������� 5'
);

-- ������� �������� ����� �� supervising_department � head_supervising_department (������ ���������� ����������� �����������)
CREATE TABLE feedback_sd(
id SERIAL PRIMARY KEY,
prepared_documents_id BIGINT unsigned,
document_evaluation_id BIGINT unsigned,
criteria_1 ENUM('��������������', '������������ ������������', '������������') COMMENT '�������� ������ ������������� ��������� �� ���������������',
criteria_2 ENUM('�� ��������', '������������ ��������', '��������', '����������� ��������') COMMENT '�������� ������ ������������� ��������� �� ������� ��������� ����',
criteria_3 ENUM('��������', '��������������� ����������', '����������') COMMENT '�������� ������ ������������� ��������� �� ������� ��������������� ����������',
criteria_4 ENUM('������', '�������', '�������') COMMENT '�������� ������ ������������� ��������� �� ���������� ����������'
);

-- ������� ������ ����������
CREATE TABLE document_evaluation(
id SERIAL PRIMARY KEY,
score TINYINT 
);

-- ������� ���������� ���������� ��������� � ����������� ���������������
CREATE TABLE implementation_inf(
id SERIAL PRIMARY KEY,
prepared_documents_id BIGINT unsigned,
implementer TINYTEXT COMMENT '�������� ��� ���������� ������������� ������������� ��������',
information_consumer TINYTEXT COMMENT '������� ����������� ���������� ������������������ �������� ��� ���������� ��������������'
);

-- ������� �������� ����� �� �������� ����������� ������������� ������
CREATE TABLE feedback_information_consumer(
id SERIAL PRIMARY KEY,
prepared_documents_id BIGINT unsigned,
reg_number VARCHAR(255) COMMENT '��������������� ����� ������',
date_of_signing DATE COMMENT '���� ������� ��������� ���������',
response_text TEXT
);

-- ������� ��������� � ��������
CREATE TABLE logs(
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
table_name varchar(50) NOT NULL, 
row_id BIGINT UNSIGNED NOT NULL,
date_update DATEtime default current_timestamp COMMENT '���� �������� ���������'
) ENGINE=Archive;

