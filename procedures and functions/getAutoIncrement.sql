delimiter //
create function getAutoIncrement(dbname varchar(24), tablename varchar(24))
returns int
DETERMINISTIC
begin
	return (SELECT `AUTO_INCREMENT`
		FROM  INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = dbname
		AND   TABLE_NAME   = tablename);
end//