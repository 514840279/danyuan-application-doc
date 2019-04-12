--1、查看表空间的名称及大小 
select 
b.file_id 文件ID号, 
b.tablespace_name 表空间名, 
b.bytes/1024/1024||'M'字节数, 
(b.bytes-sum(nvl(a.bytes,0)))/1024/1024||'M' 已使用, 
sum(nvl(a.bytes,0))/1024/1024||'M' 剩余空间, 
100 - sum(nvl(a.bytes,0))/(b.bytes)*100 占用百分比 
from dba_free_space a,dba_data_files b 
where a.file_id=b.file_id 
group by b.tablespace_name,b.file_id,b.bytes 
order by b.file_id; 

--1、查看表空间的名称及大小 
select sum (ts_size)||'M' from (
SELECT t.tablespace_name, round(SUM(bytes / (1024 * 1024)), 0) ts_size 
FROM dba_tablespaces t, dba_data_files d 
WHERE t.tablespace_name = d.tablespace_name 
GROUP BY t.tablespace_name); 

--2、查看表空间物理文件的名称及大小 
SELECT tablespace_name, 
file_id, 
file_name, 
round(bytes / (1024 * 1024), 0) total_space 
FROM dba_data_files 
ORDER BY tablespace_name; 


--6、查看表空间的使用情况 
SELECT SUM(bytes) / (1024 * 1024) AS free_space, tablespace_name 
FROM dba_free_space 
GROUP BY tablespace_name; 
SELECT a.tablespace_name, 
a.bytes total, 
b.bytes used, 
c.bytes free, 
(b.bytes * 100) / a.bytes "% USED ", 
(c.bytes * 100) / a.bytes "% FREE " 
FROM sys.sm$ts_avail a, sys.sm$ts_used b, sys.sm$ts_free c 
WHERE a.tablespace_name = b.tablespace_name 
AND a.tablespace_name = c.tablespace_name; 


--9、查看数据库的创建日期和归档方式 
SELECT created, log_mode, log_mode FROM v$database; 
--1G=1024MB 
--1M=1024KB 
--1K=1024Bytes 
--1M=11048576Bytes 
--1G=1024*11048576Bytes=11313741824Bytes 
SELECT a.tablespace_name "表空间名", 
total "表空间大小", 
free "表空间剩余大小", 
(total - free) "表空间使用大小", 
total / (1024 * 1024 * 1024) "表空间大小(G)", 
free / (1024 * 1024 * 1024) "表空间剩余大小(G)", 
(total - free) / (1024 * 1024 * 1024) "表空间使用大小(G)", 
round((total - free) / total, 4) * 100 "使用率 %" 
FROM (SELECT tablespace_name, SUM(bytes) free 
FROM dba_free_space 
GROUP BY tablespace_name) a, 
(SELECT tablespace_name, SUM(bytes) total 
FROM dba_data_files 
GROUP BY tablespace_name) b 
WHERE a.tablespace_name = b.tablespace_name ;


-- 为数据库添加表空间（数据文件）
ALTER TABLESPACE ZHCX_DATA ADD DATAFILE
'D:\APP\ADMINISTRATOR\ORADATA\ORCL\ZHCX_DATA010.ORA' SIZE 50M
AUTOEXTEND ON NEXT 5M MAXSIZE 30000M;
