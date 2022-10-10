create view departmentStaffNumberView as 
select count(pkStaff) as staffNumber, name from staff s 
left join department d 
on s.fkDepartment = d.pkDepartment
group by s.fkDepartment
order by staffNumber desc