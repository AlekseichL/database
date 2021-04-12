use project;

-- 1. вывод колличества документов и средний бал (данные для оценки качества работы аналитиков) {Могу переписать с использованием join, однако мне удобней работать не испольуя его}
SELECT CONCAT_WS(' ', author.surname, author.name, author.patronymic) as ФИО , 
count(feedback_sd.prepared_documents_id) as 'Количество документов в адрес головного курирующего подразделения', 
(SELECT  count(feedback_sd.prepared_documents_id) 
from prepared_documents, informing, feedback_sd
where (feedback_sd.prepared_documents_id=informing.prepared_documents_id) 
and (author.id = prepared_documents.author_id) 
and (prepared_documents.id = informing.prepared_documents_id)
and (informing.supervising_department=1)) as 'Количество документов в адрес регионального курирующего подразделения',
(((SELECT  COALESCE((count(feedback_sd.prepared_documents_id))*document_evaluation.score, 0)
from prepared_documents, informing, feedback_sd, document_evaluation 
where (feedback_sd.prepared_documents_id=informing.prepared_documents_id)
and (document_evaluation.id=feedback_sd.document_evaluation_id)
and (author.id = prepared_documents.author_id) 
and (prepared_documents.id = informing.prepared_documents_id)
and (feedback_sd.document_evaluation_id=1))+
(SELECT  COALESCE((count(feedback_sd.prepared_documents_id))*document_evaluation.score, 0)
from prepared_documents, informing, feedback_sd, document_evaluation 
where (feedback_sd.prepared_documents_id=informing.prepared_documents_id)
and (document_evaluation.id=feedback_sd.document_evaluation_id)
and (author.id = prepared_documents.author_id) 
and (prepared_documents.id = informing.prepared_documents_id)
and (feedback_sd.document_evaluation_id=2))+
(SELECT  COALESCE((count(feedback_sd.prepared_documents_id))*document_evaluation.score, 0)
from prepared_documents, informing, feedback_sd, document_evaluation 
where (feedback_sd.prepared_documents_id=informing.prepared_documents_id)
and (document_evaluation.id=feedback_sd.document_evaluation_id)
and (author.id = prepared_documents.author_id) 
and (prepared_documents.id = informing.prepared_documents_id)
and (feedback_sd.document_evaluation_id=3))+
(SELECT  COALESCE((count(feedback_sd.prepared_documents_id))*document_evaluation.score, 0)
from prepared_documents, informing, feedback_sd, document_evaluation 
where (feedback_sd.prepared_documents_id=informing.prepared_documents_id)
and (document_evaluation.id=feedback_sd.document_evaluation_id)
and (author.id = prepared_documents.author_id) 
and (prepared_documents.id = informing.prepared_documents_id)
and (feedback_sd.document_evaluation_id=4))+
(SELECT  COALESCE ((count(feedback_sd.prepared_documents_id))*document_evaluation.score, 0)
from prepared_documents, informing, feedback_sd, document_evaluation 
where (feedback_sd.prepared_documents_id=informing.prepared_documents_id)
and (document_evaluation.id=feedback_sd.document_evaluation_id)
and (author.id = prepared_documents.author_id) 
and (prepared_documents.id = informing.prepared_documents_id)
and (feedback_sd.document_evaluation_id=5))+
(SELECT  COALESCE((count(feedback_sd.prepared_documents_id))*document_evaluation.score, 0)
from prepared_documents, informing, feedback_sd, document_evaluation 
where (feedback_sd.prepared_documents_id=informing.prepared_documents_id)
and (document_evaluation.id=feedback_sd.document_evaluation_id)
and (author.id = prepared_documents.author_id) 
and (prepared_documents.id = informing.prepared_documents_id)
and (feedback_sd.document_evaluation_id=6)))/(count(feedback_sd.prepared_documents_id) + (SELECT  count(feedback_sd.prepared_documents_id) 
from prepared_documents, informing, feedback_sd
where (feedback_sd.prepared_documents_id=informing.prepared_documents_id) 
and (author.id = prepared_documents.author_id) 
and (prepared_documents.id = informing.prepared_documents_id)
and (informing.supervising_department=1)))) as 'Средняя ценность документа'
from prepared_documents, author, informing, feedback_sd
where (feedback_sd.prepared_documents_id=informing.prepared_documents_id) 
and (author.id = prepared_documents.author_id) 
and (prepared_documents.id = informing.prepared_documents_id)
and (informing.head_supervising_department=1)
group by prepared_documents.author_id;


