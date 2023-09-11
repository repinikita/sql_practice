-- 1.Покажите клиентов с именем Френк.
select * from Chinook.Customer
where firstname = 'Frank';
-- 2.Покажите фамилии и имя клиентов, у которых имя Mарк.
select FirstName,LastName from Chinook.Customer
where firstname = 'Mark';
-- 3.Покажите название и размер треков в Мегабайтах, применив округление до 2 знаков и отсортировав по убыванию. Столбец назовите MB.
select name, round(bytes /1048576,2) as MB  from Chinook.Track
order by  MB desc;

-- 4.Покажите возраст сотрудников, на момент оформления на работу. Вывести фамилию, имя, возраст. дату оформления и день рождения. Столбец назовите age.*
 select LastName,FirstName,  floor(datediff(hiredate, birthdate) / 365) AS age, hiredate, BirthDate
 from Chinook.Employee;

-- 5.Покажите покупателей-американцев без факса.
select * from Chinook.customer
where country = 'USA' and  fax is null;
-- 6.Покажите почтовые адреса клиентов из домена gmail.com.
select firstname, lastname, email from Chinook.Customer
where email like '%gmail.com';
-- 7.Покажите в алфавитном порядке все уникальные должности в компании.
select distinct title  from Chinook.employee
order by title asc;

-- 8.Покажите название самой короткой песни.

select * from  Chinook.album
where length(Title) = (select min(length(Title)) from chinook.album);

-- 9.Покажите название и длительность в секундах самой короткой песни. Столбец назвать sec.
select name, Milliseconds / 1000 as sec from Chinook.track
order by sec
limit 1;

select name, Milliseconds as sec  from Chinook.track
where Milliseconds = (select min(Milliseconds) from Chinook.track) ;


-- 10.Покажите средний возраст сотрудников, работающих в компании*.
 select  avg(floor(datediff(hiredate, birthdate) / 365)) as avg_age
 from Chinook.Employee;

-- 11.Проведите аналитическую работу: узнайте фамилию, имя и компанию покупателя (номер 5). Сколько заказов он сделал и на какую сумму. Покажите 2 запроса Вашей работы.
select lastname, firstname, company  from chinook.customer
where CustomerId = 5;

select count(invoicedate), sum(total) from invoice
where CustomerId = 5;

-- 12. Напишите запрос, определяющий количество треков, где ID плейлиста > 15.
-- Назовите столбцы соответственно их расположения. 
select playlistId as 'Condition'  ,count(trackid) as 'Result'  from chinook.playlisttrack
group by playlistId
having PlaylistId > 15;


