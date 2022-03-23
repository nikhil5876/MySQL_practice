show databases;
use test_db;

select * from emp;

SELECT empno, ename from emp where job = 'CLERK' and deptno = 20;

select ename, deptno from emp where sal > 1000;

select ename from emp where deptno = 20;

 SELECT empno, ename from emp where job = 'MANAGER';
 
 SELECT empno, ename from emp where job = 'CLERK' and deptno = 20;
 
  select ename,sal from emp where sal > 1000 and sal < 2000;
  
select ename from emp where job = 'ANALYST' or job = 'SALESMEN';

select ename from emp where job != 'ANALYST';

select ename from emp where empno IN (7369,7521,7839,7934,7788);

select ename from emp where deptno NOT IN (30,10);


select ename,sal from emp where sal BETWEEN 1000 AND 2000;

select ename from emp where hiredate NOT BETWEEN '1981-06-30' AND '1981-12-31';

select ename from emp where hiredate NOT BETWEEN '1981-6-30' AND '1981-12-31';

select ename from emp where mgr IS null;

select ename from emp where comm IS NOT null;

select ename from emp where ename LIKE 'S%';

select ename from emp where ename LIKE '__R%';

select ename from emp where ename LIKE '_____';

select ename from emp order by sal asc;

select ename, sal,deptno from emp order by deptno asc, sal desc;

select ename, sal,deptno from emp order by 3 asc, 2 desc;

select truncate(123.4567,2);

select round(123.4567,2);

select round(123.4567,-1);

select round(123.4567,-2);

select count(empno) from emp;

select sum(sal) from emp;

select ename, max(sal) from emp where job='salesman';

select deptno, count(ename) from emp group by deptno;

select deptno, sum(sal) from emp group by deptno;

use test_db;

SELECT job,SUM(sal), MAX(sal)
FROM emp
WHERE deptno = 20
GROUP BY job
HAVING SUM(sal) > 5000;


#SELECT TRIM (LEADING 'ab' FROM 'ababacdab');

SELECT LTRIM('  s  sdfasda    s  ');
SELECT rTRIM('  s  sdfasda    s  ');

#alignment puropse
SELECT ename, rpad(ename,15,' '), sal ,lpad(sal,10,' ') from emp;

select concat(ename, sal, hiredate, job) from emp;



select concat_ws(', ',ename, sal, hiredate, job) from emp;

#use for searching purpose
select * from emp where soundex(ename) = soundex('skot');

# try to avoide function in query.

#date time functions
SELECT date_add('2018-05-01', INTERVAL 1 DAY);

select current_timestamp(), date_add(current_timestamp(), interval 5 minute);


select current_timestamp(), date_add(current_timestamp(), interval -5 minute);


select current_timestamp() < date_add(current_timestamp(), interval 5 minute);

SELECT datediff('2007-12-31','2007-12-29');

#SELECT addtime('2007')

SELECT LAST_DAY('2020-02-15'),LAST_DAY('2020-03-12'),LAST_DAY('2020-04-13'),LAST_DAY('2020-05-14');

SELECT current_timestamp(), date_format(CURRENT_TIMESTAMP(),'%d-%m-%y');


SELECT current_timestamp(), date_format(CURRENT_TIMESTAMP(),'%m-%d-%y');

#weekday name
SELECT current_timestamp(), date_format(CURRENT_TIMESTAMP(),'%W');

#day of the week
SELECT current_timestamp(), date_format(CURRENT_TIMESTAMP(),'%w');

#hour
SELECT current_timestamp(), date_format(CURRENT_TIMESTAMP(),'%H');

#AM or PM
SELECT current_timestamp(), date_format(CURRENT_TIMESTAMP(),'%p');

SELECT current_timestamp(), date_format(CURRENT_TIMESTAMP(),'%Y');


SELECT current_timestamp(), date_format(CURRENT_TIMESTAMP(),'%U');

SELECT current_timestamp(), date_format(CURRENT_TIMESTAMP(),'%u');

select ename,hiredate from emp where date_format(hiredate,'%Y') = "1981";

#select ename, datediff(hiredate,date_format(timestamp,'%y-%m-%d')) from  emp;

#select ename, datediff(yyyy,curdate(),hiredate) from  emp;

select * from emp where YEAR(hiredate) = 1981;
select * from emp where hiredate LIKE '1981-%';

select * from emp where date_format(hiredate,'%Y') = '1981';

