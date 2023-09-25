-- Вложенные Запросы
-- 1.Покажите название и длительность в секундах самой длинной песни применив округление по правилам математики. Столбец назвать sec.
select Name, round(Milliseconds/1000) as sec
 from Chinook.Track
where Milliseconds = (select max(Milliseconds) from chinook.track);

-- 2.Покажите все счёт-фактуры, стоимость которых ниже средней.
select * from Chinook.invoice
where total < (select avg(total) from Chinook.invoice);

-- 3.Покажите счёт-фактуру с высокой стоимостью.
select * from chinook.invoice 
where total = (select max(total) from chinook.invoice );

-- 4.Покажите города, в которых живут и сотрудники, и клиенты .
select city  from chinook.customer 
where city IN (select city from chinook.employee );

-- 5.Покажите имя, фамилию покупателя (номер 19), компанию и общую сумму его заказов. Столбец назовите sum.
select FirstName, LastName, Company, (select sum(total) from Chinook.Invoice where customerid = '19' ) as sum  from Chinook.Customer
where customerId = '19';

-- 6.Покажите сколько раз покупали треки композитора группы Queen.  Количество покупок необходимо посчитать по каждому треку. 
-- Вывести название, ИД трека и количество купленных треков композитора группы Queen. Столбец назовите total.

select Name, trackId, (select count(Chinook.InvoiceLine.TrackId) from Chinook.InvoiceLine where Chinook.InvoiceLine.TrackId = Chinook.Track.TrackId ) as total 
from chinook.track
where composer = 'Queen';

-- 7. Посчитайте колличество треков в каждом альбоме.В результате вывести имя альбома и кол-во треков.
select title , (select count(*) from chinook.track where track.albumid = album.albumId ) as count
from chinook.album;





