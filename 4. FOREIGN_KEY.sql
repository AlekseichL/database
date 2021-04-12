USE project;
-- Создание внешних ключей
-- Таблица документов, подготовленных в рамках информирования
ALTER TABLE project.prepared_documents 
ADD CONSTRAINT prepared_documents_FK_author 
FOREIGN KEY (author_id) REFERENCES project.author(id);
ALTER TABLE project.prepared_documents 
ADD CONSTRAINT prepared_documents_FK_thematics 
FOREIGN KEY (thematics_id) REFERENCES project.thematics(id);

-- Таблица исходных материалов
ALTER TABLE project.document_sources 
ADD CONSTRAINT document_sources_FK_author_document_sources 
FOREIGN KEY (author_ds_id) REFERENCES project.author_document_sources(id);
ALTER TABLE project.document_sources 
ADD CONSTRAINT document_sources_FK_divisions 
FOREIGN KEY (division_id) REFERENCES project.divisions(id);
ALTER TABLE project.document_sources 
ADD CONSTRAINT document_sources_FK_prepared_documents 
FOREIGN KEY (implementation_id) REFERENCES project.prepared_documents(id) ON DELETE SET NULL;

-- Таблица информирования инстанций
ALTER TABLE project.informing
ADD CONSTRAINT informing_FK_prepared_documents
FOREIGN KEY (prepared_documents_id) REFERENCES project.prepared_documents(id) ON DELETE CASCADE;

-- Таблица обратной связи от supervising_department и head_supervising_department (оценка документов курирующими структурами)
ALTER TABLE project.feedback_sd 
ADD CONSTRAINT feedback_sd_FK_prepared_documents 
FOREIGN KEY (prepared_documents_id) REFERENCES project.prepared_documents(id) ON DELETE CASCADE;
ALTER TABLE project.feedback_sd 
ADD CONSTRAINT feedback_sd_FK_document_evaluation 
FOREIGN KEY (document_evaluation_id) REFERENCES project.document_evaluation(id) ON UPDATE CASCADE;

-- Таблица реализации документов головными и курирующими подразделениями
ALTER TABLE project.implementation_inf 
ADD CONSTRAINT implementation_inf_FK_prepared_documents 
FOREIGN KEY (prepared_documents_id) REFERENCES project.prepared_documents(id) ON DELETE CASCADE;

-- Таблица обратной связи от внешнего потребителя регионального уровня
ALTER TABLE project.feedback_information_consumer 
ADD CONSTRAINT feedback_information_consumer_FK_prepared_documents 
FOREIGN KEY (prepared_documents_id) REFERENCES project.prepared_documents(id) ON DELETE CASCADE;