select * from emp where hiredate BETWEEN '1981-01-01' and '1981-12-31';

#this is the best solutions
select * from emp where hiredate BETWEEN str_to_date('1981-01-01','%Y-%m-%d') and str_to_date('1981-12-31','%Y-%m-%d');



select ename,hiredate,datediff(CURDATE(),hiredate ) from emp;
# above is good solution
select ename,hiredate,datediff(current_timestamp(),hiredate) from emp;

select ename,hiredate,(YEAR(CURDATE()) - YEAR(hiredate) ) from emp;


#List the employees who have joined com 25 years back.
select ename,hiredate,(YEAR(CURDATE()) - YEAR(hiredate)) from emp where (YEAR(CURDATE()) - YEAR(hiredate))>25;

#IFNULL
select ename,sal,comm,ifnull(comm,0),sal+comm as tot_sal from emp;


select ename,sal,comm,ifnull(comm,0),sal+comm,sal+ifnull(comm,0) as tot_sal from emp;

#COALESCE PRE
select ename,sal,comm,ifnull(comm,0),sal+comm,sal+COALESCE(comm,0) as tot_sal_COALESCE from emp;


#CASE

SELECT ename, 
CASE job
	when 'CLERK' THEN 'ADMINISTAFF'
	WHEN 'MANAGER' THEN 'EXECUTIVE'
	WHEN 'ANALYST' THEN 'RNDSTAFF'
	else job
END AS job_d
FROM 	emp;

#or

SELECT ename, 
CASE job
	when job='CLERK' THEN 'ADMINISTAFF'
	WHEN job='MANAGER' THEN 'EXECUTIVE'
	WHEN job='ANALYST' THEN 'RNDSTAFF'
	else job
END AS job_d
FROM 	emp;

#or

SELECT ename, 
CASE
	when job='CLERK' THEN 'ADMINISTAFF'
	WHEN job='MANAGER' THEN 'EXECUTIVE'
	WHEN job='ANALYST' THEN 'RNDSTAFF'
	else job
END AS job_d
FROM 	emp;


SELECT ename, sal,
CASE 
	when sal<1000 THEN 'VL'
	WHEN sal between 1000 and 2000 THEN 'L'
    WHEN sal between 2000 and 3000 THEN 'M'
    WHEN sal between 3000 and 4000 THEN 'H'
    WHEN sal>4000 THEN 'VH'
END AS sal_s
FROM 	emp;

#or
SELECT ename, sal,
CASE 
	when sal<=1000 THEN 'VL'
	WHEN sal <= 2000 THEN 'L'
    WHEN sal <= 3000 THEN 'M'
    WHEN sal <= 4000 THEN 'H'
    ELSE 'VH'
END AS sal_s
FROM 	emp;

SELECT ename, sal,
CASE
	when job='CLERK' THEN sal * 1.1
    WHEN job = 'SALESMAN' THEN sal * 1.15
	WHEN job='MANAGER' THEN sal * 1.2
	WHEN job='ANALYST' THEN sal * 1.25
	else sal * 1.3
END AS job_d
FROM 	emp;

#joins

#cross joins
select empno,ename,sal,emp.deptno,dept.deptno,dname,loc 
from emp, dept;

select e.empno,e.ename,e.sal, e.deptno, d.deptno,d.dname,d.loc 
from emp e CROSS JOIN dept d;

#equi joins

select empno,ename,sal, emp.deptno, dept.deptno,dname,loc 
from emp INNER JOIN  dept 
ON emp.deptno = dept.deptno
;

#outer join

# RIGHT outer join
select empno,ename,sal, emp.deptno, dept.deptno,dname,loc 
from emp RIGHT OUTER JOIN  dept 
ON emp.deptno = dept.deptno;

#LEFT outer join
select empno,ename,sal, emp.deptno, dept.deptno,dname,loc 
from emp LEFT OUTER JOIN  dept 
ON emp.deptno = dept.deptno;

show databases;
use test_db;

#natural join
select empno,ename,sal, emp.deptno, dept.deptno,dname,loc 
from emp Natural JOIN  dept ;

#self join  alises are mandetory
select e.empno,e.ename,e.sal,e.job, e.mgr, m.empno,m.ename,m.job ,m.mgr
from emp e, emp m 
where  e.mgr = m.empno ;

#INNER JOIN
select e.empno,e.ename,e.sal,e.job, e.mgr, m.empno,m.ename,m.job ,m.mgr
from emp e INNER JOIN emp m 
ON  e.mgr = m.empno;

