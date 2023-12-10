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
select activity_date as day, count(distinct user_id) as active_users
from Activity 
where datediff('2019-07-27',activity_date) < 30 and activity_date <= '2019-07-27'
group by day;

/*25*/
select s.product_id, fs.myear as first_year, s.quantity, s.price
from (select product_id, min(year) as myear 
      from Sales group by product_id) fs, Sales s
where fs.product_id = s.product_id and fs.myear = s.year;

/*26*/
select class 
from Courses 
group by class having count(*) >= 5;

/*27*/
select user_id, count(*) as followers_count
from Followers
group by user_id
order by user_id;

/*28*/
select max(T.num) as num 
from (select num 
from MyNumbers 
group by num having count(*) = 1) T;

/*29*/
select T.customer_id
from (select customer_id from Customer 
group by customer_id, product_key) T
group by customer_id
having count(*) = (select count(*) from Product);

/*30*/
select e1.employee_id, e1.name, count(*) as reports_count, ROUND(AVG(e2.age),0) as average_age
from Employees e1, Employees e2
where e1.employee_id = e2.reports_to
group by e1.employee_id
order by e1.employee_id;  

/*31*/
select employee_id, department_id from Employee
where employee_id in (select employee_id from Employee group by employee_id having count(*) = 1)
or primary_flag = 'Y';

/*32*/
select x, y, z, if(x + y > z and x + z > y and y + z > x,"Yes","No") as triangle
from Triangle;

/*33*/
select l1.num as ConsecutiveNums 
from Logs l1, Logs l2, Logs l3 
where l1.num = l2.num and l2.num = l3.num and l1.id + 1 = l2.id and l2.id + 1 = l3.id
group by l1.num;

/*34*/
select product_id, new_price as price from Products where (product_id,change_date) in (select product_id, max(change_date) from Products where change_date <= '2019-08-16' group by product_id)
union
select distinct product_id, 10 as price from Products where product_id not in (select product_id from Products where change_date <= '2019-08-16');

/*35*/
select T.person_name
from (select sorted.person_name as person_name, (@w := @w + sorted.weight) as cWeight 
      from (select @w := 0) foo, (select * from Queue order by turn) sorted 
      order by cWeight desc) T
where T.cWeight <= 1000 limit 1;

/*36 (Tricky)*/
/* Here do union for 3 categories and count() them each for the salary */
select "High Salary" as category, count(*) as accounts_count from Accounts where income > 50000
union
select "Average Salary" as category, count(*) as accounts_count from Accounts where income <= 50000 and income >= 20000
union
select "Low Salary" as category, count(*) as accounts_count from Accounts where income < 20000;

/*37*/
select employee_id 
from Employees 
where salary < 30000 and manager_id not in (select employee_id from Employees)
order by employee_id;

/*38*/
select if(mod(id,2) = 1 and id = T.total,id,if(mod(id,2) = 1,id+1,id-1)) as id, student 
from (select count(*) as total from Seat) T, Seat 
order by id; 

/*39*/
(select U.name as results from Users U, MovieRating M
where U.user_id = M.user_id
group by U.user_id
order by COUNT(*) desc, U.name asc limit 1)
union all
(select Mv.title from Movies Mv, MovieRating M
where Mv.movie_id = M.movie_id and M.created_at <= '2020-02-29' and M.created_at >= '2020-02-01'
group by Mv.movie_id
order by AVG(M.rating) desc, Mv.title asc limit 1);

/*40*/
select T.visited_on, T.total as amount, ROUND(T.total / 7, 2) as average_amount
from (select c1.visited_on, (select SUM(amount) from Customer c2 where datediff(c1.visited_on,c2.visited_on) < 7 and  c1.visited_on >= c2.visited_on) as total from Customer c1
      group by c1.visited_on) T,
      (select min(visited_on) as MinDate from Customer) Md
where datediff(T.visited_on,Md.MinDate) >= 6;

/*41*/
select UID.id, COUNT(*) as num
from ((select distinct requester_id as id from RequestAccepted)
       union
      (select distinct accepter_id as id from RequestAccepted)) UID,
RequestAccepted ra
where UID.id = ra.requester_id or UID.id = ra.accepter_id
group by UID.id
order by num desc limit 1;

/*42*/
select ROUND(SUM(T.tiv_2016),2) as tiv_2016
from (select i1.pid, i1.tiv_2016 
from Insurance i1, Insurance i2
where i1.tiv_2015 = i2.tiv_2015 and i1.pid != i2.pid and (i1.lat,i1.lon) not in (select i3.lat, i3.lon from Insurance i3 where i1.pid != i3.pid)
group by i1.pid) T;

/*43 (Tricky)*/
/* We have dense_rank() function that assigns the same rank on the 'order by' if they are the same based upon partitioning it for every department*/
select Department, Employee, Salary
from (
    select e.name as Employee, e.salary as Salary, d.name as Department, dense_rank() over (partition by d.id order by e.salary desc) Ranking
    from Employee e inner join Department d
    on e.departmentId = d.id
) Query
where Ranking <= 3;
