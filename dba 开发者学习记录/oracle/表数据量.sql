select t.table_name,tc.comments,t.num_rows from user_tables t
inner join User_Tab_Comments tc on t.table_name = tc.table_name
where T.TABLE_NAME not like 'SMP%'
and t.table_name not like 'VBZ%'
and t.table_name not like 'VMQ%'
and t.table_name not like 'VDK%'
and t.table_name not like 'EPC%'
and t.num_rows >0