select empno,ename, sal, emp.deptno, dept.deptno, dname,loc
from emp INNER JOIN dept
USING  (deptno);


select * from salgrade;


select ename, sal, grade
from emp, salgrade
where sal >= losal and sal <= hisal;

select ename, sal, grade
from emp INNER JOIN salgrade
ON sal >= losal and sal <= hisal;

select ename, sal,grade, dname,loc
from emp e, dept d, salgrade s
where e.deptno = d.deptno and e.sal >= s.losal and e.sal <= s.hisal;

select ename, sal, grade, dname, loc
from emp e INNER JOIN  dept d 
ON e.deptno = d.deptno
INNER JOIN salgrade s
ON  e.sal  BETWEEN s.losal and s.hisal; # join more than two tables
#or
select ename, sal, grade, dname, loc
from emp e INNER JOIN  dept d 
ON e.deptno = d.deptno
INNER JOIN salgrade s
ON  e.sal where e.sal BETWEEN s.losal and s.hisal;

#union ope

select distinct job from emp where deptno = 20
union
select distinct job from emp where deptno = 30;


#1
select * from dept
where detpno = 
(select deptno from emp
where ename = 'MILLER');

#2


#3
select * from emp 
where sal >
(select avg(sal) from emp
having deptno = 10);

#4
select ename from emp
where hiredate !=
(select min(hiredate) from emp
where job='CLERK');


#
select * from emp 
where deptno = 10 and  job IN
(select job from emp
where deptno = 30);


#select * from emp 
#where exists 
#(select count(ename) from emp
#where deptno = 20);

select * from emp 
where exists 
(select 1 from emp
where deptno = 20
having count(*)>4);   #having count(*) creates a scondition for the sub quey, whether it is exist or not.



select * from emp 
where exists
(select deptno
from emp
where deptno = 20
group by deptno
having count(*) > 2);

select * from emp 
where 
(select count(*)
from emp
where deptno = 20) > 2;

select * from emp
where sal = 
(select max(sal) from emp);


#select  distinct sal from emp
#order by sal 
#(select  distinct sal from emp
#order by sal desc);

select * from emp where sal =
(select max(sal) from emp where sal <
(select max(sal) from emp));

select * from emp order by sal desc limit 1,2; # specific for mysql limit M,N skip M records show next N records.

select distinct sal from emp order by sal desc limit 1,2;


# Mth highest sal
select * from emp where sal = 
(select distinct sal from emp order by sal desc limit 3,1);

#3 highest earners
#select * from emp where sal in
#(select sal from emp order by sal desc limit 3);

select empno, ename, sal, deptno, max(sal)
from emp
group by deptno;

select empno, ename, sal, e.deptno, max_sal
from emp E,
(select deptno, MAX(sal) max_sal from emp group by deptno) a
where E.deptno = a.deptno
order by deptno;


#highest sal from dept
select * from emp where sal in
(select max(sal) from emp group by deptno);
#
#get  highest sal of deptno = 10
select max(sal) from emp where deptno = 10;

select deptno,job, max(sal) from emp group by deptno;


select * from emp e,
(select avg(sal) aas, deptno from emp group by deptno) p
where e.sal > p.aas and p.deptno = e.deptno;

#select manager to whome most people visited
select * from emp e,
(select mgr,count(mgr) cn from emp group by mgr order by cn desc limit 1) n
where e.empno = n.mgr;

select * from emp where empno IN 
(select mgr from emp
group by mgr
having count(mgr) = 
(select max(cnt) from 
(select count(mgr) cnt from emp group by mgr) A));




select * from emp where empno = 7900;

########Analytical functions

select  row_number() over(), empno, ename, sal, deptno  #generate pagging result
from emp;


select * from
(select  row_number() over() as rn, empno, ename, sal, deptno
from emp) A 
where rn between 5 and 10;

select rank() over(order by sal desc) rnk,
dense_rank() over(order by sal desc) drnk, empno, ename, sal, deptno
from emp;

select empno , ename,job,sal,deptno, sum(sal)
from emp
group by deptno;

#without analytic
select e.*, sum_sal
from (select deptno, sum(sal) as sum_sal
from emp group by deptno) a INNER JOIN emp e
ON e.deptno = a.deptno
order by deptno;
#with analytic => power
select e.*, sum(sal) over(partition by deptno) sum_sal
from emp e;
#or
select emp.*, sum(sal) over(partition by deptno) sum_sal
from emp;
#or
select emp.*, sum(sal) over(order by deptno,ename) as cum_sum  #sumation is in different manner 
from emp;

