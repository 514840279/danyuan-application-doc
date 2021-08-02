create or replace function fn_gzk_sbyys(in_v1 varchar2) return varchar2 is
  --识别运营商
  out_cs varchar2(50);
begin
  select case
           when substr(in_v1, 1, 3) in
                ('134', '135', '136', '137', '138', '139', '141', '147',
                 '150', '151', '152', '154', '157', '158', '159', '178', '179',
                 '182', '183', '184', '187', '188') then
            '移动'
           when substr(in_v1, 1, 4) in ('1703', '1705', '1706') then
            '移动'
           when substr(in_v1, 1, 3) in
                ('133', '149', '153', '173', '177', '180', '181', '189') then
            '电信'
           when substr(in_v1, 1, 4) in ('1700', '1701', '1702') then
            '电信'
           when substr(in_v1, 1, 3) in
                ('130', '131', '132', '145', '155', '156', '175', '176',
                 '185', '186') then
            '联通'
           when substr(in_v1, 1, 4) in
                ('1709', '1708', '1707', '1710', '1711', '1712', '1713',
                 '1714', '1715', '1716', '1717', '1718', '1719') then
            '联通'
           when in_v1 is null then
            '号码为空'
           else
            '未知' || in_v1
         end
    into out_cs
    from dual;

  return out_cs;
end fn_gzk_sbyys;
/
