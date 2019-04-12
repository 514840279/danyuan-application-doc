-- 查询数据库默认的编码字符集：
select parameter, value from nls_database_parameters where parameter like 'NLS_CHARACTERSET';
