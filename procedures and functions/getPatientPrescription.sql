delimiter //
create procedure getPatientPrescription(in patientId varchar(10)) 
begin
select concat(sf.fname, " ", sf.lname) as doctorName, 
concat(p.fname, " ", p.lname) as patientName,
i.`date` as onDate,
i.memo as memo,
me.medicineName as medicineName,
ps.instruction as doctorInstruction
from inquiry i 
inner join doctor d 
on i.fkDoctor = d.pkDoctor 
inner join staff sf 
on d.fkStaff = sf.pkStaff 
inner join patient p
on i.fkPatient = p.pkPatient
inner join diagnosis di
on di.fkInquiry = i.pkInquiry
inner join prescription ps
on ps.fkDiagnose = di.pkDiagonsis
inner join medicine me
on ps.fkMedicine = me.pkMedicine
where p.pkPatient = patientId;
end//
