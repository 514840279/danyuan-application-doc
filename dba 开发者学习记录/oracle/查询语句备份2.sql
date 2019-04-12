-- 不是date的表 要修改成date行的
select * from vw_table_column_comments t
where t.列名称 in( '入库时间')
and t.列类型<> 'DATE' 
and t.表名称 not like 'TPL%';

-- 是date的表 修改varchar 行
select * from vw_table_column_comments t
where 1=1
--and t.column_name in( 'STIME','INSERT_DATE','UPDATE_DATE','成立日期','采集时间','更新时间')
and t.列类型= 'DATE'
and t.列名称 not in('入库时间');

