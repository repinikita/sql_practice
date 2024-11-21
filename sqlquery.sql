-- По данным из таблицы user_actions определите пять пользователей, сделавших в августе 2022 года наибольшее количество
заказов.Выведите две колонки — id пользователей и число оформленных ими заказов. Колонку с числом оформленных заказов
назовите created_orders.Результат отсортируйте сначала по убыванию числа заказов, сделанных пятью пользователями, затем 
по возрастанию id этих пользователей.Поля в результирующей таблице: user_id, created_orders

SELECT user_id,
   	count(distinct order_id) as created_orders
FROM   user_actions
WHERE  action = 'create_order'
   and date_part('month', time) = 8
   and date_part('year', time) = 2022
GROUP BY user_id
ORDER BY created_orders desc, user_id limit 5


-- Отберите пользователей женского пола из таблицы users. Выведите только id этих пользователей.
Результат отсортируйте по возрастанию id.Выведите только 1000 первых id из отсортированного списка.
Поле в результирующей таблице: user_id
SELECT user_id
FROM   users
WHERE  sex = 'female'
ORDER BY user_id limit 1000;


-- Напишите SQL-запрос к таблице couriers и выведите всю информацию о курьерах, у которых не указан их день рождения.
Результат должен быть отсортирован по возрастанию id курьера.Поля в результирующей таблице: birth_date, courier_id, sex. 
SELECT birth_date, courier_id, sex 
FROM couriers 
WHERE birth_date is null ORDER BY courier_id;

-- Из таблицы couriers отберите id всех курьеров, родившихся в период с 1990 по 1995 год включительно.
Результат отсортируйте по возрастанию id курьера.Поле в результирующей таблице: courier_id

SELECT courier_id 
FROM couriers 
WHERE date_part('year', birth_date) between 1990 and 1995 
ORDER BY courier_id;

-- Рассчитайте среднюю цену товаров в таблице products, в названиях которых присутствуют слова «чай» или «кофе». 
Любым известным способом исключите из расчёта товары, содержащие в названии «иван-чай» или «чайный гриб».
Среднюю цену округлите до двух знаков после запятой. Столбец с полученным значением назовите avg_price.
Поле в результирующей таблице: avg_price

SELECT round(avg(price), 2) as avg_price
FROM   products
WHERE  (name ilike '%чай%'
	or name ilike '%кофе%')
   and name not ilike '%иван-чай%'
   and name not ilike '%чайный гриб%';

-- Рассчитайте среднее количество товаров в заказах из таблицы orders, которые пользователи оформляли по выходным дням 
(суббота и воскресенье) в течение всего времени работы сервиса.Полученное значение округлите до двух знаков после запятой. 
Колонку с ним назовите avg_order_size.Поле в результирующей таблице: avg_order_size

SELECT round(avg(array_length(product_ids, 1)), 2) as avg_order_size
FROM   orders
WHERE  date_part('dow', creation_time) in (6, 0);

-- Посчитайте количество созданных и отменённых заказов в таблице user_actions.Новую колонку с числом заказов назовите orders_count.
Результат отсортируйте по числу заказов по возрастанию. Поля в результирующей таблице: action, orders_count
SELECT action,
   	count(order_id) as orders_count
FROM   user_actions
GROUP BY action
ORDER BY orders_count;

-- По данным в таблице users посчитайте максимальный порядковый номер месяца среди всех порядковых номеров месяцев рождения
пользователей сервиса. С помощью группировки проведите расчёты отдельно в двух группах — для пользователей мужского и женского пола.
Новую колонку с максимальным порядковым номером месяца рождения в группах назовите max_month. Преобразуйте значения в новой колонке в формат INTEGER, чтобы порядковый номер был выражен целым числом.Результат отсортируйте по колонке с полом пользователей.Поля в результирующей таблице: sex, max_month

SELECT sex,max(date_part('month', birth_date))::integer as max_month
FROM   users
GROUP BY sex
ORDER BY sex;

-- Посчитайте максимальный возраст пользователей мужского и женского пола в таблице users. 
Возраст измерьте числом полных лет.Новую колонку с возрастом назовите max_age.
Преобразуйте значения в новой колонке в формат INTEGER, чтобы возраст был выражен целым числом.
Результат отсортируйте по новой колонке по возрастанию возраста.Поля в результирующей таблице: sex, max_age

SELECT sex,
   	date_part('year', max(age(birth_date)))::integer as max_age
FROM   users
GROUP BY sex
ORDER BY max_age;

-- Выведите информацию о товарах в таблице products, цена на которые превышает среднюю цену всех товаров на 20 рублей и более.
Результат отсортируйте по убыванию id товара.Поля в результирующей таблице: product_id, name, price

SELECT product_id,name,price
FROM   products
WHERE  price >= (SELECT avg(price) FROM   products) + 20
ORDER BY product_id desc;

--Из таблицы user_actions с помощью подзапроса или табличного выражения отберите все заказы, которые не были отменены пользователями.
Выведите колонку с id этих заказов. Результат запроса отсортируйте по возрастанию id заказа.Добавьте в запрос оператор LIMIT и выведите только первые 1000 строк результирующей таблицы.Поле в результирующей таблице: order_id

SELECT order_id
FROM   user_actions 
WHERE  order_id not in (SELECT order_id FROM   user_actions WHERE  action = 'cancel_order')
ORDER BY order_id limit 1000;

-- Вывести все заказы Баранова Павла (id заказа, какие книги, по какой цене и в каком количестве он заказал) в отсортированном
по номеру заказа и названиям книг виде.

SELECT buy.buy_id, title, price,buy_book.amount
FROM buy
join buy_book on buy.buy_id=buy_book.buy_id
join book on book.book_id = buy_book.book_id
join client on client.client_id = buy.client_id
WHERE name_client ='Баранов Павел'
order by buy.buy_id,title;

-- Посчитать, сколько раз была заказана каждая книга, для книги вывести ее автора (нужно посчитать, в каком количестве заказов фигурирует каждая книга). 
Вывести фамилию и инициалы автора, название книги, последний столбец назвать Количество. Результат отсортировать сначала  по фамилиям авторов, а потом по названиям книг.

select author.name_author, book.title, count(buy_book.book_id) as Количество
from buy_book
right join book on book.book_id=buy_book.book_id
join author on author.author_id=book.author_id
group by author.name_author, book.title
order by author.name_author, book.title;

-- В таблице city для каждого города указано количество дней, за которые заказ может быть доставлен в этот город (рассматривается только этап "Транспортировка"). Для тех заказов, которые прошли этап транспортировки, вывести количество дней за которое заказ реально доставлен в город. А также, если заказ доставлен с опозданием, указать количество дней задержки, в противном случае вывести 0. В результат включить номер заказа (buy_id), а также вычисляемые столбцы Количество_дней и Опоздание. Информацию вывести в отсортированном по номеру заказа виде.

SELECT bs.buy_id, DATEDIFF(date_step_end, date_step_beg) AS 'Количество_дней', IF(DATEDIFF(date_step_end, date_step_beg)-city.days_delivery<0, 0, DATEDIFF(date_step_end, date_step_beg)-city.days_delivery) AS 'Опоздание' FROM buy_step AS bs
JOIN buy AS b ON bs.buy_id=b.buy_id
JOIN step AS s ON bs.step_id=s.step_id
JOIN client AS c ON b.client_id=c.client_id
JOIN city ON c.city_id=city.city_id
WHERE s.step_id=3 AND date_step_end IS NOT NULL;


