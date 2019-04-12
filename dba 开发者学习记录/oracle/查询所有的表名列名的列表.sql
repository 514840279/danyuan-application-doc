select t.TABLE_NAME,tc.comments, t.COLUMN_NAME, cc.comments 
          from user_tab_columns t
         inner join user_col_comments cc on t.TABLE_NAME = cc.table_name
                                        and t.COLUMN_NAME = cc.column_name
                                        inner join user_tab_comments tc on tc.TABLE_NAME = t.TABLE_NAME
         where t.table_name not like '%$%'
         and £¨tc.comments is not null or length( t.TABLE_NAME) <> lengthb(t.TABLE_NAME£©£©
           and (cc.comments is not null or
               length(cc.column_name) <> lengthb(cc.column_name));



select tc.table_name,tc.comments,t.num_rows from user_tables t 
inner join user_tab_comments tc on t.table_name = tc.table_name
