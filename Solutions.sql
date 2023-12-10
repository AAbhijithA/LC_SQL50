/* Link to Problems: https://leetcode.com/studyplan/top-sql-50/ */

/*1*/
select product_id 
from Products 
where low_fats = 'Y' and recyclable = 'Y';

/*2*/
select name 
from Customer 
where referee_id is null or referee_id != 2;

/*3*/
select name, population, area 
from World 
where population >= 25000000 or area >= 3000000;

/*4*/
select distinct author_id as id 
from Views 
where author_id = viewer_id order by author_id; 

/*5*/
select tweet_id 
from Tweets 
where content like '________________%';
/*OR*/
select tweet_id 
from Tweets 
where CHAR_LENGTH(content) > 15;

/*6*/
select U.unique_id, E.name 
from Employees E left join EmployeeUNI U 
on U.id = E.id;

/*7*/
select product_name, year, price 
from Sales, Product 
where Sales.product_id = Product.product_id;

/*8*/
select customer_id, count(*) as count_no_trans 
from Visits 
where visit_id not in (select visit_id from Transactions) group by customer_id;

/*9*/
/* datediff() is a function that returns the number of days of difference between 2 dates */
select w1.id 
from Weather w1, Weather w2 
where datediff(w1.recordDate, w2.recordDate) = 1 and w1.temperature > w2.temperature;

/*10*/
/* ROUND() rounds it off to nearest decimal so here we needed to nearest 3rd decimal place */
select a.machine_id, ROUND(AVG(b.timestamp - a.timestamp),3) as processing_time 
from Activity a, Activity b 
where a.machine_id = b.machine_id and a.process_id = b.process_id and a.activity_type = 'start' and b.activity_type = 'end' 
group by a.machine_id; 

/*11*/
select T.* 
from (select E.name as name, B.bonus as bonus 
from Employee E left join Bonus B 
on E.empId = B.empId) T 
where T.bonus is null or T.bonus < 1000;

/*12 (Tricky)*/
select T.student_id, T.student_name, T.subject_name, count(E.student_id) as attended_exams 
from (select student_id, student_name, subject_name from Students, Subjects) T left join Examinations E 
on T.student_id = E.student_id and T.subject_name = E.subject_name 
group by T.student_id, T.subject_name 
order by T.student_id, T.subject_name;

/*13*/
select e.name 
from (select managerId, count(*) as dreport from Employee group by managerId) Sq, Employee e 
where Sq.managerId is not null and Sq.managerId = e.id and Sq.dreport >= 5; 

/*14 (Tricky)*/
/* Here you can write an if condition of eqality and what it must return if true or false */
select s.user_id, ROUND(AVG( if( c.action = "confirmed", 1, 0 ) ), 2) as confirmation_rate
from Signups s left join Confirmations c 
on s.user_id = c.user_id 
group by s.user_id;

/*15*/
select * from Cinema c 
where mod(c.id,2) = 1 and c.description != "boring" 
order by c.rating desc;

/*16*/
select p.product_id, if( ROUND( SUM(p.price*u.units) / SUM(u.units), 2 ) is null, 0, ROUND( SUM(p.price*u.units) / SUM(u.units), 2 ) ) as average_price
from Prices p left join UnitsSold u
on p.product_id = u.product_id and u.purchase_date >= p.start_date and u.purchase_date <= p.end_date 
group by p.product_id;

/*17*/
select p.project_id, ROUND(AVG(e.experience_years),2) as average_years
from Project p, Employee e
where p.employee_id = e.employee_id
group by p.project_id;

/*18*/
select * 
from (select r.contest_id, ROUND(count(u.user_id) * 100 / T.total, 2) as percentage
      from (select count(*) as total from Users) T, Users u left join Register r
      on u.user_id = r.user_id
      group by r.contest_id) fQ
where fQ.contest_id is not null
order by fQ.percentage desc, fQ.contest_id asc;

/*19*/
select q.query_name,
ROUND(AVG(q.rating / q.position), 2) as quality,
ROUND(SUM(if(q.rating < 3, 1, 0))*100 / COUNT(q.rating), 2) as poor_query_percentage
from Queries q
where q.query_name is not null
group by q.query_name; 

/*20*/
/* LEFT( string, x)  takes first x characters of string from left to right, RIGHT() works in the same way but opposite */
select LEFT(trans_date,7) as month, country, COUNT(*) as trans_count, 
SUM(if(state = 'approved', 1, 0)) as approved_count,
SUM(amount) as trans_total_amount,
SUM(if(state = 'approved',amount,0)) as approved_total_amount
from Transactions
group by month, country;

/*21*/
select ROUND(AVG(if(Sq.first_order_date = d.customer_pref_delivery_date,1,0))*100,2) as immediate_percentage
from (select customer_id, min(order_date) as first_order_date
      from Delivery
      group by customer_id) Sq, Delivery d 
where d.customer_id = Sq.customer_id and Sq.first_order_date = d.order_date;

/*22*/
select ROUND(count(distinct a1.player_id) / (select count(distinct player_id) from Activity),2) as fraction
from (select player_id as pid, min(event_date) as ed 
      from Activity 
      group by pid) FL, Activity a1
where a1.player_id = FL.pid and datediff(a1.event_date,FL.ed) = 1;

/*23*/
select teacher_id, count(distinct subject_id) as cnt 
from Teacher
group by teacher_id;

/*24*/
