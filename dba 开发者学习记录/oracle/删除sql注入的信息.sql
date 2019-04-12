select 'truncate table '||t.table_name||'; 
drop table '||t.table_name||';' from user_tables t
where T.TABLE_NAME like 'SMP%'
or t.table_name like 'VBZ%'
or t.table_name like 'VMQ%'
or t.table_name like 'VDK%'
or t.table_name like 'EPC%';



