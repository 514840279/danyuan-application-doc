create or replace function id_xingzuo(id_card in varchar2) return varchar2 is
  xingzuo varchar2(20);

  dnum number(4);
  dt   date;
  yr   varchar2(4);
begin

  if length(id_card) != 15 and length(id_card) != 18 then
    return null;
  end if;

  select decode(length(id_card), 18, substr(id_card, 11, 4), 15,
                '19' || substr(id_card, 9, 2))
    into yr
    from dual;

  dt   := to_date(yr, 'MMDD');
  dnum := to_number(to_char(dt, 'MMdd'));
  select case
           when dnum >= 1222 or dnum <= 119 then
            'Ä¦ôÉ×ù'
           when dnum >= 120 and dnum <= 218 then
            'Ë®Æ¿×ù'
           when dnum >= 219 and dnum <= 320 then
            'Ë«Óã×ù'
           when dnum >= 321 and dnum <= 420 then
            'ÄµÑò×ù'
           when dnum >= 421 and dnum <= 520 then
            '½ğÅ£×ù'
           when dnum >= 521 and dnum <= 621 then
            'Ë«×Ó×ù'
           when dnum >= 622 and dnum <= 722 then
            '¾ŞĞ·×ù'
           when dnum >= 723 and dnum <= 822 then
            'Ê¨×Ó×ù'
           when dnum >= 823 and dnum <= 922 then
            '´¦Å®×ù'
           when dnum >= 923 and dnum <= 1022 then
            'Ìì³Ó×ù'
           when dnum >= 1023 and dnum <= 1121 then
            'ÌìĞ«×ù'
           when dnum >= 1122 and dnum <= 1221 then
            'ÉäÊÖ×ù'
         end
    into xingzuo
    from dual;
  return xingzuo;
exception
  when others then
    return null;
end;
/
