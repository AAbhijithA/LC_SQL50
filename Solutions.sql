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
