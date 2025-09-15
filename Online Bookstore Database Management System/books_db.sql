-- Q1: Retrieve all books in the Fiction genre
select * from books;
select * from books 
where Genre='Fiction';
-- Q2: Retrieve books published after 1950
select * from books
where Published_Year > 1950;
-- Q3: Retrieve customers who are located in Canada
select name,country from customers
where country ='canada';
-- Q4: Retrieve all orders placed in November 2023
select * from orders_book 
where Order_Date between '2023-11-01' And '2023-11-30';
-- Q5a: Find the total stock of all books combined
select sum(stock) from books;
-- Q5b: Show each book’s title with its stock
select title,stock from books;
-- Q6a: Find the maximum book price
select max(price) as Expensive_book from books;
-- Q6b: Retrieve the book(s) with the maximum price including title and author
select title,author,price from books 
where price=(select max(price) from books);
-- OR
select title,author,price from books 
order by price Desc
limit 1; 
-- Q6c: Retrieve the top 5 most expensive books
select title,author,price as expensive_book from books 
order by price Desc
limit 5;
-- Q7: Retrieve all orders where quantity > 1
select * from orders_book
where Quantity>1;
-- Q8: Retrieve all orders where total amount > 250
select * from orders_book 
where Total_Amount>250;
-- Q9a: Show all unique genres of books
select distinct Genre As uniqur_Genre from books;
-- Q9b: Count how many unique genres exist
select count(distinct Genre) As total_unique_Genre from books;
-- Q10a: Find the book with the lowest stock
select min(Stock) As Lowest_Stock from books;
-- Q10b: List the 10 books with the lowest stock
select * from orders_book
order by stock Asc
limit 10;
-- Q11: Calculate the total revenue (sum of all orders)
select sum(Total_Amount) As Total_Revenue From orders_book;
-- *****Avance QUESTION****---
-- Q12: Retrieve total number of books sold for each genre

select genre,sum(ob.quantity) as total_book_sold from books b
join orders_book ob on b.book_id=ob.book_id
group by genre;
-- Q13: Find average price of books in the Fantasy genre

select avg(price) As Average_price from books
where Genre='Fantasy';
-- Q14: List customers who have placed at least 2 orders
select c.name,c.customer_id,count(o.order_id) As total_order from customers c
join orders_book o on c.customer_id=o.customer_id
group by c.name,c.customer_id
having total_order>=2
order by c.customer_id Asc;
-- Q15: Find the most frequently ordered book(s)
select b.Title,count(o.order_id) As total_order from books b
join orders_book o on b.book_id=o.book_id
group by b.title
order by total_order Desc;
-- Q16a: Find the maximum priced Fantasy book 
select title,Genre,(price) from books
where Genre='Fantasy'
order by price Desc;
-- Q16b: Show top 3 most expensive Fantasy books
SELECT * FROM books
WHERE genre='Fantasy'
ORDER BY price DESC 
LIMIT 3;
-- Q17: Retrieve total quantity of books sold by each author
select author,sum(o.quantity) as total_book_sold from books b
join orders_book o on b.Book_ID=o.Book_id
group by author;
-- Q18: List the cities of customers who spent more than 300
select * from customers;
select distinct c.city,total_amount  from customers c
join orders_book ob on c.Customer_ID=ob.Customer_ID
where Total_Amount>300;
-- Q19: Find the top 5 customers who spent the most

SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM orders_book o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC LIMIT 5;
-- Q20: Calculate remaining stock after fulfilling all orders
SELECT 
    b.book_id, 
    b.title, 
    b.stock,
    COALESCE(SUM(o.quantity),0) AS ORDERS,
    b.stock - COALESCE(SUM(o.quantity),0) AS rem_stock
FROM books b
LEFT JOIN orders_book o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock
ORDER BY b.book_id ASC
LIMIT 0, 1000;



