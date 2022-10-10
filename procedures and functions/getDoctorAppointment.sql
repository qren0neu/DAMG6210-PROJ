delimiter //
create procedure getDoctorAppointment(in staffId varchar(10), in workDay date) 
begin select concat(sf.fname, " ", sf.lname) as doctorName, 
s.fromTime as fromTime, 
s.toTime as toTime, 
a.appointmentTime as appointmentTime,  
concat(p.fname, " ", p.lname) 
as patientName 
from appointment a 
inner join schedule s 
on a.fkSchedule = s.pkSchedule 
inner join doctor d 
on s.fkDoctor = d.pkDoctor 
inner join staff sf 
on d.fkStaff = sf.pkStaff 
inner join patient p 
on a.fkPatient = p.pkPatient 
where s.status = 'a'  and sf.pkStaff = staffId and workDay = date(fromTime); 
end//
