use sakila;

-- 1. Write a query to find what is the total business done by each store.
select store_id, sum(amount) from  staff
join payment using (staff_id) group by store_id;

-- 2. Convert the previous query into a stored procedure.
DELIMITER //
create procedure revenue_by_store() 
begin
select store_id, sum(amount) from  staff
join payment using (staff_id) group by store_id;
end //
DELIMITER ;
call  revenue_by_store();

-- 3. 
DELIMITER //
create procedure revenue_by_store1(in param int) 
begin
select store_id, sum(amount) from  staff
join payment using (staff_id)
where store_id = param group by store_id;
end //
DELIMITER ;
call revenue_by_store1(2);

-- 4.
DELIMITER //
create procedure store_total_sales(in param int) 
begin
declare total_sales_value float default 0.0;
select sum(amount) into total_sales_value from  staff
join payment using (staff_id)
 group by store_id
 having store_id = param;
select total_sales_value;
 end //
DELIMITER ;

call store_total_sales(2);

-- 5.
DELIMITER //
create procedure store_total_sales1(in param int) 
begin
declare total_sales_value float default 0.0;
declare flag varchar(20) default "";
select sum(amount) into total_sales_value from  staff
join payment using (staff_id)
where store_id = param group by store_id;
select total_sales_value;
case
when total_sales_value > 30.000 then 
 set flag = 'green_flag';
else 
 set flag = 'red flag';
end case;
select total_sales_value, flag;
 end //
DELIMITER ;

call  store_total_sales1(1);