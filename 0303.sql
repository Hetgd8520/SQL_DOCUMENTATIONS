create table myemp (id int primary key,name varchar(20),age int);
insert into myemp(id,name,age) values(1,"het",20),(2,"neel",22),(3,"jeel",19);

ALTER TABLE conditional_table ADD COLUMN phon int;
alter table myemp add column phon int;

ALTER TABLE myemp MODIFY phon int;

ALTER TABLE myemp RENAME COLUMN phon TO number;
select * from myemp;
alter table myemp change number phon int;
