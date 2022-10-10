delimiter //
create trigger invoice
before insert on appointment
for each row
BEGIN
  set @money = new.price;
  insert into invoice values (null, date(now()), adddate(now(), interval 2 month), 'a', @money, 'u');
  set new.fkInvoice = LAST_INSERT_ID();
END//