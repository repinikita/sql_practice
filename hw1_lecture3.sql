-- HW
-- Покажите содержимое таблицы исполнителей (артистов)
SELECT * FROM Chinook.artist;

-- Покажите фамилии и имена клиентов из города Лондон
SELECT * FROM Chinook.Customer WHERE city = "London";

-- Покажите продажи за 2012 год, со стоимостью продаж более 4 долларов
SELECT * FROM Chinook.invoice
WHERE invoicedate BETWEEN '2012-01-01' AND '2012-12-31' AND total > 4;

-- Покажите дату продажи, адрес продажи, город в которую совершена продажа и стоимость покупки равную 8.91.
-- Присвоить названия столбцам InvoiceDate – Дата_Продажи, BillingAddress – Адрес_Продажи и BillingCity - Город_Продажи.
SELECT InvoiceDate AS Дата_Продажи ,BillingAddress AS Адрес_Продажи  ,BillingCity AS Город_Продажи , total
FROM Chinook.Invoice
WHERE total = 8.91;

-- Покажите фамилии и имена сотрудников компании, нанятых в 2002 году и проживающих в городе Edmonton
SELECT LastName,FirstName, HireDate
FROM Chinook.Employee
WHERE HireDate BETWEEN '2002-01-01 00:00:00' AND '2002-12-31 00:00:00' AND city = 'Edmonton';

-- Покажите канадские города, в которые были сделаны продажи в августе.

SELECT BillingCity, InvoiceDate
FROM Chinook.Invoice
WHERE billingcountry = 'Canada' AND InvoiceDate LIKE '%-08-%';

-- Покажите Фамилии и имена работников, нанятых в мае. Решите 2-мя способами:
-- используя оператор like
SELECT LastName,FirstName,HireDate
FROM Chinook.Employee
WHERE HireDate LIKE '%-05-%';

-- используя форматирование даты*. 
SELECT LastName,FirstName,  DATE_FORMAT( hiredate , ' %M %Y') AS DateFormated
FROM Chinook.Employee
WHERE MONTH(HireDate) = 5 ;

-- Покажите фамилии и имена сотрудников, занимающих должность менеджера по продажам и ИТ менеджера. Решите задание двумя способами: 
-- используя оператор IN
SELECT LastName,FirstName,Title
FROM Chinook.Employee
WHERE title IN ( 'Sales Manager', 'It Manager');
-- используя логические операции
SELECT LastName,FirstName,Title
FROM Chinook.Employee
WHERE title = 'Sales Manager' OR title =  'It Manager';
