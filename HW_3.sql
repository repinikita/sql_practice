-- Вложенные Запросы
-- 1.Покажите название и длительность в секундах самой длинной песни применив округление по правилам математики. Столбец назвать sec.
SELECT Name, round(Milliseconds/1000) AS sec
FROM Chinook.Track
WHERE Milliseconds = (SELECT max(Milliseconds) FROM chinook.track);

-- 2.Покажите все счёт-фактуры, стоимость которых ниже средней.
SELECT * FROM Chinook.invoice
WHERE total < (SELECT avg(total) FROM Chinook.invoice);

-- 3.Покажите счёт-фактуру с высокой стоимостью.
SELECT * FROM chinook.invoice 
WHERE total = (SELECT max(total) FROM chinook.invoice );

-- 4.Покажите города, в которых живут и сотрудники, и клиенты .
SELECT city  FROM chinook.customer 
WHERE city IN (SELECT city FROM chinook.employee );

-- 5.Покажите имя, фамилию покупателя (номер 19), компанию и общую сумму его заказов. Столбец назовите sum.
SELECT FirstName, LastName, Company, (SELECT sum(total) FROM Chinook.Invoice WHERE customerid = '19' ) AS sum  FROM Chinook.Customer
WHERE customerId = '19';

-- 6.Покажите сколько раз покупали треки композитора группы Queen.  Количество покупок необходимо посчитать по каждому треку. 
-- Вывести название, ИД трека и количество купленных треков композитора группы Queen. Столбец назовите total.

SELECT Name, trackId, (SELECT COUNT(Chinook.InvoiceLine.TrackId) FROM Chinook.InvoiceLine WHERE Chinook.InvoiceLine.TrackId = Chinook.Track.TrackId ) AS total 
FROM chinook.track
WHERE composer = 'Queen';

-- 7. Посчитайте колличество треков в каждом альбоме.В результате вывести имя альбома и кол-во треков.
SELECT title , (SELECT COUNT(*) FROM chinook.track WHERE track.albumid = album.albumId ) AS COUNT
FROM chinook.album;