-- обратная связь с отделами, как элемент системы отчетности
SELECT divisions.division, CONCAT_WS(' от ', prepared_documents.reg_number, date_format(prepared_documents.date_of_signing, '%d.%m.%Y')) as Rekvizit_inf,
CONCAT_WS(' от ', document_sources.reg_number, date_format(document_sources.date_of_signing, '%d.%m.%Y')) as Rekvisit_istoch
from prepared_documents
join document_sources on document_sources.implementation_id = prepared_documents.id
join divisions on document_sources.division_id = divisions.id
WHERE prepared_documents.date_of_signing BETWEEN '2021.03.01' AND '2021.03.31'
ORDER by divisions.division 
;

DROP procedure if exists feedback;
delimiter //
CREATE procedure feedback (in Date1 date, in date2 date)
begin
	SELECT divisions.division, CONCAT_WS(' от ', prepared_documents.reg_number, date_format(prepared_documents.date_of_signing, '%d.%m.%Y')) as Rekvizit_inf,
    CONCAT_WS(' от ', document_sources.reg_number, date_format(document_sources.date_of_signing, '%d.%m.%Y')) as Rekvisit_istoch
    from prepared_documents
    join document_sources on document_sources.implementation_id = prepared_documents.id
    join divisions on document_sources.division_id = divisions.id
    WHERE prepared_documents.date_of_signing BETWEEN date1 AND date2
    ORDER by divisions.division;
end//

call feedback('2021.03.01', '2021.03.31');

-- представление созданное для контроляза соблюдением срока подготовки ответа внешним потребителем регионального уровня
drop view if exists inf_con;
CREATE view inf_con as SELECT CONCAT_WS(' от ', prepared_documents.reg_number, date_format(prepared_documents.date_of_signing, '%d.%m.%Y')) as Rekvizit, 
COALESCE (DATEDIFF(feedback_information_consumer.date_of_signing, prepared_documents.date_of_signing), DATEDIFF(NOW(), prepared_documents.date_of_signing)) as Srok_podgotovki_otveta
from prepared_documents, feedback_information_consumer
where feedback_information_consumer.prepared_documents_id = prepared_documents.id
;
-- использование 
select * from inf_con where Srok_podgotovki_otveta>30;

-- Участие сотрудников подразделений в информировании внешних и внутренних потребителей
drop view if exists sotr_div;
CREATE view sotr_div as SELECT CONCAT_WS(' ', author_document_sources.surname, author_document_sources.name, author_document_sources.patronymic)as SNP,
(select count(document_sources.implementation_id) 
from document_sources
join prepared_documents on prepared_documents.id=document_sources.implementation_id
join informing on informing.prepared_documents_id=prepared_documents.id
where (author_document_sources.id=document_sources.author_ds_id)
and (informing.information_consumer=1))as information_consumer,
(select count(document_sources.implementation_id) 
from document_sources
join prepared_documents on prepared_documents.id=document_sources.implementation_id
join informing on informing.prepared_documents_id=prepared_documents.id
where (author_document_sources.id=document_sources.author_ds_id)
and (informing.supervising_department=1))as supervising_department,
(select count(document_sources.implementation_id) 
from document_sources
join prepared_documents on prepared_documents.id=document_sources.implementation_id
join informing on informing.prepared_documents_id=prepared_documents.id
where (author_document_sources.id=document_sources.author_ds_id)
and (informing.head_supervising_department =1))as head_supervising_department
From author_document_sources
;
-- использование
select * from sotr_div;
select * from sotr_div where SNP like 'Петро%';