#department wise 
select emp.*, sum(sal) over(partition by deptno order by deptno,ename) as cum_sum  #sumation is in different manner 
from emp;

#lag(),lead()

select deptno,ename,sal,
lag(sal) over(order by sal) as prev_sal,
sal- lag(sal) over(order by sal) as diff
from emp;

select deptno,ename,sal,deptno,
lag(sal) over(order by sal) as prev_sal,
sal- lag(sal) over(partition by deptno order by sal) as diff
from emp;


#################################create table##########################


create table test2(
a decimal(4),
b varchar(10),
c decimal(7,2),
d decimal(2),
constraint pk_test2_a primary key(a),
constraint unq_test2_b  unique(b),
constraint chk_test2_c check(c > 1000),
constraint fk_test2_d_dept_deptno foreign key(d) references dept(deptno));


desc test2;

insert into test2 values(101,'ABCD',500,20);
insert into test2 values(102,'ABCDE',1200,50); # not wotking because of foreign key constraint
desc test2;

select * from test2;

select version();

alter table test2 ADD COLUMN e DATE;

select * from test2;

alter table test2 drop COLUMN e;

alter table test2 drop constraint unq_test2_b;

show tables;

create temporary table temp1 (a decimal(3), b varchar(20));

#########################VIEWS######################
create view dept20 as 
select * from emp 
where deptno = 20;

select * from dept20;

create view empview as 
select empno,ename,sal,e.deptno, d.dname 
from emp e INNER JOIN dept d
ON d.deptno = e.deptno;

select * from empview;

describe empview;


create or replace view empview (eno,ename,sal,dno,dname) as 
select empno,ename,sal,e.deptno, d.dname 
from emp e INNER JOIN dept d
ON d.deptno = e.deptno;

select * from empview;
desc empview;

#create a view of emp of dept no = 10
#create view empview10 as 
select * 
from empview 
where dno = 10;

select * from empview10;

create or replace view emp20 as 
select empno, ename, sal, deptno from emp where deptno = 20
with check option; #don't allow to update deptno 

update emp20 set deptno = 30 where empno = 7369;

create table empl
(empno decimal(4),
ename varchar(12),
sal decimal(7,2),
deptno integer)
partition by list(deptno)
(partition p1 values in(10),
partition p2 values in(20),
partition p3 values in(30));

insert into empl select empno, ename, sal, deptno from emp;

explain select * from empl where deptno = 20; # shows execution plans



create table empr
(empno decimal(4),
ename varchar(12),
sal decimal(7,2),
deptno integer)
partition by range(sal)
(partition p1 values less than (10),
partition p2 values less than(20),
partition p3 values less than maxvalue);

explain select * from empr where sal < 1000;


create table empr2
(empno decimal(4),
ename varchar(12),
sal integer,
deptno integer)
partition by range(sal)
(partition p1 values less than (10),
partition p2 values less than(20),
partition p3 values less than maxvalue);

explain select * from empr2 where sal < 1000;




#########################day 6####################






#write a procedure to AddEmp to insert a new emp




delimiter //
create procedure AddNum( p_num1 decimal(4), p_num2 decimal(4))
BEGIN
	declare v_sum  decimal(5);
    set v_sum = p_num1 + p_num2;
    select v_sum;
end;
//

call AddNum(56,23);



drop procedure AddEmp

delimiter //
create procedure AddEmp1( p_empno decimal(4,0), p_ename varchar(10), p_deptno decimal(2,0))
BEGIN
	INSERT INTO emp (empno,ename,deptno) values (p_empno,p_ename, p_deptno);
    -- commit
end;
//

call AddEmp1(2211,'Milind',30);


##############################################
drop procedure UpdtComm;

delimiter //
create procedure UpdtComm( p_empno decimal(4,0))
BEGIN
	
	declare v_comm decimal(5,0);
	select comm into v_comm from emp where empno = p_empno;
    start transaction;
    IF (v_comm is null) then
		update emp set comm = 500 where empno = p_empno;
	else
		update emp set comm = comm*1.25 where empno = p_empno;
    
    end if;
    
end;
--commit;
//

call UpdtComm(2211);

####################################################
#shows defination of method.
show create procedure AddNum;

####################################################

