delimiter //
create trigger invoiceHouse
before insert on hospitalization
for each row
BEGIN
  set @hosMoney = (datediff(new.todate, new.fromdate) * new.dailyExpense);
  insert into invoice values (null, date(now()), adddate(now(), interval 2 month), 'a', @hosMoney, 'u');
  set new.fkInvoice = LAST_INSERT_ID();
END//