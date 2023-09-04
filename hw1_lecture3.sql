-- HW
-- Покажите содержимое таблицы исполнителей (артистов)
select * from Chinook.artist;

-- Покажите фамилии и имена клиентов из города Лондон
select * from Chinook.Customer where city = "London";

-- Покажите продажи за 2012 год, со стоимостью продаж более 4 долларов
select * from Chinook.invoice
where invoicedate between '2012-01-01' and '2012-12-31' and total > 4;

-- Покажите дату продажи, адрес продажи, город в которую совершена продажа и стоимость покупки равную 8.91.
-- Присвоить названия столбцам InvoiceDate – Дата_Продажи, BillingAddress – Адрес_Продажи и BillingCity - Город_Продажи.
select InvoiceDate as Дата_Продажи ,BillingAddress as Адрес_Продажи  ,BillingCity as Город_Продажи , total
from Chinook.Invoice
where total = 8.91;

-- Покажите фамилии и имена сотрудников компании, нанятых в 2002 году и проживающих в городе Edmonton
select LastName,FirstName, HireDate
from Chinook.Employee
where HireDate between '2002-01-01 00:00:00' and '2002-12-31 00:00:00' and city = 'Edmonton';

-- Покажите канадские города, в которые были сделаны продажи в августе.

select BillingCity, InvoiceDate
from Chinook.Invoice
where billingcountry = 'Canada' and InvoiceDate like '%-08-%';

-- Покажите Фамилии и имена работников, нанятых в мае. Решите 2-мя способами:
-- используя оператор like
select LastName,FirstName,HireDate
from Chinook.Employee
where HireDate like '%-05-%';

-- используя форматирование даты*. 
select LastName,FirstName,  DATE_FORMAT( hiredate , ' %M %Y') as DateFormated
from Chinook.Employee
WHERE MONTH(HireDate) = 5 ;

-- Покажите фамилии и имена сотрудников, занимающих должность менеджера по продажам и ИТ менеджера. Решите задание двумя способами: 
-- используя оператор IN
select LastName,FirstName,Title
from Chinook.Employee
where title In ( 'Sales Manager', 'It Manager');
-- используя логические операции
select LastName,FirstName,Title
from Chinook.Employee
where title = 'Sales Manager' or title =  'It Manager';
