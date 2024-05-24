show databases

use employees;

use test;

use shopdb;

use mysql;

select * from employees;

use employees;

select * from titles;

select first_name from employees;
select first_name, last_name from employees;



desc employees;

select first_name, gender from employees;

select first_name as 이름, gender 성별, hire_date '화사 입사일' from employees

                                                                show databases ;

create database sqldb;
use sqldb;
create table usertbl(
                        userid char(8) not null primary key ,
                        name varchar(10) not null ,
                        birthYear int not null,
                        addr char(2) not null,
                        mobile1 char(3),
                        mobile2 char(8),
                        height smallint,  # smallint : byte 크기가 작은 정수형
    mDate date
)char set = 'utf8';

create table buytbl(
                       num int not null auto_increment primary key,
                       userid char(8) not null,
                       prodName varchar(20) not null,
                       groupName varchar(20),
                       price int,
                       amount smallint,
                       foreign key(userid) references usertbl(userid)
) char set = 'utf8';

drop table usertbl;
drop table buytbl;

insert into usertbl values ('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-8-8');
insert into usertbl values ('KBS', '김범수', 1979, '경남', '011', '22222222', 173, '2013-3-3');
insert into usertbl values ('KKH', '김경호', 1971, '전남', '019', '33333333', 177, '2009-2-2');
insert into usertbl values ('JYP', '조용필', 1950, '경기', '011', '44444444', 166, '2010-10-10');
insert into usertbl values ('SSK', '성시경', 1979, '서울', '011', '55555555', 186, '2012-5-5');
insert into usertbl values('LJB','임재법',1985,'경기','011','66666666',174,'2013-12-12');



insert into buytbl values (null, 'LSG', '볼펜', '문구', 1000, 5);
insert into buytbl values (null, 'LSG', '연필', '문구', 500, 3);
insert into buytbl values (3, 'LSG', '책', '교재', 10000, 2);
insert into buytbl values (4, 'KBS', '노트', '문구', 2000, 3);
insert into buytbl values (5, 'KBS', '샤프', '문구', 3000, 2);
insert into buytbl values (6, 'KKH', '샤프심', '문구', 1000, 5);
insert into buytbl values (7, 'KKH', '지우개', '문구', 800, 3);
insert into buytbl values (8, 'JYP', '필통', '문구', 2500, 2);
insert into buytbl values (9, 'LJB', '색연필', '문구', 3000, 1);
insert into buytbl values (10, 'LJB', '필통', '문구', 3000, 2);

use sqldb;
select * from usertbl;

select * from usertbl where name = '김경호';

select * from usertbl where birthYear >= 1970 and height >= 182;
select * from usertbl where birthYear >= 1970 or height >= 182;

select name from usertbl where height >= 180 and height <= 183;
select name from usertbl where height between 180 and 183; # between : 범위를 지정하여 조회

select name, addr from usertbl where addr ='경남' or addr = '전남' or addr = '경북';
select name, addr from usertbl where addr in ('경남', '전남', '경북'); # in : 여러개의 조건을 한번에 조회

select name, height from usertbl where name like '김%'; # like : 특정 문자열을 포함하는 데이터 조회
select name, height from usertbl where name like '_종신'; # _ : 한글자를 의미

select name, height from usertbl where height > 177;
select name, height from usertbl
where height > (select height from usertbl where name = '김경호'); # 서브쿼리

select name, height from usertbl
where height > (select height from usertbl where addr = '경남'); # 두개의 값이 반환이 되면 에러가 발생

select name, height from usertbl
where height > any(select height from usertbl where addr = '경남'); # 두개의 값이 반환이 되면 에러가 발생하지 않음

select name, height from usertbl
where height > all(select height from usertbl where addr = '경남'); # 모든 값이 조건을 만족해야 함

select name, height from usertbl
where height > some(select height from usertbl where addr = '경남'); # 하나의 값이라도 조건을 만족하면 됨

select name, height from usertbl
where height in(select height from usertbl where addr = '경남'); # in과 서브쿼리 사용 가능


select name, mDate from usertbl order by usertbl.mDate DESC ; # DESC : 내림차순

select name, height from usertbl order by height desc, name asc ; # desc : 내림차순, asc : 오름차순

select addr from usertbl;

select addr from usertbl order by addr; # 오름차순

select distinct addr from usertbl; # 중복된 값은 하나만 출력

use employees;

select emp_no, hire_date from employees
order by hire_date ASC ;

select emp_no, hire_date from employees
order by hire_date ASC
    limit 5; # limit : 출력할 행의 수를 제한

select emp_no, hire_date from employees
order by hire_date ASC
    limit 0,5; # limit : 출력할 행의 수를 제한 (0부터 5까지)

