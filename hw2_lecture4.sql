-- 1.Покажите клиентов с именем Френк.
SELECT * FROM Chinook.Customer
WHERE firstname = 'Frank';
-- 2.Покажите фамилии и имя клиентов, у которых имя Mарк.
SELECT FirstName,LastName FROM Chinook.Customer
WHERE firstname = 'Mark';
-- 3.Покажите название и размер треков в Мегабайтах, применив округление до 2 знаков и отсортировав по убыванию. Столбец назовите MB.
SELECT name, round(bytes /1048576,2) AS MB  FROM Chinook.Track
ORDER BY  MB DESC;

-- 4.Покажите возраст сотрудников, на момент оформления на работу. Вывести фамилию, имя, возраст. дату оформления и день рождения. Столбец назовите age.*
 SELECT LastName,FirstName,  floor(datediff(hiredate, birthdate) / 365) AS age, hiredate, BirthDate
 FROM Chinook.Employee;

-- 5.Покажите покупателей-американцев без факса.
SELECT * FROM Chinook.customer
WHERE country = 'USA' AND fax IS NULL;
-- 6.Покажите почтовые адреса клиентов из домена gmail.com.
SELECT firstname, lastname, email FROM Chinook.Customer
WHERE email LIKE '%gmail.com';
-- 7.Покажите в алфавитном порядке все уникальные должности в компании.
SELECT DISTINCT title  FROM Chinook.employee
ORDER BY title ASC;

-- 8.Покажите название самой короткой песни.

SELECT * FROM  Chinook.album
WHERE length(Title) = (SELECT min(length(Title)) FROM chinook.album);

-- 9.Покажите название и длительность в секундах самой короткой песни. Столбец назвать sec.
SELECT name, Milliseconds / 1000 AS sec FROM Chinook.track
ORDER BY sec
LIMIT 1;

SELECT name, Milliseconds AS sec FROM Chinook.track
WHERE Milliseconds = (SELECT min(Milliseconds) FROM Chinook.track) ;


-- 10.Покажите средний возраст сотрудников, работающих в компании*.
 SELECT AVG(floor(datediff(hiredate, birthdate) / 365)) AS avg_age
 FROM Chinook.Employee;

-- 11.Проведите аналитическую работу: узнайте фамилию, имя и компанию покупателя (номер 5). Сколько заказов он сделал и на какую сумму. Покажите 2 запроса Вашей работы.
SELECT lastname, firstname, company FROM chinook.customer
WHERE CustomerId = 5;

SELECT COUNT(invoicedate), sum(total) FROM invoice
WHERE CustomerId = 5;

-- 12. Напишите запрос, определяющий количество треков, где ID плейлиста > 15.
-- Назовите столбцы соответственно их расположения. 
SELECT playlistId AS 'Condition',COUNT(trackid) AS 'Result' FROM chinook.playlisttrack
GROUP BY playlistId
HAVING PlaylistId > 15;


