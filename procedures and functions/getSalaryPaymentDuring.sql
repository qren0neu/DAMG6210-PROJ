delimiter //
create procedure getSalaryPaymentDuring(in dateFrom date, in dateTo date)
begin
select count(pkStaff) as staffNumber, name, sum(p.salary) as departmentSalaryPayment
from staff s 
inner join department d 
on s.fkDepartment = d.pkDepartment
inner join salary_payment p
on s.pkStaff = p.fkStaff
where p.date < dateTo and p.date > dateFrom
group by s.fkDepartment;
end//