use sqldb;

create table buytbl2 (select * from buytbl); # buytbl 테이블을 복사하여 buytbl2 테이블 생성

select * from buytbl2;

create table buytbl3 (select userid, prodName from buytbl); # buytbl 테이블의 일부 컬럼만 복사하여 buytbl3 테이블 생성
select * from buytbl3;
# 테이블을 복사를 할 수있다. 하지만 PK 이나 FK 등의 제약조건은 복사되지 않는다.


select userid, amount
from buytbl
order by userid;


select userid, sum(amount) from buytbl group by userid; # group by : 그룹별로 데이터를 묶어서 조회

select userid as '사용자 아이디', sum(amount) as '총 구매 개수'
from buytbl group by userid;

select userid as '사용자 아이디', sum(price * amount) as '총 구매 개수'
from buytbl group by userid;

select avg(buytbl.amount) as '평균 구매 개수' from buytbl; # avg : 평균값을 조회

select name, max(usertbl.height) , min(usertbl.height) from usertbl; # max : 최대값, min : 최소값
# 구분을 하기가 어렵다.

select name, max(usertbl.height), min(usertbl.height) from usertbl group by name; # group by : 그룹별로 데이터를 묶어서 조회 하지만 name으로 묶었기 때문에 name으로 묶인다. 그리고 구분을 하기가 어렵다.

select name,usertbl.height from usertbl
where height = (select max(height) from usertbl) or height = (select min(height) from usertbl); # 서브쿼리를 사용하여 최대값과 최소값을 조회 할 수 있다. 이렇게 작성을 하면 구분이 쉽다.

select count(*) from usertbl; # count : 데이터의 개수를 조회

select count(usertbl.mobile1) as '휴대폰이 있는 사용자' from usertbl; # null 값은 제외하고 조회

use sqldb;

select userid as '사용자', sum(price * amount) as '총 구매 금액'
from buytbl group by userid;

select userid as '사용자', sum(price * amount) as '총 구매 금액'
from buytbl
group by userid
having sum(price * amount) > 1000;
# having 절은 무조건 group by 절 뒤에 와야 한다.
# group by 절로 묶은 데이터에 조건을 걸어서 조회 할 수 있다.

#추가로 총 구매액이 적은 사용자부터 나타내려면 order by 절을 사용하면 된다.

select userid as '사용자', sum(price * amount) as '총 구매 금액'
from buytbl
group by userid
having sum(price * amount) > 1000
order by sum(price * amount) ;
# order by 디폴트 값은 오름차순이다. 오름차순은 수가 작은 것부터 나타낸다. ASC를 사용하면 오름차순으로 나타낸다.
# 내림차순은 수가 큰 것부터 나타낸다. DESC를 사용하면 내림차순으로 나타낸다.

# RollUp
select num, buytbl.groupName, sum(price * amount) as '비용'
from buytbl
group by buytbl.groupName , num with rollup;  # rollup : 그룹별로 데이터를 묶어서 조회 하지만 전체 데이터를 조회 할 수 있다. 그리고 null 값이 나타난다. 그리고 num은 그룹별로 데이터를 묶어서 조회 하지만 전체 데이터를 조회 할 수 있다.

use sqldb;

create table testtbl1 (
                          id int,
                          usernName char(3),
                          age int           ) char set ="utf8";

insert into testtbl1
values (1 ,"홍길동", 25);

select * from testtbl1;

insert into testtbl1(id, userName)
values (2, "설현");

create table testtbl2
(
    id int auto_increment primary key ,
    userName char(3),
    age int
) char set = "utf8";

insert into testtbl2 values (null, '지민', 25);
insert into testtbl2 values (null, '유나', 22);
insert into testtbl2 values (null, '유경', 21);

select * from testtbl2;

alter table testtbl2 auto_increment=100; # 입력값이 100부터 입력이 된다.
insert into testtbl2
VALUES (null, '찬미', 23);

create table testtbl3
(
    id int auto_increment primary key ,
    userName char(3),
    age int
) char set = "utf8";
alter table testtbl3 auto_increment= 1000;
set @@auto_increment_increment=3;

insert into testtbl3 values (null,'나연',20),(null,'정연',18),(null,'모모',19)
select * from testtbl3;

create table testtbl4 (id int, Fname varchar(50), Lname varchar(50));
insert into testtbl4
select emp_no,first_name, last_name
from employees.employees;   # 대용량 데이터 생성 기존의 대량의 데이터를 샘플 데이터로 사용할 때 insert into...select 문으로
                                    # 아주 유용하게 가져올수 있다.

use sqldb;
select * from testtbl4;



