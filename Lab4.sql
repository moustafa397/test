use Company
go

/*
1.	Alter Employee table and add column named "Code", use cursor to insert values in this column starts from 1, and increased by one to the end of table. So user can select from the table No. That is  in sequence and employee name.

2.	Create stored procedure that wraps the previous cursor (for re-inserting the serial numbers in the column after delete operation, and refill it to remove gaps).

a.	Remove some records from the middle of the table, and recall the procedure (make sure that the data in the new column refilled to be serialled again)

*/

alter table employee 
add code nvarchar(20)



create proc st_inserting
as
begin

declare  C_update_code cursor
for select SSN from Employee
for update
open C_update_code
begin
declare @id int,@emp nvarchar(20),@count int
set @emp = 'Emp'
set @count = 1
fetch C_update_code into @id
while @@FETCH_STATUS = 0
	begin 
		update Employee
		set Code = @emp + '___'+ Str(@count) 
		Where SSN = @id

		Fetch C_update_code into @id
		set @count = @count+1
		
	end
end
close C_update_code
deallocate C_update_code
end

create trigger Tr_inserting
on employee
after delete
as
begin
execute  st_inserting
end

delete from Employee
where SSN = 116114
select * from Employee

--3.Create a clustered index on the Employee table (EmpNo column).
-- can not create a clustered index on the Employee table because it has a primary key (SSN)