drop procedure test_loop;
delimiter //
create procedure test_loop(p_itr decimal(4))
begin
 declare v_cnt decimal(4) default 1;
 loop1:LOOP
 select v_cnt;
 set v_cnt = v_cnt + 1;
 if v_cnt > 5 then
 leave loop1;
 end if;
 end loop;
 end;
//

call test_loop(10);

#######################################################
#### REPEAT UNTILL#####################################

#drop procedure test_loop;
drop procedure test_loopR;
delimiter //
create procedure test_loopR(p_itr decimal(4))
begin
 declare v_cnt decimal(4) default 1;
 loop1:REPEAT
 select v_cnt;
 set v_cnt = v_cnt + 1;
 UNTIL v_cnt >= p_itr END  repeat;
 end;
//

call test_loopR(10);

##########################################

###    While Loop ########################


##########################################

###    IN OUT INOUT ######################
delimiter //
create procedure AddMul(p_num decimal(4), INOUT p_add decimal(4), out p_mul decimal(5))
begin
	set p_mul = p_num * p_add;
    set p_add = p_num + p_add;
end;
//

set @v_num = 12;
set @v_add = 15;
set @v_mul = 0;
select @v_num;

call AddMul(@v_num, @v_add, @v_mul);

select concat('addition is ',@v_add);
select 'addition is ',@v_add;
select 'multiplication is ',@v_mul;
select 'num is ',@v_num;


#############################################################################
drop procedure Info;

delimiter //
create procedure Info(p_empno decimal(4), OUT p_name varchar(10), out p_doj date)

begin
	#declare v_name varchar(10);
    #declare v_doj date;
	select ename,hiredate into p_name, p_doj from emp where empno = p_empno; 
end;
//

set @v_name = 'Nik';
set @v_doj = curdate();
select @v_name,@v_doj;

call Info(7369, @v_name, @v_doj);


############### Functions #############################
drop function sal_class;

delimiter //
create function sal_class (p_empno decimal(4))
returns  varchar(10)
deterministic
begin
	declare message1 varchar(10);
    declare sal1 decimal(7,2);
	select sal into sal1 from emp where empno = p_empno;
    if sal1 is null then
		set message1 = 'NOT APPLICABLE';
	elseif sal1 <3000 then
		set message1 = 'LOW';
    elseif sal1 <5000 then
		set message1 = 'MEDIUM';
	else
		set message1 = 'HIGH';
	end if;	
	return message1;    
end;
//

select sal_class(7369);
select sal_class(7839);

############## Condition Handling ############
drop procedure addemp;
delimiter //
create procedure AddEmp(p_empno decimal(4), p_ename varchar(12), p_deptno decimal(2))
begin
	declare continue handler for 1062
    select p_empno, ' Employee already present';
    declare continue handler for 1452 select 'Parent value not found.'; ## instead of 'continue' we can use 'exit'
    insert into emp (empno, ename, deptno)
    values(p_empno, p_ename, p_deptno);
end;
//

call  addemp(7900,'milind',10);
call  addemp(7901,'milind',50);

################################################
##recheck it
drop procedure addemp;

delimiter //
create procedure addemp(p_empno decimal(4), p_ename varchar(12), p_deptno decimal(2))
begin
	declare v_err_num decimal(5);
    declare v_err_msg varchar(200);
    declare continue handler for sqlexception
    begin
		get diagnostics condition 1 v_err_num = mysql_errno,
        e_err_msg = message_text;
        select v_err_num, v_err_msg, now(), user(), p_empno, p_deptno;
        -- insert into err_log....;
	end;
insert into emp(empno, ename, deptno)
values(p_empno, p_ename, p_deptno);
end;
//

###################################################
######### TRIGGERS #######################
delimiter // 
create trigger invalid_sal
before update
on emp
for each row
begin
	if (new.sal < 500) then
		signal sqlstate '80000'
        set message_text = 'Salary of employee cannot be less than 500';
	end if;
end;
//
##############################

delimiter // 
create trigger emo_hist
before update
on emp
for each row
begin
	if (new.sal < 500) then
		signal sqlstate '80000'
        set message_text = 'Salary of employee cannot be less than 500';
	end if;
end;
//

delimiter // 
create trigger tot_sal
before update
on emp
for each row
begin
	if (new.sal < 500) then
		signal sqlstate '80000'
        set message_text = 'Salary of employee cannot be less than 500';
	end if;
end;
//

