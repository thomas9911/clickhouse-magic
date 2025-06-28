-- on mysql

insert into table1 values (4, "hallo");

-- on clickhouse

insert into table1_postgres select * from table1_mysql;



