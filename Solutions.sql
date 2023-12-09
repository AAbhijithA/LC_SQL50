/* Link to Problems: https://leetcode.com/studyplan/top-sql-50/ */

/*1*/
select product_id from Products where low_fats = 'Y' and recyclable = 'Y';

/*2*/
select name from Customer where referee_id is null or referee_id != 2;

/*3*/
select name, population, area from World where population >= 25000000 or area >= 3000000;

/*4*/
select distinct author_id as id from Views where author_id = viewer_id order by author_id; 

/*5*/
select tweet_id from Tweets where content like '________________%';
/*OR*/
select tweet_id from Tweets where CHAR_LENGTH(content) > 15;

/*6*/
select U.unique_id, E.name from Employees E left join EmployeeUNI U on U.id = E.id;

/*7*/
select product_name, year, price from Sales, Product where Sales.product_id = Product.product_id;

/*8*/
select customer_id, count(*) as count_no_trans 
from Visits 
where visit_id not in (select visit_id from Transactions) group by customer_id;

/*9*/
/* datediff() is a function that returns the number of days of difference between 2 dates */
select w1.id from Weather w1, Weather w2 
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
