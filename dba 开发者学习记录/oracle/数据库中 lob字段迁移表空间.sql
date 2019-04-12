select 'alter table ' || xtable || ' move tablespace ZHCX_GAXX_DATA lob' || '(' ||
       column_name || ') store as ( tablespace ZHCX_GAXX_DATA);'
  from (select xtable, wmsys.wm_concat(column_name) column_name
          from (select owner || '.' || table_name xtable,
                       column_name,
                       tablespace_name
                  from dba_lobs
                 where tablespace_name = 'LOADTEMP')
         group by xtable)
