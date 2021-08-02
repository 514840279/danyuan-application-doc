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
            'Ħ����'
           when dnum >= 120 and dnum <= 218 then
            'ˮƿ��'
           when dnum >= 219 and dnum <= 320 then
            '˫����'
           when dnum >= 321 and dnum <= 420 then
            'ĵ����'
           when dnum >= 421 and dnum <= 520 then
            '��ţ��'
           when dnum >= 521 and dnum <= 621 then
            '˫����'
           when dnum >= 622 and dnum <= 722 then
            '��з��'
           when dnum >= 723 and dnum <= 822 then
            'ʨ����'
           when dnum >= 823 and dnum <= 922 then
            '��Ů��'
           when dnum >= 923 and dnum <= 1022 then
            '�����'
           when dnum >= 1023 and dnum <= 1121 then
            '��Ы��'
           when dnum >= 1122 and dnum <= 1221 then
            '������'
         end
    into xingzuo
    from dual;
  return xingzuo;
exception
  when others then
    return null;
end;
/
